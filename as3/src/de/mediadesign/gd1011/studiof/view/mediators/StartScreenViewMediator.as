/**
 * Created with IntelliJ IDEA.
 * User: anlicht
 * Date: 14.02.13
 * Time: 14:32
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view.mediators
{
	import de.mediadesign.gd1011.studiof.consts.ViewConsts;
	import de.mediadesign.gd1011.studiof.events.GameEvent;
	import de.mediadesign.gd1011.studiof.view.StartScreenView;

	import flash.events.IEventDispatcher;

	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;

	import starling.display.Button;

	import starling.events.Event;
	import starling.utils.AssetManager;

	public class StartScreenViewMediator extends StarlingMediator
	{
		[Inject]
		public var contextView:StartScreenView;

		[Inject]
		public var dispatcher:IEventDispatcher;

		[Inject]
		public var assets:AssetManager;

		override public function initialize():void
		{
			assets.enqueue(E2_texture);
			assets.loadQueue(loadAssets);

		}

		private function loadAssets(ratio:Number):void
		{
			trace("Lade Startscreen: "+ratio);
			if(ratio == 1.0)
			{
				var startButton:Button = new Button(assets.getTexture("E2_texture"), "start", assets.getTexture("Pause_texture"));

				startButton.x = (contextView.dimX - startButton.width) / 2;
				startButton.y = (contextView.dimY - startButton.height) / 2;
				contextView.addChild(startButton);

				startButton.addEventListener(Event.TRIGGERED,changeToGameView);
			}
		}

		private function changeToGameView(e:Event):void
		{
			dispatcher.dispatchEvent(new GameEvent(ViewConsts.INIT_GAMEVIEW));
		}

	}
}
