/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 12.02.13
 * Time: 13:28
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view
{
    import de.mediadesign.gd1011.studiof.model.UpdateTextureSprite;

    import starling.filters.ColorMatrixFilter;

    public class EnemyView extends UpdateTextureSprite
    {
        private var _ID:String;
        private var colorFilter:ColorMatrixFilter = new ColorMatrixFilter();

        public function EnemyView(enemyType:String, ID:String = "")
        {
            super(enemyType);
            this._ID = ID;
        }

        public function getDamage():void
        {
            trace("mach was cooles");
            
        }

        public function get ID():String
        {
            return _ID;
        }
    }
}
