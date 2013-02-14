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

	import starling.display.Sprite;
	import starling.events.Event;

	public class MainView extends Sprite
	{
		private var _appScale:Number = 1;
		private var _appLeftOffset:Number = 0;
		private var _appTopOffset:Number = 0;

		private var _guiScale:Number = 1;
		private var _guiWidth:Number = 0;
		private var _guiHeight:Number = 0;

		private var _startScreen:StartScreenView;

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

			_startScreen = new StartScreenView(_guiWidth,_guiHeight);
			_startScreen.scaleX = _startScreen.scaleY = _guiScale;
			addChild(_startScreen);
		}

		public function initGameView():void
		{
			var gameView:GameView = new GameView();
			gameView.scaleX = gameView.scaleY = _appScale;
			gameView.x = _appLeftOffset;
			gameView.y = _appTopOffset;

			var userInterface:GUI = new GUI();
			userInterface.scaleX = userInterface.scaleY = _guiScale;

			addChild(gameView);
			addChild(userInterface);
			removeChild(_startScreen);
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
		}

		private function setGUIScale():void
		{
			_guiScale = JSONReader.read("viewconfig")["gui"]["scale"]/SystemInfo.getDP();
			_guiWidth = stage.stageWidth/_guiScale;
			_guiHeight = stage.stageHeight/_guiScale;
		}



	}
}
