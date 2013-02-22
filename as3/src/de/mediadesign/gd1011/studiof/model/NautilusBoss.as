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

    public class NautilusBoss extends Unit implements IEndboss
    {
        private var timeCounter:Number = 0;
        private var idleTimeFrame:Number;
        private var upMovementRunning:Boolean = false;
        private var downMovementRunning:Boolean = false;
        private var changePosTime:Number;
        private var idleXPosition:int;
        private var movementSpeed:Number;
        private var yOffset:int = 2;
        private var _moveLeftRunning:Boolean = false;
        private var _initialized:Boolean = false;
        private var level:Level;
        private var backMovementDistance:int;
        private var _finishLine:int = 0;
        private var changePosMovementSpeed:Number = 0;
        private var xOffset:int;
        private var attackSpeed:int;

        public function NautilusBoss(currentLevel:Level)
        {
            JSONExtractedInformation = JSONReader.read("enemy")["NAUTILUS"];
            changePosMovementSpeed = JSONExtractedInformation["changePosMovementSpeed"];
            changePosTime = JSONExtractedInformation["changePosTime"];
            xOffset = JSONExtractedInformation["xOffset"];
            idleXPosition = JSONExtractedInformation["idleXPosition"];
            idleTimeFrame = JSONExtractedInformation["idleTimeFrame"];
            attackSpeed = JSONExtractedInformation["attackSpeed"];
            backMovementDistance = GameConsts.STAGE_WIDTH+xOffset-idleXPosition;
            trace("backMovementDistance im konstruktor: "+backMovementDistance);
            movementSpeed = backMovementDistance/changePosTime;
            level = currentLevel;
            super(JSONExtractedInformation["healthpoints"],JSONExtractedInformation["startingPlatform"],0,idleXPosition, currentLevel, false);
            position.x = GameConsts.STAGE_WIDTH+xOffset;
        }


        public function reset():void
        {
            position.x = GameConsts.STAGE_WIDTH+JSONExtractedInformation["xOffset"];
            _initialized = false;
            healthPoints = JSONExtractedInformation["healthpoints"];
            position.y = JSONExtractedInformation["startingPlatform"]*GameConsts.PLATFORM_HEIGHT+yOffset;
        }

        public function start():void
        {   trace("NAUTILUS SPAWNED");
            _moveLeftRunning = true;
            var a:GameEvent = new GameEvent(GameConsts.NAUTILUS);
            level.dispatcher.dispatchEvent(a);
        }

        override public function move(time:Number):void
        {
            currentPlatform = observePlatform(position.y);
            if (!stopped) {
                if (!upMovementRunning && !downMovementRunning && !_moveLeftRunning && _initialized)
                {
                    timeCounter+=time;
                    if (timeCounter >= idleTimeFrame)
                    {
                        timeCounter = 0;
                        _finishLine = currentPlatform;
                        while(_finishLine == currentPlatform)
                        {
                            _finishLine = Math.round((Math.random()*2)+3);
                        }
                        if (currentPlatform > _finishLine)
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
            if (position.y+changePosMovementSpeed*time >= GameConsts.PLATFORM_HEIGHT*_finishLine) {
                position.y = GameConsts.PLATFORM_HEIGHT*_finishLine+yOffset;
                downMovementRunning = false;
            }
            else
            {
                position.y+=changePosMovementSpeed*time;
            }
        }

        private function doUpMovement(time:Number):void
        {
            if (position.y-changePosMovementSpeed*time <= GameConsts.PLATFORM_HEIGHT*_finishLine+yOffset) {
                position.y = GameConsts.PLATFORM_HEIGHT*_finishLine+yOffset;
                upMovementRunning = false;
            }
            else
            {
                position.y-=changePosMovementSpeed*time;
            }
        }

        override public function shoot(time:Number):Unit
        {
            cooldown += time;
            if (cooldown >= (1 / attackSpeed) && position.x<=idleXPosition && healthPoints > 0)
            {
                var bullet:Unit = new Unit(1, currentPlatform, -600, position.x, level, false);
                bullet.position.y += 100;
                ammunition.push(bullet);
                cooldown = 0;
                return bullet;
            }

            return null;
        }

        override public function shootBullet(time:Number):void
        {
            var bullet:Unit = shoot(time);
            if (bullet != null)
            {
                level.register(bullet);
            }
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
