/**
 * Created with IntelliJ IDEA.
 * User: kisalzmann
 * Date: 20.02.13
 * Time: 11:04
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.model {
    import de.mediadesign.gd1011.studiof.consts.GameConsts;
    import de.mediadesign.gd1011.studiof.consts.ViewConsts;
    import de.mediadesign.gd1011.studiof.events.GameEvent;
    import de.mediadesign.gd1011.studiof.services.JSONReader;
    import de.mediadesign.gd1011.studiof.services.LevelProcess;

    public class FortFoxBoss extends Unit implements IEndboss
    {
        private var timeCounter:Number = 0;
        private var idleTimeFrame:Number;
        private var upMovementRunning:Boolean = false;
        private var upMovementRunningBuffer:Boolean = false;
        private var downMovementRunning:Boolean = false;
        private var downMovementRunningBuffer:Boolean = false;
        private var changePosTime:Number;
        private var backMovementDistance:int;
        private var idleXPosition:int;
        private var movementSpeed:int;
        private var yOffset:int = 2;
        private var _moveLeftRunning:Boolean = false;
        private var _initialized:Boolean = false;
        private var level:LevelProcess;
        private var _scrollLevel:Boolean = false;
        private var _idleState:Boolean = false;
        private var _ammunition:Vector.<Unit>;

        private var doorState:int = 0;

        public function FortFoxBoss(currentLevel:LevelProcess)
        {
            var JSONExtractedInformation:Object = JSONReader.read("enemy")["FORT_FOX"];
            idleXPosition = JSONExtractedInformation["idleXPosition"];

            super(JSONExtractedInformation["healthpoints"],
                  JSONExtractedInformation["startingPlatform"],
                  0 ,idleXPosition, currentLevel, false, GameConsts.BOSS_SPAWN);

            idleTimeFrame = JSONExtractedInformation["idleTimeFrame"];
            changePosTime = JSONExtractedInformation["changePosTime"];
            backMovementDistance = JSONExtractedInformation["backMovementDistance"];

            movementSpeed = Math.round((backMovementDistance*2)/changePosTime);

            position.x = idleXPosition+backMovementDistance;
            level = currentLevel;
            healthPoints = JSONExtractedInformation["healthPoints"];
            if (currentLevel.bossHaveLowLife)
                healthPoints = 2;
        }

        public function start():void
        {   trace("FORTFOX SPAWNED");
            _moveLeftRunning = true;
            var a:GameEvent = new GameEvent(GameConsts.BOSS_SPAWN);
            level.dispatcher.dispatchEvent(a);
        }

        override public function move(time:Number):void
        {
            currentPlatform = observePlatform(position.y);
            if (!stopped)
            {
                if (!upMovementRunning && !downMovementRunning && !_moveLeftRunning && _initialized)
                {
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
                    if (upMovementRunning)
                        doUpMovement(time);
                    if (downMovementRunning)
                        doDownMovement(time);
                    if (_moveLeftRunning)
                        doMoveLeft(time);
                }
            }
            _idleState = (!upMovementRunning && !downMovementRunning && initialized);
        }

        private function doMoveLeft(time:Number):void
        {
            if (position.x > idleXPosition)
            {
                position.x-=movementSpeed*time;
            }
            else
            {
                var a:GameEvent = new GameEvent(ViewConsts.UPPER_DOOR);
                level.dispatcher.dispatchEvent(a);
                _moveLeftRunning = false;
                _initialized      = true;
            }
        }

        private function doDownMovement(time:Number):void
        {
            if (!downMovementRunningBuffer)
            {
                downMovementRunningBuffer = true;
                var a:GameEvent = new GameEvent(ViewConsts.UPPER_DOOR);
                level.dispatcher.dispatchEvent(a);
            }
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
                downMovementRunningBuffer = false;
                downMovementRunning = false;
                var ab:GameEvent = new GameEvent(ViewConsts.NETHER_DOOR);
                level.dispatcher.dispatchEvent(ab);
                var ac:GameEvent = new GameEvent(ViewConsts.FORT_FOX_BOSS_MOVEMENT);
                level.dispatcher.dispatchEvent(ac);
            }
        }

        private function doUpMovement(time:Number):void
        {
            if (!upMovementRunningBuffer)
            {
                upMovementRunningBuffer = true;
                var a:GameEvent = new GameEvent(ViewConsts.NETHER_DOOR);
                level.dispatcher.dispatchEvent(a);
            }
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
                upMovementRunningBuffer = false;
                upMovementRunning = false;
                var ab:GameEvent = new GameEvent(ViewConsts.UPPER_DOOR);
                level.dispatcher.dispatchEvent(ab);
                var ac:GameEvent = new GameEvent(ViewConsts.FORT_FOX_BOSS_MOVEMENT);
                level.dispatcher.dispatchEvent(ac);
            }
        }

        override public function shoot(time:Number):Unit
        {
            return null;
        }


        public function reset():void
        {
            position.x = idleXPosition+backMovementDistance;
            _initialized = false;
            healthPoints = JSONExtractedInformation["healthpoints"];
            position.y = JSONExtractedInformation["startingPlatform"]*GameConsts.PLATFORM_HEIGHT+yOffset;
        }

        public function update(time:Number):void
        {
        }

        public function get moveLeftRunning():Boolean
        {
            return _moveLeftRunning;
        }

        public function get initialized():Boolean
        {
            return _initialized;
        }


        public function get scrollLevel():Boolean
        {
            return _scrollLevel;
        }

        public function get idleState():Boolean
        {
            return _idleState;
        }

        public function set idleState(value:Boolean):void
        {
            _idleState = value;
        }

        public function get ammunition():Vector.<Unit> 
        {
            return _ammunition;
        }
    }
}
