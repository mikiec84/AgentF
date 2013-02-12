/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 12.02.13
 * Time: 13:28
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view
{
    import flash.display.BitmapData;

    import starling.display.Image;

    import starling.display.Sprite;
    import starling.textures.Texture;

    public class EnemyView extends Sprite
    {
        public function EnemyView()
        {
            var bmd:BitmapData = new E1_texture(0,0);
            var image:Image = new Image(Texture.fromBitmapData(bmd));
            addChild(image);
        }
    }
}
