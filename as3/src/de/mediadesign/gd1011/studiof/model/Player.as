/**
 * Created with IntelliJ IDEA.
 * User: kisalzmann
 * Date: 12.02.13
 * Time: 13:03
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.model {
    import de.mediadesign.gd1011.studiof.consts.GameConsts;
    import de.mediadesign.gd1011.studiof.model.components.PositionComponent;
    import de.mediadesign.gd1011.studiof.services.JSONReader;

    import starling.animation.Transitions;

    import starling.animation.Tween;
    import starling.core.Starling;

    public class Player extends Unit implements IMovable
    {
        // config inhalt //
        private var einpendelStaerke:Number;              // Wie viele pixel tief er ins wasser klatscht wenn er unten aufkommt
        private var speedTowardsMouse:int;                // Wie schnell der player sich auf die maus zubewegt während geklickt ist
        private var jumpSpeedBeimSprung:Number;           // Wie lange der tween für das hochfliegen braucht um vollständig abgespielt zu werden in sekunden
        private var jumpSpeedBeimFall:Number;             // Wie lange der tween für den fall braucht um vollständig abgespielt zu werden in sekunden
        private var jumpSpeedBeimEinpendeln:Number;       // Wie lange der tween für das einpendeln braucht um vollständig abgespielt zu werden in sekunden
        ////////////////////////////
        private var JSONExtractedInformation:Object;
        private var _up:Tween;
        private var _down:Tween;
        private var _landing:Tween;
        private var _comeDownIsntRunning:Boolean      = true;
        private var _landIsntRunning:Boolean          = true;
        private var _landStillInJuggler:Boolean       = false;
        private var _anyTweensInMotion:Boolean        = false;
        private var _targetPlatform:int               = 2;
        private var _tweenedPosition:PositionComponent;
        private var _checkTargetPlatform:int          = 2;
        private var _pleaseMoveTowardsMouseAsSoonAsYouCan:Boolean = false;
        private var _currentLevel:Level;

        private var ammunition:Vector.<Unit>;
        private var cooldown:Number = 0;
        private var fireRate:Number = 5;        // Sollte später von JSON eingelesen werden !!!


        public function Player(currentLevel:Level)
        {   super(1, 1, 1);
            this._currentLevel = currentLevel;
            ammunition = new Vector.<Unit>();

            JSONExtractedInformation = JSONReader.read("config")["PLAYER"];
            currentPlatform = JSONExtractedInformation["platform"];
            healthPoints = JSONExtractedInformation["healthPoints"];
            //weapon = JSONExtractedInformation["weapon"];
            einpendelStaerke = JSONExtractedInformation["einpendelStaerke"];
            speedTowardsMouse = JSONExtractedInformation["speedTowardsMouse"];
            jumpSpeedBeimSprung = JSONExtractedInformation["jumpSpeedBeimSprung"];
            jumpSpeedBeimFall = JSONExtractedInformation["jumpSpeedBeimFall"];
            jumpSpeedBeimEinpendeln = JSONExtractedInformation["jumpSpeedBeimEinpendeln"];
            _tweenedPosition = new PositionComponent();
            position.y = currentPlatform * GameConsts.EBENE_HEIGHT;
        }

        override public function move(time:Number):void
        {
            if (assertCorrectInitialization())
            {//trace(_checkTargetPlatform+", "+_targetPlatform);
                currentPlatform = observePlatform(position.y);

                checkPlayerPosition();

                administerTweens(time);

                if (!_anyTweensInMotion)
                {
                    administerPlayerTowardsMouseMovement(time);
                }
                else
                {
                    position.y = _tweenedPosition.y;
                    position.x = _tweenedPosition.x;
                }
            }
            else trace("----------Function Move failed, because Player not correctly initialized: "+position.x+","+position.y+","+velocity+","+currentPlatform+","+this+","+_tweenedPosition.x+","+_tweenedPosition.y);
        }

        private function checkPlayerPosition():void
        {
            if (position.y<0)
            {
                position.y = GameConsts.EBENE_HEIGHT*2;
                currentPlatform = 2;
            }
        }

        private function administerPlayerTowardsMouseMovement(time:Number):void
        {   //trace(targetPlatform, currentPlatform);
            Starling.juggler.purge();
            if (_targetPlatform>1) {
                if (currentPlatform<_targetPlatform)
                {
                    if(observePlatform(speedTowardsMouse*time+position.y)<_targetPlatform)
                    {
                        setNewPosition(speedTowardsMouse*time+position.y);
                    } else position.y = GameConsts.EBENE_HEIGHT*_targetPlatform;
                }
                else
                {
                    if (currentPlatform>=_targetPlatform) {
                        //trace("currentPlatform ist größer als targetPlatform");
                        if(observePlatform(position.y-speedTowardsMouse*time)>=_targetPlatform)
                        {
                           setNewPosition(position.y-speedTowardsMouse*time);
                        }//else position.y = GameConsts.EBENE_HEIGHT*_targetPlatform;
                    }
                }
            }
        }

        private function administerTweens(time:Number):void
        {
            if (_up != null && _up.isComplete && _comeDownIsntRunning)
            {
                shootBullet(time);
                _comeDownIsntRunning = false;
                comeDown();
            }
            if (_down != null && _down.isComplete && _landIsntRunning)
            {
                _landIsntRunning = false;
                land();
            }
            if ((_landing != null && _landing.isComplete && _landStillInJuggler)    //landing complete
                    //|| (_landing != null && _landStillInJuggler && _checkTargetPlatform != _targetPlatform)
                    || (_landing != null && _landStillInJuggler && _pleaseMoveTowardsMouseAsSoonAsYouCan))
            {
                    _landStillInJuggler = false;
                    Starling.juggler.remove(_landing);
                    _landing = null;
                    _anyTweensInMotion = false;
                _pleaseMoveTowardsMouseAsSoonAsYouCan = false;
            }


            if (_checkTargetPlatform != _targetPlatform) {
                _pleaseMoveTowardsMouseAsSoonAsYouCan = true;
                _checkTargetPlatform = _targetPlatform;
            }
        }

        public function shootBullet(time:Number):void
        {
            var bullet = shoot(time);
            if (bullet != null)
            {
                _currentLevel.register(bullet);
            }
        }


        public function startJump():void
        {                _targetPlatform = 2;
                        _checkTargetPlatform = 2;
            _pleaseMoveTowardsMouseAsSoonAsYouCan = false;
            if (!_anyTweensInMotion && currentPlatform>3)
            {

                _anyTweensInMotion = true;
                _tweenedPosition.y = position.y;
                _tweenedPosition.x = position.x;
                _comeDownIsntRunning = true;
                if (Starling.juggler.contains(_up))
                {
                    Starling.juggler.remove(_up)
                }
                _up = new Tween(_tweenedPosition, jumpSpeedBeimSprung, Transitions.EASE_OUT);
                //trace(currentPlatform);
                _up.moveTo(_tweenedPosition.x, GameConsts.STAGE_HEIGHT - (GameConsts.STAGE_HEIGHT/6) * (currentPlatform + 1) );
                Starling.juggler.add(_up);
            } else trace("startJump in Player has been used but there are Tweens in Motion right now, or currentPlatform is smaller/equal than 2. Request Denied.");
        }

        public function comeDown():void
        {
            if (Starling.juggler.contains(_down))
            {
                Starling.juggler.remove(_down)
            }
            _down  = new  Tween(_tweenedPosition, jumpSpeedBeimFall, Transitions.EASE_IN);
            if (currentPlatform < 2)
            {
                _down.moveTo(_tweenedPosition.x, GameConsts.STAGE_HEIGHT/3+einpendelStaerke);
                Starling.juggler.add(_down);
                _landIsntRunning = true;
            }
        }

        private function land():void
        {
            _landing = new Tween(_tweenedPosition, jumpSpeedBeimEinpendeln, Transitions.EASE_OUT_ELASTIC);
            _landing.moveTo(_tweenedPosition.x,  GameConsts.STAGE_HEIGHT/3+1);//+1 weil ansonsten der player in ebene 1 endet aus welchem grund auch immer. da current 1 ist aber target 2 wird er ~20pixel nach oben gezogen, und dann wieder auf ebene 2 hochkorrigiert, wodurch er auf der stelle zu springen scheint. +1 verhindert das.
            Starling.juggler.add(_landing);
            _landStillInJuggler = true;
        }

        public function get targetPlatform():int
        {
            return _targetPlatform;
        }

        public function set targetPlatform(value:int):void
        {
            if (value<2 || value>5) {
                trace("Trying to set Player targetPlatform to "+value+". Value not accepted.");
            } else _targetPlatform = value;
        }

        public function shoot(time:Number):Unit
        {
            cooldown += time;
            if (cooldown >= (1 / fireRate) || (_up != null && _up.isComplete && _comeDownIsntRunning))
            {
                if (currentPlatform == 1 && (_landing != null && !_landIsntRunning && !_landing.isComplete)) {
                    var bullet:Unit = new Unit(1, 2, 600);
                }
                else
                {
                    var bullet:Unit = new Unit(1, currentPlatform, 600);
                }
                bullet.position.y += 100;
                ammunition.push(bullet);
                cooldown = 0;
                return bullet;
            }
            else return null;
        }

        public function shootNow():Boolean
        {
            return (!_anyTweensInMotion || (_landing != null && !_landIsntRunning && !_landing.isComplete));
        }
    }
}
