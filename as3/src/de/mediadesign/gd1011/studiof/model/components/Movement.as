/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 05.02.13
 * Time: 09:57
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.model.components
{
    public class Movement
    {
        private var _pos:PositionComponent;
        private var _directionVector:Array;
        private var _horizontalVelocityEnabled:Boolean;

        public function Movement()
        {
        }

        public function get pos():PositionComponent {
            return _pos;
        }

        public function set pos(value:PositionComponent):void {
            _pos = value;
        }

        public function get directionVector():Array {
            return _directionVector;
        }

        public function set directionVector(value:Array):void {
            _directionVector = value;
        }

        public function get horizontalVelocityEnabled():Boolean {
            return _horizontalVelocityEnabled;
        }

        public function set horizontalVelocityEnabled(value:Boolean):void {
            _horizontalVelocityEnabled = value;
        }
    }
}
