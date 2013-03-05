package de.mediadesign.gd1011.studiof.view.mediators
{
	import de.mediadesign.gd1011.studiof.consts.ViewConsts;
	import de.mediadesign.gd1011.studiof.events.GameEvent;
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
			addContextListener(ViewConsts.SHOW_HIGHSCORE,showHighScore);
		}

		private function showHighScore(e:GameEvent):void
		{
			contextView.removeGameView();
			contextView.showHighscore();
		}

		private function loadGameView(e:GameEvent):void
		{
			contextView.loadWithScreen(assets, contextView.initGameView, "general", "level_"+((e.dataObj as Number)+1));
		}

		override public function destroy():void
		{

		}
	}
}
