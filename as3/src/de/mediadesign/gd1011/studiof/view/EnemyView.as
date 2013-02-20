/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 12.02.13
 * Time: 13:28
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view
{
	import starling.display.Sprite;
	import starling.filters.ColorMatrixFilter;

	public class EnemyView extends Sprite
    {
        private var _ID:String;
        private var colorFilter:ColorMatrixFilter = new ColorMatrixFilter();
        public var enemyType:String;

        public function EnemyView(enemyType:String, ID:String = "")
        {
			this.enemyType = enemyType;
            colorFilter.invert();
            this._ID = ID;
        }

        public function getDamage():void
        {
            trace("BÄM Filter");
        }

        public function get ID():String
        {
            return _ID;
        }
    }
}
