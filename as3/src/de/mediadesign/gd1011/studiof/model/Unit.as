/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 05.02.13
 * Time: 09:56
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.model
{
    import de.mediadesign.gd1011.studiof.consts.GameConsts;
    import de.mediadesign.gd1011.studiof.model.components.PositionComponent;
    import de.mediadesign.gd1011.studiof.model.components.VelocityComponent;
    import de.mediadesign.gd1011.studiof.services.JSONReader;

    public class Unit implements IMovable
    {
        private var _healthPoints:int;
        private var _currentPlatform:int;
        private var _position:PositionComponent;
        private var _velocity:VelocityComponent;
        private var _weapon:String;

        private var _currentLevel:Level;
        private var doNotShootAnymore:Boolean = false;
        private var enemyRange:int;
        private var fireRateEnemy:Number;

        private var _ID:String;

        public var cooldown:Number = 0;
        public var JSONExtractedInformation:Object;
        public var ammunition:Vector.<Unit>;
        public var hasAlreadyHitThePlayer:Boolean = false;
        public var stopped:Boolean = false;


        public function Unit(healthpoints:int, startingPlatform:int, xVel:int, startingXPosition:int, currentLevel:Level, verticalBullet:Boolean, ID:String = "")
        {
            ammunition = new Vector.<Unit>();
            _weapon = "default";
            _currentPlatform = startingPlatform;
            _healthPoints = healthpoints;
            _position = new PositionComponent();
            _velocity = new VelocityComponent();
            _velocity.velocityX = xVel;
            position.x = startingXPosition;
            if (startingXPosition == -1)
            {
                position.x = 20;
            }
            this._currentLevel = currentLevel;

            _position.y = currentPlatform * GameConsts.PLATFORM_HEIGHT;
            JSONExtractedInformation = JSONReader.read("enemy")["ENEMY"];
            fireRateEnemy = JSONExtractedInformation["fireRateEnemy"];
            enemyRange = JSONExtractedInformation["enemyRange"];
            if (verticalBullet)
            {
                velocity.verticalVelocity = true;
                velocity.velocityY = 600;
                velocity.velocityX = 0;
                position.x += 50;
            }
            if (startingPlatform == 2 && velocity.velocityX < 0)
            {
                position.y += 80;
            }

            this._ID = ID;
        }

        public function stop():void
        {
            stopped = true;
        }

        public function resume():void
        {
            stopped = false;
        }

        public function move(time:Number):void
        {
            if (!stopped) {
                if (assertCorrectInitialization())
                {
                    if (!velocity.verticalVelocity)
                    {
                        currentPlatform = observePlatform(position.y);
                        position.x += velocity.velocityX*time;
                    }
                    else
                    {
                        currentPlatform = observePlatform(position.y);
                        position.y += velocity.velocityY*time;
                    }
                }
                else trace("----------Function Move failed, because Unit not correctly initialized: "+position.x+","+position.y+","+velocity+","+currentPlatform+","+this);
            }
        }

        public function assertCorrectInitialization():Boolean
        {
            if(_position == null) return false;
            return !(_velocity == null);
        }

        public function observePlatform(y:int):int
        {
            var newEbene:int = 10;
            if (y>=0)                                                            {newEbene = 0;}
            if (y+1>GameConsts.STAGE_HEIGHT/6)                                   {newEbene = 1;}
            if (y+1>GameConsts.STAGE_HEIGHT/3)                                   {newEbene = 2;}
            if (y+1>GameConsts.STAGE_HEIGHT/2)                                   {newEbene = 3;}
            if (y+1>GameConsts.STAGE_HEIGHT*(2/3))                               {newEbene = 4;}
            if (y+1>GameConsts.STAGE_HEIGHT*(5/6) && y<=GameConsts.STAGE_HEIGHT) {newEbene = 5;}
            if (newEbene == 10) trace("observePlatform hat folgende unzulässige Eingabe erhalten: "+y);
            //trace(newEbene+","+y);
            return newEbene;
        }

        public function get healthPoints():int
        {
            return _healthPoints;
        }

        public function set healthPoints(value:int):void
        {
            if (value<0)
            {
                trace("Trying to set healthpoints below 0. Value "+value+" not accepted.");
            }
            else _healthPoints = value;
        }

        public function get currentPlatform():int
        {
            return _currentPlatform;
        }

        public function set currentPlatform(value:int):void
        {
            if (value<0 || value>5)
            {
                trace("Trying to set currentPlatform below 0 or beyond 5. Value "+value+" not accepted.");
            }
            else _currentPlatform = value;
        }

        public function set position(value:PositionComponent):void
        {
            _position = value;
        }

        public function get position():PositionComponent
        {
            return _position;
        }

        public function get velocity():VelocityComponent
        {
            return _velocity;
        }

        public function setNewPosition(y:int):void
        {
            if (y>=GameConsts.PLATFORM_HEIGHT*2 && y<=GameConsts.PLATFORM_HEIGHT*6)
            {
                _position.y = y;
            }
        }
        public function shoot(time:Number):Unit
        {
            cooldown += time;

            if (currentPlatform > 2 && cooldown >= (1 / fireRateEnemy) && position.x<enemyRange && position.x>0 && healthPoints > 0)
            {
                var bullet:Unit = new Unit(1, currentPlatform, -600, position.x, _currentLevel, false);
                bullet.position.y += 100;
                ammunition.push(bullet);
                cooldown = 0;
                return bullet;
            }

            if (!doNotShootAnymore && currentPlatform < 2 && cooldown >= (1 / fireRateEnemy) && position.x<enemyRange && position.x>0 && healthPoints > 0 && position.x >= _currentLevel.player.position.x && position.x-_currentLevel.collisionTolerance < _currentLevel.player.position.x)
            {
                doNotShootAnymore = true;
                _currentLevel.player.healthPoints -= 1;
                var bullet:Unit = new Unit(1, currentPlatform, -600, _currentLevel.player.position.x, _currentLevel, true);
                bullet.position.y += 100;
                ammunition.push(bullet);
                cooldown = 0;
                return bullet;
            }

            return null;
        }

        public function shootBullet(time:Number):void
        {
            if (!stopped) {
                var bullet:Unit = shoot(time);
                if (bullet != null)
                {
                    _currentLevel.register(bullet);
                }
            }
        }

        public function get ID():String
        {
            return _ID;
        }
    }
}
