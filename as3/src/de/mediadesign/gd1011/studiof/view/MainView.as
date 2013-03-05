/**
 * Created with IntelliJ IDEA.
 * User: anlicht
 * Date: 31.01.13
 * Time: 09:55
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view
{
	import de.mediadesign.gd1011.studiof.SystemInfo;
	import de.mediadesign.gd1011.studiof.services.JSONReader;
	import de.mediadesign.gd1011.studiof.view.mediators.LoadingScreen;

	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;

	public class MainView extends Sprite
	{
		private var _appScale:Number = 1;
		private var _appLeftOffset:Number = 0;
		private var _appTopOffset:Number = 0;
		private var _appWidth:Number = 0;
		private var _appHeight:Number = 0;

		private var _guiScale:Number = 1;
		private var _guiWidth:Number = 0;
		private var _guiHeight:Number = 0;

		private var _startScreen:StartScreenView;
		private var _highscore:LevelEndScreen;
		private var _gameView:GameView;
		private var _ui:GUI;
		private var _loadingScreen:LoadingScreen;

	    public function MainView()
		{
			if(stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);

			var gameBounds:Object = JSONReader.read("config")["gamebounds"];
			setAppScale(gameBounds["width"],gameBounds["height"]);
			trace("scale game view with scale factor "+_appScale);

			setGUIScale();
			trace("scale GUI with scale factor "+_guiScale);

			_startScreen = new StartScreenView(_appWidth,_appHeight);
			_startScreen.scaleX = _startScreen.scaleY = _appScale;
			addChild(_startScreen);
		}

		public function initGameView():void
		{

			_gameView = new GameView();
			_gameView.scaleX = _gameView.scaleY = _appScale;
			_gameView.x = _appLeftOffset;
			_gameView.y = _appTopOffset;

			_ui = new GUI();
			_ui.scaleX = _ui.scaleY = _guiScale;

			addChild(_gameView);
			addChild(_ui);
			if(_loadingScreen != null)
				removeChild(_loadingScreen);
		}

		public function removeGameView():void
		{
			if(_gameView != null)
				removeChild(_gameView);
			if(_ui != null)
				removeChild(_ui);
		}

		private function setAppScale(gameWidth:Number, gameHeight:Number):void
		{
			var deviceWidth:Number = Math.max(stage.stageWidth, stage.stageHeight);
			var deviceHeight:Number = Math.min(stage.stageWidth, stage.stageHeight);


			//if game bounds are wider than device
			if ((deviceWidth / deviceHeight) < (gameWidth / gameHeight))
			{
				_appScale = deviceWidth /gameWidth;
				_appTopOffset = (deviceHeight - gameHeight * _appScale) * 0.9;
			}
			else
			{
				_appScale = deviceHeight / gameHeight;
				_appLeftOffset = deviceWidth - gameWidth * _appScale;
			}

			_appWidth = stage.stageWidth/_appScale;
			_appHeight = stage.stageHeight/_appScale;
		}

		private function setGUIScale():void
		{
			_guiScale = JSONReader.read("viewconfig")["gui"]["scale"]/SystemInfo.getDP();
			_guiScale = Math.min(_guiScale,JSONReader.read("viewconfig")["gui"]["max-scale"]);
			_guiScale = Math.max(_guiScale,JSONReader.read("viewconfig")["gui"]["min-scale"]);
			_guiWidth = stage.stageWidth/_guiScale;
			_guiHeight = stage.stageHeight/_guiScale;
		}

		public function loadWithScreen(assets:AssetManager,onLoad:Function,...rest):void
		{
			_loadingScreen = new LoadingScreen(_appWidth,_appHeight,assets);
			_loadingScreen.scaleX = _loadingScreen.scaleY = _appScale;
			addChild(_loadingScreen);
			if(_startScreen!= null)
			removeChild(_startScreen);
			for each(var s:String in rest)
			{
				_loadingScreen.addAssetPackages(s);
			}
			_loadingScreen.load(onLoad);
		}

		public function showHighscore():void
		{
			_highscore = new LevelEndScreen();
			addChild(_highscore);
		}
	}
}
