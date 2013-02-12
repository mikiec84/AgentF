/**
 * Created with IntelliJ IDEA.
 * User: kisalzmann
 * Date: 12.02.13
 * Time: 13:03
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.model {
    import de.mediadesign.gd1011.studiof.consts.GameConsts;
    import de.mediadesign.gd1011.studiof.services.JSONReader;

    import starling.animation.Transitions;

    import starling.animation.Tween;
    import starling.core.Starling;
    import starling.events.TouchPhase;

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
        private var _comeDownIsntRunning:Boolean     = true;
        private var _landIsntRunning:Boolean         = true;
        private var _landStillInJuggler:Boolean      = false;
        private var _anyTweensInMotion:Boolean       = false;
        private var _movePlayerTowardsMouse:Boolean  = false;
        private var _targetPlatform:int              = 0;


        public function Player()
        {   super(1, 1);
            JSONExtractedInformation = JSONReader.read("config")["PLAYER"];
            currentPlatform = JSONExtractedInformation["platform"];
            healthPoints = JSONExtractedInformation["healthPoints"];
            weapon = JSONExtractedInformation["weapon"];
            einpendelStaerke = JSONExtractedInformation["einpendelStaerke"];
            speedTowardsMouse = JSONExtractedInformation["speedTowardsMouse"];
            jumpSpeedBeimSprung = JSONExtractedInformation["jumpSpeedBeimSprung"];
            jumpSpeedBeimFall = JSONExtractedInformation["jumpSpeedBeimFall"];
            jumpSpeedBeimEinpendeln = JSONExtractedInformation["jumpSpeedBeimEinpendeln"];
        }

        override public function move(time:Number):void
        {
            if (assertCorrectInitialization()) {
                currentPlatform = observePlatform(position.y);
                if (_up != null && _up.isComplete && _comeDownIsntRunning) {
                    _comeDownIsntRunning = false;
                    comeDown();
                }
                if (_down != null && _down.isComplete && _landIsntRunning) {
                    _landIsntRunning = false;
                    land();
                }
                if (_landing != null && _landing.isComplete && _landStillInJuggler) {
                    _landStillInJuggler = false;
                    Starling.juggler.remove(_landing);
                    _anyTweensInMotion = false;
                }

                if (_movePlayerTowardsMouse) {
                    if (currentPlatform<_targetPlatform) {
                        position.y+=speedTowardsMouse*time;
                    } else {
                        position.y=_targetPlatform*GameConsts.EBENE_HEIGHT;
                    }
                }
            } else trace("----------Function Move failed, because Player not correctly initialized: "+position.x+","+position.y+","+velocity+","+currentPlatform+","+this);
        }

        private function observePlatform(y:int):int
        {
            var newEbene:int = 10;
            if (y>0)                                                           {newEbene = 0;}
            if (y>GameConsts.STAGE_HEIGHT/6)                                   {newEbene = 1;}
            if (y>GameConsts.STAGE_HEIGHT/3)                                   {newEbene = 2;}
            if (y>GameConsts.STAGE_HEIGHT/2)                                   {newEbene = 3;}
            if (y>GameConsts.STAGE_HEIGHT*(2/3))                               {newEbene = 4;}
            if (y>GameConsts.STAGE_HEIGHT*(5/6) && y<=GameConsts.STAGE_HEIGHT) {newEbene = 5;}
            if (newEbene == 10) trace("observePlatform hat folgende unzulässige Eingabe erhalten: "+y);
            return newEbene;
        }

        public function handleTouch(currentTouchPhase:String,  directionPlatform:int):void
        {
            if(currentTouchPhase == TouchPhase.BEGAN){
                _targetPlatform = directionPlatform*GameConsts.EBENE_HEIGHT;
                Starling.juggler.purge();
                _anyTweensInMotion = false;
                _movePlayerTowardsMouse = true;
            }
            if(currentTouchPhase == TouchPhase.MOVED){
                if (directionPlatform*GameConsts.EBENE_HEIGHT >GameConsts.STAGE_HEIGHT/3 && position.y+1>GameConsts.STAGE_HEIGHT/3) {
                    _targetPlatform = directionPlatform;
                }
            }
            if (currentTouchPhase == TouchPhase.ENDED && !_anyTweensInMotion) {
                _movePlayerTowardsMouse = false;
                sprungProzess();
            }
        }

        public function sprungProzess():void
        {
            _anyTweensInMotion = true;
            if (Starling.juggler.contains(_up)) {
                Starling.juggler.remove(_up)
            }
            _up = new Tween(position, jumpSpeedBeimSprung, Transitions.EASE_OUT);
            if (currentPlatform > 2)
            {
                _up.moveTo(position.x, GameConsts.STAGE_HEIGHT - (GameConsts.STAGE_HEIGHT/6) * (currentPlatform + 1) );
                Starling.juggler.add(_up);
                _comeDownIsntRunning = true;
            }
            if (currentPlatform == 2)
            {
                _up.moveTo(position.x, GameConsts.PLAYER_START_HEIGHT);
                Starling.juggler.add(_up);
                _comeDownIsntRunning = true;
            }
        }

        public function comeDown():void{
            if (Starling.juggler.contains(_down)) {
                Starling.juggler.remove(_down)
            }
            _down  = new  Tween(position, jumpSpeedBeimFall, Transitions.EASE_IN);
            if (currentPlatform < 2) {
                _down.moveTo(position.x, GameConsts.STAGE_HEIGHT/3+einpendelStaerke);
                Starling.juggler.add(_down);
                _landIsntRunning = true;
            }
        }

        private function land():void {
            _landing = new Tween(position, jumpSpeedBeimEinpendeln, Transitions.EASE_OUT_ELASTIC);
            _landing.moveTo(position.x,  GameConsts.STAGE_HEIGHT/3);
            Starling.juggler.add(_landing);
            _landStillInJuggler = true;
        }
    }
}
