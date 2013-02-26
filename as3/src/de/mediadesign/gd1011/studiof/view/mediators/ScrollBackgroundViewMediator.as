/**
 * Created with IntelliJ IDEA.
 * User: anlicht
 * Date: 20.02.13
 * Time: 17:10
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view.mediators
{
	import de.mediadesign.gd1011.studiof.services.JSONReader;
	import de.mediadesign.gd1011.studiof.services.LevelProcess;
	import de.mediadesign.gd1011.studiof.view.ScrollBackgroundView;

	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;

    import starling.display.Image;

    import starling.display.Image;
	import starling.utils.AssetManager;

	public class ScrollBackgroundViewMediator extends StarlingMediator
	{
		[Inject]
		public var bgView:ScrollBackgroundView;

		[Inject]
		public var assets:AssetManager;

		[Inject]
		public var level:LevelProcess;

		override public function initialize():void
		{
			bgView.alpha = 0;

			var layerTextures:Array = JSONReader.read("viewconfig")["assetsets"]["level_"+level.currentLevel]["background"][bgView.layerID];
			if(layerTextures.length > 0)
			{
                var bgImage:Image;
				bgImage = assets.getImage(layerTextures[Math.floor(Math.random()* layerTextures.length)]);
				bgView.addChild(bgImage);
			}
		}

		override public function destroy():void
		{

		}
	}
}
