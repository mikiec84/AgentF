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

    import flash.geom.Point;

    public class Unit
    {
        private var _movement:Movement;
        private var _renderInfo:RenderInfo;
        private var _weapon:Weapon;
        private var _healthPoints:int;
        private var _platform:uint;

        public function Unit(platform:uint = 2, healthPoints:int = 1, weapon:String = null, movement:String = null)
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
            return _platform;
        }

        public function set platform(value:uint):void
        {
            _platform = value;
        }

        public function get renderInfo():RenderInfo {
            return _renderInfo;
        }

        public function set renderInfo(value:RenderInfo):void {
            _renderInfo = value;
        }
    }
}
