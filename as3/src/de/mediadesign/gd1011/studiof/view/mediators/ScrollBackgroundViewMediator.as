/**
 * Created with IntelliJ IDEA.
 * User: anlicht
 * Date: 20.02.13
 * Time: 17:10
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view.mediators
{
	import de.mediadesign.gd1011.studiof.view.ScrollBackgroundView;

	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;

    import starling.display.Image;

    import starling.display.Image;
    import starling.display.MovieClip;
    import starling.textures.Texture;

    import starling.utils.AssetManager;

	public class ScrollBackgroundViewMediator extends StarlingMediator
	{
		[Inject]
		public var bgView:ScrollBackgroundView;


		[Inject]
		public var assets:AssetManager;

		override public function initialize():void
		{
			var bgImage:Image;
			bgView.alpha = 0;
            //var mc = new MovieClip(assets.getTextures("Tile"));
			switch (Math.round(Math.random()* 2))
			{
				case(0):
                    bgImage = assets.getImage("Gras01_texture");
					//bgImage = new Image(mc.getFrameTexture(1));
					break;
				case(1):
                    bgImage = assets.getImage("Gras02_texture");
                    //bgImage = new Image(mc.getFrameTexture(2));
					break;
				default:
					bgImage = assets.getImage("Gras01_texture");
					break;
			}
			bgView.addChild(bgImage);
		}

		override public function destroy():void
		{

		}
	}
}
