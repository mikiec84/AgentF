/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 12.02.13
 * Time: 13:28
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view
{
    import de.mediadesign.gd1011.studiof.consts.ViewConsts;
    import de.mediadesign.gd1011.studiof.services.Assets;

    import starling.display.Image;
    import starling.display.Sprite;
    import starling.filters.ColorMatrixFilter;

    public class EnemyView extends Sprite
    {
        private var _ID:String;
        private var colorFilter:ColorMatrixFilter = new ColorMatrixFilter();
        private var texture:Image;

        public function EnemyView(enemyType:String, ID:String = "")
        {
            switch(enemyType)
            {
                case(ViewConsts.PLAYER):
                    texture = new Image(Assets.getTexture("AgentF_texture"));
                    break;
                case(ViewConsts.FLYING_ENEMY):
                    texture = new Image(Assets.getTexture("E1_texture"));
                    break;
                case(ViewConsts.FLOATING_ENEMY):
                    texture = new Image(Assets.getTexture("E2_texture"));
                    break;
                case(ViewConsts.UNDERWATER_ENEMY):
                    texture = new Image(Assets.getTexture("E3_texture"));
                    break;
            }
            addChild(texture);
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
