/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 05.02.13
 * Time: 09:56
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.model
{
    import de.mediadesign.gd1011.studiof.model.components.Movement;
    import de.mediadesign.gd1011.studiof.model.components.RenderInfo;
    import de.mediadesign.gd1011.studiof.model.components.Weapon;
    import de.mediadesign.gd1011.studiof.view.Renderable;

    import flash.geom.Point;

    public class Unit
    {
        private var _movement:Movement;
        private var _weapon:Weapon;
        private var _healthPoints:int;
        private var _ebene:int;
        private var _playerJumpSpeed:Number;
        private var _unitType:String;

        public var renderData:Renderable;

        public function Unit(unitType:String = null)
        {
            _playerJumpSpeed = 2;
            _ebene = 2;
            _healthPoints = 3;
            _weapon = new Weapon();
            weapon.weaponType = "Kanone";

            _movement = new Movement();
            if (unitType == "Player" || unitType == "Boss")
            {
                movement.horizontalVelocityEnabled = false;
            }
            else
            {
                movement.horizontalVelocityEnabled = true;
            }

            this._unitType = unitType;

            var renderData = new Renderable(_movement.pos);
        }

        public function get movement():Movement
        {
            return _movement;
        }

        public function set movement(value:Movement):void
        {
            _movement = value;
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
