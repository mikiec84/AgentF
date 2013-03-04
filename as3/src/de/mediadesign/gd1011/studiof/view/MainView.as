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


		public function loadGameView(assets:AssetManager):void
		{
			assets.enqueue(Level1);
			assets.enqueue(Level2);

			assets.enqueue(TileSystemLevel1_1);
			assets.enqueue(TileSystemLevel1_2);
			assets.enqueue(TileSystemLevel1_3);
			assets.enqueue(TileSystemLevel2_1);
			assets.enqueue(TileSystemLevel2_2);
			assets.enqueue(TileSystemLevel2_3);

			assets.enqueue(Water);

			assets.enqueue(AgentF_Idle_texture);
			assets.enqueue(AgentF_Fall_texture);
			assets.enqueue(AgentF_Jump_texture);

			assets.enqueue(Barrel_texture);
			assets.enqueue(FlyCoon_texture);
			assets.enqueue(SwimCoon_texture);

            assets.enqueue(ClackHigh);
            assets.enqueue(FortFoxHigh);

            assets.enqueue(Nautilus_Change_texture);
            assets.enqueue(Nautilus_Idle_texture);
            assets.enqueue(Nautilus_Shot_texture);

			assets.enqueue(Arrow);
            assets.enqueue(Bomb);
            assets.enqueue(Bullet);
            assets.enqueue(SeaMine_texture);

			assets.enqueue("config/atlasxml/Level1.xml");
			assets.enqueue("config/atlasxml/Level2.xml");

			assets.enqueue("config/atlasxml/TileSystemLevel1_1.xml");
			assets.enqueue("config/atlasxml/TileSystemLevel1_2.xml");
			assets.enqueue("config/atlasxml/TileSystemLevel1_3.xml");
			assets.enqueue("config/atlasxml/TileSystemLevel2_1.xml");
			assets.enqueue("config/atlasxml/TileSystemLevel2_2.xml");
			assets.enqueue("config/atlasxml/TileSystemLevel2_3.xml");

			assets.enqueue("config/atlasxml/Water.xml");

			assets.enqueue("config/atlasxml/AgentF_Idle_texture.xml");
			assets.enqueue("config/atlasxml/AgentF_Fall_texture.xml");
			assets.enqueue("config/atlasxml/AgentF_Jump_texture.xml");

			assets.enqueue("config/atlasxml/Barrel_texture.xml");
			assets.enqueue("config/atlasxml/FlyCoon_texture.xml");
			assets.enqueue("config/atlasxml/SwimCoon_texture.xml");

            assets.enqueue("config/atlasxml/ClackHigh.xml");
            assets.enqueue("config/atlasxml/FortFoxHigh.xml");

            assets.enqueue("config/atlasxml/Nautilus_Change_texture.xml");
            assets.enqueue("config/atlasxml/Nautilus_Idle_texture.xml");
            assets.enqueue("config/atlasxml/Nautilus_Shot_texture.xml");

            assets.enqueue("config/atlasxml/SeaMine_texture.xml");

            assets.enqueue("assets/Shot.mp3");

			assets.enqueue("assets/Lvl1_Part_01.mp3");
			assets.enqueue("assets/Lvl1_Part_02.mp3");
			assets.enqueue("assets/Lvl1_Part_03.mp3");
			assets.enqueue("assets/Lvl1_Part_04.mp3");
			assets.enqueue("assets/Lvl1_Part_05.mp3");
			assets.enqueue("assets/Lvl1_Part_06.mp3");
			assets.enqueue("assets/Lvl1_Part_07.mp3");
			assets.enqueue("assets/Lvl1_Part_08.mp3");
			assets.enqueue("assets/Lvl1_Part_09.mp3");
			assets.enqueue("assets/Lvl1_Part_10.mp3");
			assets.enqueue("assets/Lvl1_Part_11.mp3");
			assets.enqueue("assets/Lvl1_Part_12.mp3");
//			assets.enqueue("assets/ThemeLvl1.mp3");
//			assets.enqueue("assets/ThemeLvl1.mp3");
//			assets.enqueue("assets/ThemeLvl1.mp3");
//			assets.enqueue("assets/ThemeLvl1.mp3");

			assets.loadQueue(onLoad);
		}

		private function onLoad(ratio:Number):void
		{
			_startScreen.progressBar.progress = ratio;

			if(ratio == 1.0)
				dispatchEvent(new Event(Event.COMPLETE));
		}
	}
}
