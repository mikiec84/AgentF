/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 07.02.13
 * Time: 09:48
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view
{
    //import flash.display.BitmapData;

    //import starling.display.Image;
    import starling.display.Quad;
    import starling.display.Sprite;
    //import starling.textures.Texture;

    public class BackgroundView extends Sprite
    {

        public function BackgroundView():void
        {
            var debugQuad:Quad = new Quad(7529, 1070, 0xFFFF00);
            debugQuad.y = -180;
            addChild(debugQuad);

//            var bgTest:BitmapData = new BG_textures(0,0);
//            var bgImage:Image = new Image(Texture.fromBitmapData(bgTest));
//            addChild(bgImage);
        }


    }
}
