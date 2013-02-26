package de.mediadesign.gd1011.studiof.view.mediators
{
	import de.mediadesign.gd1011.studiof.consts.ViewConsts;
	import de.mediadesign.gd1011.studiof.view.MainView;

	import flash.events.Event;


	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;

	import starling.events.Event;

	import starling.utils.AssetManager;

	public class MainViewMediator extends StarlingMediator
	{
		[Inject]
		public var contextView:MainView;

		[Inject]
		public var assets:AssetManager;

		override public function initialize():void
		{
			addContextListener(ViewConsts.LOAD_GAMEVIEW,loadGameView);
		}

		private function loadGameView(e:flash.events.Event):void
		{
			contextView.addEventListener(starling.events.Event.COMPLETE,initGameView);
			contextView.loadGameView(assets);
		}

		private function initGameView(e:starling.events.Event):void
		{
			contextView.initGameView();
		}

		override public function destroy():void
		{

		}
	}
}
