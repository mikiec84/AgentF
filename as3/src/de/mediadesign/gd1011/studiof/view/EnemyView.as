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
    import de.mediadesign.gd1011.studiof.events.GameEvent;

    import flash.display.BitmapData;

    import starling.display.Image;
    import starling.display.MovieClip;
    import starling.display.Quad;

    import starling.display.Sprite;
    import starling.textures.Texture;

    public class EnemyView extends Sprite
    {
        public function EnemyView()
        {
            addEventListener(ViewConsts.GET_DAMAGE, damageView);
            addEventListener(ViewConsts.SET_NORMAL, normalView);
        }

        public function damageView(e:GameEvent):void
        {
            this.alpha = 0.5;
        }

        public function normalView(e:GameEvent):void
        {
            this.alpha = 1;
        }
    }
}
