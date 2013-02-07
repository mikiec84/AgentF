/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 07.02.13
 * Time: 09:48
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view
{
    //import de.mediadesign.gd1011.studiof.assets.Assets;

    import flash.geom.Point;

    import starling.display.Quad;
    import starling.display.Sprite;

    public class BackgroundView extends Sprite
    {

        public function BackgroundView():void
        {
            var debugQuad:Quad = new Quad(7529, 800, 0x00FF00);
            addChild(debugQuad);
            //var image = new Image(Assets.getTexture());
        }


    }
}
