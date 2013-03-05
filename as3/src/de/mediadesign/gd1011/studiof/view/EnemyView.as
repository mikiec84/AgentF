/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 12.02.13
 * Time: 13:28
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view
{
    import starling.display.Image;
    import starling.display.Sprite;

    public class EnemyView extends Sprite
    {
        private var _ID:String;
        public var enemyType:String;

        public var timePassed:Number = 0;

        public function EnemyView(enemyType:String, ID:String = "")
        {
			alpha = 0;
            this.enemyType = enemyType;
            this._ID = ID;
        }

        public function getDamage():void
        {
            var img:Image = Image(getChildAt(0));
            img.color = 0xFF0000;
        }

        public function setNormal():void
        {
            if (numChildren > 0)
            {
                var img:Image = Image(getChildAt(0));
                img.color = 0xFFFFFF;
            }
        }

        public function get ID():String
        {
            return _ID;
        }
    }
}
