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
        private var _weapon:Weapon;
        private var _healthPoints:int;
        private var _ebene:int;
        private var _unitType:String;

        // kann auf werte nicht zugreifen, wenn Interface
        public var renderData:Renderable;
        public var moveData:Moveable;


        public function Unit(unitType:String = null)
        {
            _ebene = 2;
            _healthPoints = 3;
            _weapon = new Weapon();
            weapon.weaponType = "Kanone";
            moveData = new Moveable();
            renderData = new Renderable(moveData.position);


//            if (unitType == "Player" || unitType == "Boss")
//            {
//                movement.horizontalVelocityEnabled = false;
//                movement.position.y = 240;
//            }
//            else
//            {
//                movement.horizontalVelocityEnabled = true;
//            }

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

        public function get unitType():String
        {
            return _unitType;
        }

        public function set unitType(value:String):void
        {
            _unitType = value;
        }
    }
}
