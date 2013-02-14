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
    import de.mediadesign.gd1011.studiof.consts.GameConsts;
    import de.mediadesign.gd1011.studiof.model.components.PositionComponent;
    import de.mediadesign.gd1011.studiof.model.Renderable;
    import de.mediadesign.gd1011.studiof.model.components.VelocityComponent;

    public class Unit implements IMovable
    {
        private var _healthPoints:int;
        private var _currentPlatform:int;
        private var _position:PositionComponent;
        private var _velocity:VelocityComponent;
        private var _weapon:String;


        public function Unit(healthpoints:int, startingPlatform:int, xVel:int)
        {
            _weapon = "default";
            _currentPlatform = startingPlatform;
            _healthPoints = healthpoints;
            _position = new PositionComponent();
            _velocity = new VelocityComponent();
            _velocity.velocityX = xVel;

            _position.y = currentPlatform * GameConsts.EBENE_HEIGHT;
        }

        public function move(time:Number):void
        {
            if (assertCorrectInitialization())
            {
                currentPlatform = observePlatform(position.y);
                position.x += velocity.velocityX*time;
            }
            else trace("----------Function Move failed, because Unit not correctly initialized: "+position.x+","+position.y+","+velocity+","+currentPlatform+","+this);
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

        public function get position():PositionComponent
        {
            return _position;
        }

        public function get velocity():VelocityComponent
        {
            return _velocity;
        }

        public function get weapon():String
        {
            return _weapon;
        }

        public function set weapon(value:String):void
        {
            _weapon = value;
        }

        public function setNewPosition(y:int):void
        {
            if (y>=GameConsts.EBENE_HEIGHT*2 && y<=GameConsts.EBENE_HEIGHT*6) {
                _position.y = y;
            }
        }
    }
}
