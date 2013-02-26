/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 26.02.13
 * Time: 09:11
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view
{
    import starling.display.Image;
    import starling.display.Sprite;

    public class PlayerView extends Sprite
    {
        private var _ID:String;
        public var timePassed:Number = 0;

        public function PlayerView(ID:String)
        {
            alpha = 0;
            this.ID = ID;
        }

        public function getDamage():void
        {
            var img:Image = Image(getChildAt(0));
            img.color = 0xFF0000;
        }

        public function setNormal():void
        {
            var img:Image = Image(getChildAt(0));
            img.color = 0xFFFFFF;
        }

        public function get ID():String
        {
            return _ID;
        }

        public function set ID(value:String):void
        {
            _ID = value;
        }
    }
}
