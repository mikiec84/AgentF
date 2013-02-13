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

	    public function MainView()
		{
			if(stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}

		public function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);

			var gameBounds:Object = JSONReader.read("config")["gamebounds"];
			setAppScale(gameBounds["width"],gameBounds["height"]);
			trace("scale game view with scale factor "+_appScale);

			setGUIScale();
			trace("scale GUI with scale factor "+_guiScale);

			var gameView:GameView = new GameView();
			gameView.scaleX = gameView.scaleY = _appScale;
			gameView.x = _appLeftOffset;
			gameView.y = _appTopOffset;
			addChild(gameView);


			var userInterface:GUI = new GUI();
			userInterface.scaleX = userInterface.scaleY = _guiScale;
			addChild(userInterface);
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
		}



	}
}
