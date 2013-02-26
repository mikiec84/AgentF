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
	import de.mediadesign.gd1011.studiof.services.JSONReader;
	import de.mediadesign.gd1011.studiof.view.Localization;
	import de.mediadesign.gd1011.studiof.view.StartScreenView;
	import de.mediadesign.gd1011.studiof.view.TopSecretButton;

	import flash.events.IEventDispatcher;

	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;

	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;

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

		private var _startScreenConfig:Object;

		private var _background:Image;
		private var _logo:Image;
		private var _playButton:TopSecretButton;
		private var _optionButton:TopSecretButton;
		private var _scoreButton:TopSecretButton;
		private var _creditButton:TopSecretButton;
		override public function initialize():void
		{
			assets.verbose=true;
			assets.enqueue(Mainmenu);
			assets.enqueue("/config/atlasxml/Mainmenu.xml");
			assets.loadQueue(loadAssets);

		}

		private function loadAssets(ratio:Number):void
		{
			trace("Lade Startscreen: "+ratio);
			if(ratio == 1.0)
			{
				createStartScreen();
			}
		}

		private function createStartScreen():void
		{
			_startScreenConfig = JSONReader.read("viewconfig")["startscreen"];

			//White BG
			var bgQuad:Quad = new Quad(contextView.dimX,contextView.dimY,0xffffff);
			contextView.addChild(bgQuad);

			//Fox BG Asset
			_background = assets.getImage("Menu_BG");
			_background.y = (contextView.dimY - _background.height)/2;
			contextView.addChild(_background);

			//Border
			var leftBorder:Quad = new Quad(_startScreenConfig["border-width"],contextView.dimY);
			var rightBorder:Quad = new Quad(_startScreenConfig["border-width"],contextView.dimY);
			rightBorder.x = contextView.dimX-_startScreenConfig["border-width"];
			var topBorder:Quad = new Quad(contextView.dimX,_startScreenConfig["border-width"]);
			var bottomBorder:Quad = new Quad(contextView.dimX,_startScreenConfig["border-width"]);
			bottomBorder.y = contextView.dimY-_startScreenConfig["border-width"];
			contextView.addChild(leftBorder);
			contextView.addChild(rightBorder);
			contextView.addChild(topBorder);
			contextView.addChild(bottomBorder);

			//Agent F Logo
			_logo = assets.getImage("Menu_Logo");
			_logo.x = _logo.y = _startScreenConfig["padding"];
			contextView.addChild(_logo);

			//Menu
			_playButton = new TopSecretButton(Localization.getString("new game"),_startScreenConfig["button-size"]);
			_playButton.x = _startScreenConfig["button-offset"];
			var menuHeight:Number = (contextView.dimY - _logo.height-_startScreenConfig["padding"]);
			_playButton.y = _logo.height+_startScreenConfig["padding"]+(menuHeight-(_playButton.height*4+_startScreenConfig["vSpace"]*3))/2;
			contextView.addChild(_playButton);
			_playButton.addEventListener(Event.TRIGGERED, changeToGameView);

			_optionButton = new TopSecretButton(Localization.getString("options"),_startScreenConfig["button-size"]);
			_optionButton.x = _startScreenConfig["button-offset"];
			_optionButton.y = _playButton.y+_playButton.height+_startScreenConfig["vSpace"];
			contextView.addChild(_optionButton);

			_scoreButton = new TopSecretButton(Localization.getString("highscore"),_startScreenConfig["button-size"]);
			_scoreButton.x = _startScreenConfig["button-offset"];
			_scoreButton.y = _optionButton.y+_optionButton.height+_startScreenConfig["vSpace"];
			contextView.addChild(_scoreButton);

			_creditButton = new TopSecretButton(Localization.getString("credits"),_startScreenConfig["button-size"]);
			_creditButton.x = _startScreenConfig["button-offset"];
			_creditButton.y = _scoreButton.y+_scoreButton.height+_startScreenConfig["vSpace"];
			contextView.addChild(_creditButton);

			contextView.visible = true;
		}

		private function changeToGameView(e:Event):void
		{
			dispatcher.dispatchEvent(new GameEvent(ViewConsts.INIT_GAMEVIEW));
		}

	}
}
