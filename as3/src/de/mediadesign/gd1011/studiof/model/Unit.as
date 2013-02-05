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
    import de.mediadesign.gd1011.studiof.model.components.Weapon;

    import flash.geom.Point;

    public class Unit
    {
        private var _movement:Movement;
        private var _weapon:Weapon;
        private var _heathPoints:int;
        private var _position:Point;


        public function Unit()
        {
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

        public function get heathPoints():int
        {
            return _heathPoints;
        }

        public function set heathPoints(value:int):void
        {
            _heathPoints = value;
        }

        public function get position():Point
        {
            return _position;
        }

        public function set position(value:Point):void
        {
            _position = value;
        }
    }
}
