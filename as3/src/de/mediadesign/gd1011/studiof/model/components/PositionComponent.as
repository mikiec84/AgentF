/**
 * Created with IntelliJ IDEA.
 * User: kisalzmann
 * Date: 06.02.13
 * Time: 14:22
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.model.components
{
    public class PositionComponent
    {

        private var _x:int;
        private var _y:int;
        private var _currentRotation:int;

        public function PositionComponent()
        {
            _x = 0;
            _y = 0;
            _currentRotation = 0;
        }

        public function get x():int
        {
            return _x;
        }

        public function set x(value:int):void
        {
            _x = value;
        }

        public function get y():int
        {
            return _y;
        }

        public function set y(value:int):void
        {
            _y = value;
        }

        public function get currentRotation():int
        {
            return _currentRotation;
        }

        public function set currentRotation(value:int):void
        {
            _currentRotation = value;
        }
    }
}
