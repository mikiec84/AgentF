package de.mediadesign.gd1011.studiof.view.mediators
{
	import de.mediadesign.gd1011.studiof.consts.GameConsts;
	import de.mediadesign.gd1011.studiof.consts.ViewConsts;
	import de.mediadesign.gd1011.studiof.events.GameEvent;
	import de.mediadesign.gd1011.studiof.model.LevelConfiguration;
	import de.mediadesign.gd1011.studiof.model.Score;
	import de.mediadesign.gd1011.studiof.services.LevelProcess;
	import de.mediadesign.gd1011.studiof.view.MainView;

	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;

	import starling.utils.AssetManager;

	public class MainViewMediator extends StarlingMediator
	{
		[Inject]
		public var contextView:MainView;

		[Inject]
		public var assets:AssetManager;

        [Inject]
        public var score:Score;

		[Inject]
		public var level:LevelProcess;

		[Inject]
		public var levelConfig: LevelConfiguration;

		override public function initialize():void
		{
			addContextListener(ViewConsts.LOAD_GAMEVIEW,loadGameView);
			addContextListener(GameConsts.RESTART,contextView.initGameView);
			addContextListener(ViewConsts.SHOW_HIGHSCORE,showHighScore);
		}

		private function showHighScore(e:GameEvent):void
		{
            contextView.removeGameView();
            contextView.showHighscore(e.dataObj as Number, score);
			if(level.currentLevel == levelConfig.getLevelCount(0)-1)
				contextView.disableNextLevel();
		}

		private function loadGameView(e:GameEvent):void
		{
			assets.removeAssetPackage("level_"+(e.dataObj as Number));
			contextView.loadWithScreen(assets, contextView.initGameView, "general", "level_"+((e.dataObj as Number)+1));
		}

		override public function destroy():void
		{

		}
	}
}
