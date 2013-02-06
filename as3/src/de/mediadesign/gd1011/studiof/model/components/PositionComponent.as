/**
 * Created with IntelliJ IDEA.
 * User: kisalzmann
 * Date: 06.02.13
 * Time: 14:22
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.model.components {
    public class PositionComponent {

        private var _x:int;
        private var _y:int;

        public function PositionComponent() {
        }

        public function get x():int {
            return _x;
        }

        public function set x(value:int):void {
            _x = value;
        }

        public function get y():int {
            return _y;
        }

        public function set y(value:int):void {
            _y = value;
        }
    }
}
