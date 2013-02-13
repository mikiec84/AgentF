/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 07.02.13
 * Time: 09:48
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view
{
	import de.mediadesign.gd1011.studiof.services.Assets;

	import flash.display.BitmapData;

    import starling.display.Image;
    import starling.display.Sprite;
    import starling.textures.Texture;

    public class BackgroundView extends Sprite
    {
        public var scrBackground:ScrollBackground;

        public function BackgroundView():void
        {
			var bgImage1:Image = Assets.getImage("BG1_texture");
            addChild(bgImage1);
        }


    }
}
