/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 13.02.13
 * Time: 09:21
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view.mediators
{
    import de.mediadesign.gd1011.studiof.model.components.PositionComponent;

    import flash.display.BitmapData;

    import starling.display.Image;
    import starling.display.Quad;

    import starling.display.Sprite;
    import starling.textures.Texture;

    public class BulletView extends Sprite
    {
        public function BulletView()
        {
            var q:Quad = new Quad(50,10,0xFFFFFF);
            q.y += 5;
            alpha = 0;
            addChildAt(q, 0);

//            var bmd:BitmapData = new E1_texture(0,0);
//            var image:Image = new Image(Texture.fromBitmapData(bmd));
//            addChild(image);
        }
    }
}
