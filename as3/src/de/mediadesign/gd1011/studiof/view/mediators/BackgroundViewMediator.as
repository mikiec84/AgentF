/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 07.02.13
 * Time: 09:48
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view.mediators
{
	import de.mediadesign.gd1011.studiof.consts.ViewConsts;
	import de.mediadesign.gd1011.studiof.events.GameEvent;
	import de.mediadesign.gd1011.studiof.services.JSONReader;
	import de.mediadesign.gd1011.studiof.view.BackgroundView;
	import de.mediadesign.gd1011.studiof.view.ScrollBackgroundView;

	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;

	import starling.display.Sprite;
	import starling.utils.AssetManager;

	public class BackgroundViewMediator extends StarlingMediator
	{
		[Inject]
		public var bgView:BackgroundView;

		[Inject]
		public var assets:AssetManager;

		override public function initialize():void
		{
			//bgView.addChild(new Image(assets.getTexture("Background1")));
			addContextListener(ViewConsts.ADD_BG, add);
			addContextListener(ViewConsts.CLEAN_BG, clean);
		}

		override public function destroy():void
		{

		}

		private function add(event:GameEvent):void
		{

			var layerID:String = (event.dataObj as ScrollBackgroundView).layerID;
			var maxTiles = Math.ceil(JSONReader.read("config")["gamebounds"]["width"]/(JSONReader.read("config")["background"][layerID]["width"]-1)+1);
			var layer:Sprite = (bgView.bgLayer[layerID] as Sprite);
			if(layer==null)
			{
				layer = new Sprite();
				bgView.addChild(layer);
			}
			layer.addChild(event.dataObj);
			if(layer.numChildren>maxTiles)
				layer.removeChildAt(0);
		}

		private function clean(event:GameEvent):void
		{
			for each (var s:Sprite in bgView.bgLayer)
				s.dispose();

		}

	}
}
