/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 05.02.13
 * Time: 09:56
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.model
{
    import de.mediadesign.gd1011.studiof.model.components.Weapon;
    import de.mediadesign.gd1011.studiof.model.components.IMoveable;
    import de.mediadesign.gd1011.studiof.model.components.IRenderable;
    import de.mediadesign.gd1011.studiof.model.components.Moveable;
    import de.mediadesign.gd1011.studiof.model.components.Renderable;

    import flash.geom.Point;

    public class Unit
    {
        public var _movement:Moveable;
        public var renderData:Renderable;


        private var _weapon:Weapon;
        private var _healthPoints:int;
        private var _ebene:int;
        private var _playerJumpSpeed:Number;
        private var _unitType:String;


        public function Unit(unitType:String = null)
        {   _movement = new Moveable();
            renderData = new Renderable(_movement.position);
            _playerJumpSpeed = 2;
            _ebene = 2;
            _healthPoints = 3;
            _weapon = new Weapon();
            weapon.weaponType = "Kanone";

            if (unitType == "Player" || unitType == "Boss")
            {
                _movement.horizontalVelocityEnabled = false;
                _movement.position.y = 240;
            }
            else
            {
                _movement.horizontalVelocityEnabled = true;
            }

            this._unitType = unitType;

        }

        public function get weapon():Weapon
        {
            return _weapon;
        }

        public function set weapon(value:Weapon):void
        {
            _weapon = value;
        }

        public function get healthPoints():int
        {
            return _healthPoints;
        }

        public function set healthPoints(value:int):void
        {
            _healthPoints = value;
        }

        public function get platform():uint
        {
            return _ebene;
        }

        public function set platform(value:uint):void
        {
            _ebene = value;
        }

        public function get playerJumpSpeed():int {
            return _playerJumpSpeed;
        }

        public function set playerJumpSpeed(value:int):void {
            _playerJumpSpeed = value;
        }

        public function get unitType():String {
            return _unitType;
        }

        public function set unitType(value:String):void {
            _unitType = value;
        }
    }
}
