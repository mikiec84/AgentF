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
        private var einpendelStaerkeWinzig:Number;        // Wie stark er einpendelt wenn er von ebene 3 losgelassen wird
        private var einpendelStaerkeKlein:Number;         // Wie viele pixel tief er ins wasser klatscht wenn er unten aufkommt von ebene 1 fallend
        private var einpendelStaerkeGross:Number;         // Wie viele pixel tief er ins wasser klatscht wenn er unten aufkommt von ebene 0 fallend
        private var speedTowardsMouse:int;                // Wie schnell der player sich auf die maus zubewegt während geklickt ist
        private var jumpSpeedBeimSprung:Number;           // Wie lange der tween für das hochfliegen braucht um vollständig abgespielt zu werden in sekunden
        private var jumpSpeedBeimFall:Number;             // Wie lange der tween für den fall braucht um vollständig abgespielt zu werden in sekunden
        private var jumpSpeedBeimEinpendeln:Number;       // Wie lange der tween für das einpendeln braucht um vollständig abgespielt zu werden in sekunden
        private var accelerationSpeed:int;                // Die zusätzliche Anzahl an Pixel die der Spieler nach unten bewegt wird wenn er im fall nach unten gezogen wird
        private var fireRate:Number;                      // Feuer Rate: Kugeln pro Sekunde
        private var jumpSpeedBeimSprungWinzig:Number;     // Dauer des UP tweens wenn von ebene 3 losgelassen
        ////////////////////////////
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
        private var _moveTowardsMouseAsSoonAsYouCan:Boolean = false;
        private var _currentLevel:Level;
        private var _accelerateTowardsFinger:Boolean = false;
        private var _swiped:Boolean = false;
        private var startLandTweenAfterThis:Boolean = false;

        private var upIsRunning:Boolean = false;
        public var counter:int = 0;
        private var comeDownIsntRunningBuffer:Boolean = true;
        private var landNow:Boolean = false;
        // Sollte später von JSON eingelesen werden !!!


        public function Player(currentLevel:Level)
        {   super(1, 1, 1, -1, currentLevel, false);
            this._currentLevel = currentLevel;
            ammunition = new Vector.<Unit>();

            JSONExtractedInformation = JSONReader.read("config")["PLAYER"];
            currentPlatform = JSONExtractedInformation["platform"];
            healthPoints = JSONExtractedInformation["healthPoints"];
            fireRate = JSONExtractedInformation["fireRate"];
            einpendelStaerkeKlein = JSONExtractedInformation["einpendelStaerkeKlein"];
            einpendelStaerkeGross = JSONExtractedInformation["einpendelStaerkeGross"];
            einpendelStaerkeWinzig = JSONExtractedInformation["einpendelStaerkeWinzig"];
            jumpSpeedBeimSprungWinzig = JSONExtractedInformation["jumpSpeedBeimSprungWinzig"];
            if (einpendelStaerkeWinzig>GameConsts.PLATFORM_HEIGHT-1) {
                einpendelStaerkeWinzig = GameConsts.PLATFORM_HEIGHT-1;
            }
            speedTowardsMouse = JSONExtractedInformation["speedTowardsMouse"];
            jumpSpeedBeimSprung = JSONExtractedInformation["jumpSpeedBeimSprung"];
            jumpSpeedBeimFall = JSONExtractedInformation["jumpSpeedBeimFall"];
            jumpSpeedBeimEinpendeln = JSONExtractedInformation["jumpSpeedBeimEinpendeln"];
            accelerationSpeed = JSONExtractedInformation["accelerationSpeed"];
            _tweenedPosition = new PositionComponent();
            position.y = currentPlatform * GameConsts.PLATFORM_HEIGHT;
        }

        override public function move(time:Number):void
        {   //trace((GameConsts.EBENE_HEIGHT*2+einpendelStaerkeWinzig)+", "+(position.y));
            if (position.y<1000) {
                if (assertCorrectInitialization())
                {

                    checkPlayerPosition();

                    initializeVariables();

                    administerTweens(time);

                    if (!_anyTweensInMotion)
                    {
                        administerPlayerTowardsMouseMovement(time);
                    }
                    else
                    {
                        position.y = _tweenedPosition.y; //trace("POS.Y: "+position.y);
                        if (_targetPlatform == 6) ignoreMouseInput();
                    }
                }
                else trace("----------Function Move failed, because Player EITHER DEAD or not correctly initialized. Additional Info: "+position.x+","+position.y+","+velocity+","+currentPlatform+","+this+","+_tweenedPosition.x+","+_tweenedPosition.y);
            }
        }

        private function ignoreMouseInput():void
        {
            _targetPlatform = 2;
            _checkTargetPlatform = 2;
            _moveTowardsMouseAsSoonAsYouCan = false;
        }

        private function initializeVariables():void
        {   //trace(_comeDownIsntRunning);
            //if (_down != null) trace("Is down in juggler: "+Starling.juggler.contains(_down));
            currentPlatform      = observePlatform(position.y);
            upIsRunning          = (_up != null && !_up.isComplete && Starling.juggler.contains(_up));
            _comeDownIsntRunning = !(_down != null && !_down.isComplete);

            if (comeDownIsntRunningBuffer != _comeDownIsntRunning) {
                comeDownIsntRunningBuffer = _comeDownIsntRunning;
                if (comeDownIsntRunningBuffer)  landNow = true;
            }

            _landIsntRunning     = !(_landing != null && !_landing.isComplete);
            _landStillInJuggler  = Starling.juggler.contains(_landing);
            _anyTweensInMotion   = (upIsRunning || !_comeDownIsntRunning || (!_landIsntRunning || landNow));
            if (_up != null && _up.isComplete && Starling.juggler.contains(_up))
            {
                Starling.juggler.remove(_up);
//                trace("Up removed from juggler");
            }
            if (_down != null && _down.isComplete && Starling.juggler.contains(_down))
            {
                Starling.juggler.remove(_down);
//                trace("Down removed from juggler");
            }
            if (_landing != null && _landing.isComplete && Starling.juggler.contains(_landing))
            {
                Starling.juggler.remove(_landing);
//                trace("Land removed from juggler");
            }
        }

        private function checkPlayerPosition():void
        {
            if (position.y<0)
            {
                position.y = GameConsts.PLATFORM_HEIGHT*2;
                currentPlatform = 2;
            }
        }

        private function administerPlayerTowardsMouseMovement(time:Number):void
        {
            if (_targetPlatform>1 && !(currentPlatform == 5 && _targetPlatform == 6)) {
                if (currentPlatform<_targetPlatform)
                {
                    if((observePlatform(speedTowardsMouse*time+position.y)<_targetPlatform))
                    {
                        setNewPosition(speedTowardsMouse*time+position.y);
                    }
                    else
                    {
                        position.y = GameConsts.PLATFORM_HEIGHT*_targetPlatform;
                        //trace("Player.y wurde beim Runterziehen auf targetplatform gesetzt.");
                    }
                }
                else
                {
                    if (currentPlatform>=_targetPlatform) {
                        if(observePlatform(position.y-speedTowardsMouse*time)>=_targetPlatform)
                        {
                           setNewPosition(position.y-speedTowardsMouse*time);
                        } else {
                            if (currentPlatform == 2) {
                                position.y = GameConsts.PLATFORM_HEIGHT*_targetPlatform;
                            }
                        }
                    }
                }
            }
            if ((currentPlatform == 5 && _targetPlatform == 6) && swiped) {
                swiped = false;
                startJump();
            }
        }

        private function administerTweens(time:Number):void
        {   //trace("Any Tween in Motion: "+_anyTweensInMotion+", HochTween: "+(_up != null && !_up.isComplete)+", DownTween: "+(_down != null && !_down.isComplete)+", LandTween: "+(_landing != null && !_landing.isComplete));
            //trace("Land Is Running: "+!_landIsntRunning+", is land running: "+(_landing != null && !_landing.isComplete && _landStillInJuggler));


            if (!upIsRunning && _comeDownIsntRunning && position.y < GameConsts.PLATFORM_HEIGHT*2-50 && _landIsntRunning)
            {
                    shootBullet(time);
                    comeDown();
            }

            if (landNow) {
                landNow = false;
                land();
            }

            if (startLandTweenAfterThis && !upIsRunning) {
                startLandTweenAfterThis = false;
                land();
            }

            if (!_landIsntRunning && _moveTowardsMouseAsSoonAsYouCan) {
                Starling.juggler.remove(_landing);
                _landing = null;
            }


            if (_checkTargetPlatform != _targetPlatform) {
                _moveTowardsMouseAsSoonAsYouCan = true;
                _checkTargetPlatform = _targetPlatform;
            }
        }

        public function startJump():void
        {
            if (_targetPlatform == 6 && currentPlatform != 5)
            {
                //trace("startJump wird nicht ausgeführt weil targetplatform == 6 aber currentplatform != 5. currentPlatform: "+currentPlatform);
                _swiped = true;
            }
            else
            {
                ignoreMouseInput();
                if (!_anyTweensInMotion && currentPlatform>2)
                {
                    _tweenedPosition.y = position.y;
                    _tweenedPosition.x = position.x;
                    if (currentPlatform>3) {
                        _up = new Tween(_tweenedPosition, jumpSpeedBeimSprung, Transitions.EASE_OUT);
                        _up.moveTo(_tweenedPosition.x, GameConsts.STAGE_HEIGHT - (GameConsts.STAGE_HEIGHT/6) * (currentPlatform + 1) );
                    }
                    else
                    {
                        _up = new Tween(_tweenedPosition, jumpSpeedBeimSprungWinzig, Transitions.EASE_OUT);
                        _up.moveTo(_tweenedPosition.x, GameConsts.PLATFORM_HEIGHT*2+einpendelStaerkeWinzig );
                        startLandTweenAfterThis = true;
                    }
                    Starling.juggler.add(_up);
                } //else trace("startJump in Player has been used but there are Tweens in Motion right now, or currentPlatform is smaller/equal than 2. Request Denied.");
            }
        }

        public function comeDown():void
        {
            _down  = new  Tween(_tweenedPosition, jumpSpeedBeimFall, Transitions.EASE_IN);
            if (currentPlatform < 2)
            {
                if (currentPlatform == 1) {
                    _down.moveTo(_tweenedPosition.x, GameConsts.STAGE_HEIGHT/3+einpendelStaerkeKlein);
                }
                else
                {
                    _down.moveTo(_tweenedPosition.x, GameConsts.STAGE_HEIGHT/3+einpendelStaerkeGross);
                }
                Starling.juggler.add(_down);
            }
        }

        private function land():void
        {   //trace("LANDING BEGIN");
            _landing = new Tween(_tweenedPosition, jumpSpeedBeimEinpendeln, Transitions.EASE_OUT_ELASTIC);
            _landing.moveTo(_tweenedPosition.x,  GameConsts.STAGE_HEIGHT/3+1);//+1 weil ansonsten der player in ebene 1 endet aus welchem grund auch immer. da current 1 ist aber target 2 wird er ~20pixel nach oben gezogen, und dann wieder auf ebene 2 hochkorrigiert, wodurch er auf der stelle zu springen scheint. +1 verhindert das.
            Starling.juggler.add(_landing);
        }

        public function get targetPlatform():int
        {
            return _targetPlatform;
        }

        public function set targetPlatform(value:int):void
        {
            if (value<2 || value>6)
            {
                //trace("Trying to set Player targetPlatform to "+value+". Value not accepted.");
            }
            else
            {
                _targetPlatform = value;
                //trace("targetPlatform wurde auf "+targetPlatform+" gesetzt.");
            }
        }

        override public function shoot(time:Number):Unit
        {
            cooldown += time;
            if (currentPlatform > 1)
            {
                counter = 0;
            }
            if (counter == 0 && (cooldown >= (1 / fireRate) || (!_anyTweensInMotion && currentPlatform<2)))
            {   //trace("Ich will feuern weil up fertig ist aber come down nicht am laufen: "+(_up != null && _up.isComplete && _comeDownIsntRunning));
                //if (currentPlatform == 1 && !_landIsntRunning) {
                if (cooldown >= (1 / fireRate) || (!_anyTweensInMotion && currentPlatform<2 && counter == 0))
                {
                    if (currentPlatform == 1 && !_landIsntRunning)
                    {
                        var bullet:Unit = new Unit(1, 2, 600, -1, _currentLevel, false);
                    }
                    else
                    {
                        var bullet:Unit = new Unit(1, currentPlatform, 600, -1, _currentLevel, false);
                    }
                    bullet.position.y += 100;
                    ammunition.push(bullet);
                    cooldown = 0;
                    if (currentPlatform<2)
                    {
                        counter=1;
                        trace("Counter für schießen: "+counter);
                    }
                    if (currentPlatform<2)
                    {
                        counter+=1;
                    }
                    if (currentPlatform > 1)
                    {
                        counter = 0;
                    }
                    return bullet;
                }
                else return null;
            }
            return null;
        }

        public function shootNow():Boolean
        {
            return (!upIsRunning && _comeDownIsntRunning && healthPoints>0);
        }

        public function set accelerateTowardsFinger(value:Boolean):void
        {
            _accelerateTowardsFinger = value;
        }

        public function get swiped():Boolean
        {
            return _swiped;
        }

        public function set swiped(value:Boolean):void
        {
            _swiped = value;
        }
    }
}
