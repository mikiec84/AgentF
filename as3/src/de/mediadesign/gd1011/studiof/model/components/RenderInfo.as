/**
 * Created with IntelliJ IDEA.
 * User: kisalzmann
 * Date: 06.02.13
 * Time: 13:54
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.model.components
{
    public class RenderInfo
    {

        private var _pos:PositionComponent;
        private var _textureLocation:String;

        public function RenderInfo(thePos:PositionComponent)
        {
            this._pos = thePos;
        }

        public function get pos():PositionComponent
        {
            return _pos;
        }

        public function set pos(value:PositionComponent):void
        {
            _pos = value;
        }

        public function get textureLocation():String
        {
            return _textureLocation;
        }

        public function set textureLocation(value:String):void
        {
            _textureLocation = value;
        }
    }
}
