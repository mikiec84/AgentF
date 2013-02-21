/**
 * Created with IntelliJ IDEA.
 * User: kisalzmann
 * Date: 20.02.13
 * Time: 11:04
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.model {
    import de.mediadesign.gd1011.studiof.consts.GameConsts;
    import de.mediadesign.gd1011.studiof.events.GameEvent;
    import de.mediadesign.gd1011.studiof.services.JSONReader;

    public class FortFoxBoss extends Unit
    {
        private var timeCounter:Number = 0;
        private var idleTimeFrame:Number;
        private var upMovementRunning:Boolean = false;
        private var downMovementRunning:Boolean = false;
        private var changePosTime:Number;
        private var backMovementDistance:int;
        private var idleXPosition:int;
        private var movementSpeed:int;
        private var yOffset:int = 2;
        private var _moveLeftRunning:Boolean = false;
        private var _initialized:Boolean = false;
        private var level:Level;

        public function FortFoxBoss(currentLevel:Level)
        {
            var JSONExtractedInformation:Object = JSONReader.read("enemy")["FORT_FOX"];
            idleXPosition = JSONExtractedInformation["idleXPosition"];
            super(JSONExtractedInformation["healthpoints"],JSONExtractedInformation["startingPlatform"],0,idleXPosition, currentLevel, false);
            idleTimeFrame = JSONExtractedInformation["idleTimeFrame"];
            changePosTime = JSONExtractedInformation["changePosTime"];
            backMovementDistance = JSONExtractedInformation["backMovementDistance"];
            movementSpeed = Math.round((backMovementDistance*2)/changePosTime);
            position.x = idleXPosition+backMovementDistance;
            level = currentLevel;
            healthPoints = 10;
        }

        public function start():void
        {
            _moveLeftRunning = true;
            var a:GameEvent = new GameEvent(GameConsts.ENDBOSS);
            level.dispatcher.dispatchEvent(a);
        }

        override public function move(time:Number):void
        {   //trace("Current Platform = "+currentPlatform+", Current X = "+position.x+", Current Y = "+position.y);
            //trace("DownMovementRunning = "+downMovementRunning+", UpMovementRunning = "+upMovementRunning);
            currentPlatform = observePlatform(position.y);
            if (!upMovementRunning && !downMovementRunning && !_moveLeftRunning && _initialized)
            {   //trace(timeCounter+", "+idleTimeFrame);
                timeCounter+=time;
                if (timeCounter >= idleTimeFrame)
                {
                    timeCounter = 0;
                    if (currentPlatform == 1)
                    {
                        upMovementRunning = true;
                    }
                    else
                    {
                        downMovementRunning = true;
                    }
                }
            }
            else
            {
                if (upMovementRunning) {
                    doUpMovement(time);
                }
                if (downMovementRunning) {
                    doDownMovement(time);
                }
                if (_moveLeftRunning) {
                    doMoveLeft(time);
                }
            }
        }

        private function doMoveLeft(time:Number):void
        {
            if (position.x > idleXPosition) {
                position.x-=movementSpeed*time;
            }
            else
            {
                _moveLeftRunning = false;
                _initialized      = true;
            }
        }

        private function doDownMovement(time:Number):void
        {
            if (currentPlatform == 0 && position.x < backMovementDistance+idleXPosition)
            {
                position.x+=movementSpeed*time;
            }

            if (position.x >= backMovementDistance+idleXPosition)
            {
                position.y = GameConsts.PLATFORM_HEIGHT+yOffset;
                position.x-=movementSpeed*time;
            }

            if (currentPlatform == 1 && position.x < backMovementDistance+idleXPosition)
            {
                position.x-=movementSpeed*time;
            }

            if (currentPlatform == 1 && position.x <= idleXPosition)
            {
                downMovementRunning = false;
            }
        }

        private function doUpMovement(time:Number):void
        {
            if (currentPlatform == 1 && position.x < backMovementDistance+idleXPosition)
            {
                position.x+=movementSpeed*time;
            }

            if (position.x >= backMovementDistance+idleXPosition)
            {
                position.y = yOffset;
                position.x-=movementSpeed*time;
            }

            if (currentPlatform == 0 && position.x < backMovementDistance+idleXPosition)
            {
                position.x-=movementSpeed*time;
            }

            if (currentPlatform == 0 && position.x <= idleXPosition)
            {
                upMovementRunning = false;
            }

        }

        override public function shoot(time:Number):Unit
        {
            return null;
        }

        public function get moveLeftRunning():Boolean
        {
            return _moveLeftRunning;
        }

        public function get initialized():Boolean
        {
            return _initialized;
        }
    }
}
