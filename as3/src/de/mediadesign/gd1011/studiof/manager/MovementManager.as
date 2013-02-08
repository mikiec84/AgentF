/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 05.02.13
 * Time: 09:45
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.manager
{
    import de.mediadesign.gd1011.studiof.model.Unit;
    import de.mediadesign.gd1011.studiof.consts.GameConsts;
    import de.mediadesign.gd1011.studiof.model.components.PositionComponent;

    import flash.geom.Point;

    import starling.animation.Transitions;

    import starling.animation.Tween;
    import starling.core.Starling;
    import starling.events.Touch;
    import starling.events.TouchPhase;

    public class MovementManager implements IMovementManager
    {   // config inhalt //
        private var einpendelStaerke:Number        = 30;      // Wie viele pixel tief er ins wasser klatscht wenn er unten aufkommt
        private var speedTowardsMouse:int          = 20;      // Wie schnell der player sich auf die maus zubewegt während geklickt ist
        private var jumpSpeedBeimSprung:Number     = 2;       // Wie lange der tween für das hochfliegen braucht um vollständig abgespielt zu werden in sekunden
        private var jumpSpeedBeimFall:Number       = 2;       // Wie lange der tween für den fall braucht um vollständig abgespielt zu werden in sekunden
        private var jumpSpeedBeimEinpendeln:Number = 3;       // Wie lange der tween für das einpendeln braucht um vollständig abgespielt zu werden in sekunden
        ////////////////////////////
        private var _player:PositionComponent;
        private var hoch:Tween;
        private var runter:Tween;
        private var aufkommen:Tween;
        private var derKommRunterTweenIstNochNichtAmLaufen:Boolean;
        private var derPendelEinTweenIstNochNichtAmLaufen:Boolean;
        private var aufkommenWurdeNochNichtVomJugglerRemoved:Boolean;
        private var areAnyUnfinishedTweensInMotionRightNow:Boolean;
        private var kommMausSollAusgeführtWerden:Boolean;
        private var mouseY:int = 0;

        public function MovementManager()
        {   _player = new PositionComponent();
            _player.x = 0;
            _player.y = GameConsts.PLAYER_START_HEIGHT;
            derKommRunterTweenIstNochNichtAmLaufen = true;
            derPendelEinTweenIstNochNichtAmLaufen = true;
            areAnyUnfinishedTweensInMotionRightNow = false;
            kommMausSollAusgeführtWerden = false;
            _player = null;
        }

        public function tick(allRelevantUnits:Vector.<Unit>):void
        {
            for (var index:int = 0; index<allRelevantUnits.length; index++)
            {
                if (allRelevantUnits[index].movement.horizontalVelocityEnabled)
                {
                    allRelevantUnits[index].movement.pos.x += allRelevantUnits[index].movement.directionVector[0];
                    allRelevantUnits[index].movement.pos.y += allRelevantUnits[index].movement.directionVector[1];//falls sie sich nicht in einer absolut geraden linie bewegen
                }
                else if (allRelevantUnits[index].movement.verticalVelocityEnabled)
                {

                }
            }
            handlePlayerJumps();
        }

        public function handlePlayerJumps():void
        {
            if (hoch != null && hoch.isComplete && derKommRunterTweenIstNochNichtAmLaufen) {
                derKommRunterTweenIstNochNichtAmLaufen = false;
                kommRunter();
            }
            if (runter != null && runter.isComplete && derPendelEinTweenIstNochNichtAmLaufen) {
                derPendelEinTweenIstNochNichtAmLaufen = false;
                pendelEin();
            }
            if (aufkommen != null && aufkommen.isComplete && aufkommenWurdeNochNichtVomJugglerRemoved) {
                aufkommenWurdeNochNichtVomJugglerRemoved = false;
                Starling.juggler.remove(aufkommen);
                areAnyUnfinishedTweensInMotionRightNow = false;
            }

            if (kommMausSollAusgeführtWerden) {
                if (_player.y+60<mouseY) {
                    _player.y+=speedTowardsMouse;
                } else {
                    _player.y=mouseY-60;
                }
            }

        }

        private function checkWelcheEbene():int
        {
            var newEbene:int = 10;
            if (_player.y>0)                                                        {newEbene = 0;}
            if (_player.y+GameConsts.PLAYER_HEIGHT/2>GameConsts.STAGE_HEIGHT/6)     {newEbene = 1;}
            if (_player.y+GameConsts.PLAYER_HEIGHT/2>GameConsts.STAGE_HEIGHT/3)     {newEbene = 2;}
            if (_player.y+GameConsts.PLAYER_HEIGHT/2>GameConsts.STAGE_HEIGHT/2)     {newEbene = 3;}
            if (_player.y+GameConsts.PLAYER_HEIGHT/2>GameConsts.STAGE_HEIGHT*(2/3)) {newEbene = 4;}
            if (_player.y+GameConsts.PLAYER_HEIGHT/2>GameConsts.STAGE_HEIGHT*(5/6)) {newEbene = 5;}
            return newEbene;
        }


        public function handleTouch(touch:Touch,  location:Point):void
        {   //var touch:Touch = e.getTouch(stage);
            if (checkWelcheEbene()>1) {
                if(touch && touch.phase == TouchPhase.BEGAN){
                    mouseY = location.y;
                    Starling.juggler.purge();
                    areAnyUnfinishedTweensInMotionRightNow = false;
                    kommMausSollAusgeführtWerden = true;
                }
                if(touch && touch.phase == TouchPhase.MOVED){
                    if (location.y >GameConsts.STAGE_HEIGHT/3 && _player.y+1>GameConsts.STAGE_HEIGHT/3) {
                        mouseY = location.y;
                    }
                }
                if (touch && touch.phase == TouchPhase.ENDED && !areAnyUnfinishedTweensInMotionRightNow) {
                    kommMausSollAusgeführtWerden = false;
                    sprungProzess();
                }
            }
        }

        public function sprungProzess():void
        {   areAnyUnfinishedTweensInMotionRightNow = true;
            if (Starling.juggler.contains(hoch)) {
                Starling.juggler.remove(hoch)
            }
            hoch = new Tween(_player, jumpSpeedBeimSprung, Transitions.EASE_OUT);
            if (checkWelcheEbene() > 2)
            {
                hoch.moveTo(_player.x, GameConsts.STAGE_HEIGHT - (GameConsts.STAGE_HEIGHT/6) * (checkWelcheEbene() + 1) );
                Starling.juggler.add(hoch);
                derKommRunterTweenIstNochNichtAmLaufen = true;
            }
            if (checkWelcheEbene() == 2)
            {
                hoch.moveTo(_player.x, 240);
                Starling.juggler.add(hoch);
                derKommRunterTweenIstNochNichtAmLaufen = true;
            }
        }

        public function kommRunter():void{
            if (Starling.juggler.contains(runter)) {
                Starling.juggler.remove(runter)
            }
            runter  = new  Tween(_player, jumpSpeedBeimFall, Transitions.EASE_IN);
            if (checkWelcheEbene() < 2) {
                runter.moveTo(_player.x, GameConsts.STAGE_HEIGHT/3+einpendelStaerke);
                Starling.juggler.add(runter);
                derPendelEinTweenIstNochNichtAmLaufen = true;
            }
        }

        private function pendelEin():void {
            aufkommen = new Tween(_player, jumpSpeedBeimEinpendeln, Transitions.EASE_OUT_ELASTIC);
            aufkommen.moveTo(_player.x,  GameConsts.STAGE_HEIGHT/3);
            Starling.juggler.add(aufkommen);
            aufkommenWurdeNochNichtVomJugglerRemoved = true;
        }

        public function getCurrentPlayerPosition():int
        {
            return _player.y;
        }

    }
}
