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
			_background = assets.getImage("Menu_BG");
			_background.y = (contextView.dimY - _background.height)/2;
			contextView.addChild(_background);

			_logo = assets.getImage("Menu_Logo");
			_logo.x = _logo.y = JSONReader.read("viewconfig")["game"]["padding"];
			contextView.addChild(_logo);

			_playButton = new TopSecretButton(Localization.getString("new game"),90);
			_playButton.x = JSONReader.read("viewconfig")["game"]["padding"];
			_playButton.y = (contextView.dimY - _playButton.height)/2;
			contextView.addChild(_playButton);
			_playButton.addEventListener(Event.TRIGGERED, changeToGameView);

			_optionButton = new TopSecretButton(Localization.getString("options"),90);
			_optionButton.x = JSONReader.read("viewconfig")["game"]["padding"];
			_optionButton.y = _playButton.y+_playButton.height;
			contextView.addChild(_optionButton);

			_scoreButton = new TopSecretButton(Localization.getString("highscore"),90);
			_scoreButton.x = JSONReader.read("viewconfig")["game"]["padding"];
			_scoreButton.y = _optionButton.y+_optionButton.height;
			contextView.addChild(_scoreButton);

			_creditButton = new TopSecretButton(Localization.getString("credits"),90);
			_creditButton.x = JSONReader.read("viewconfig")["game"]["padding"];
			_creditButton.y = _scoreButton.y+_scoreButton.height;
			contextView.addChild(_creditButton);

			contextView.visible = true;
		}

		private function changeToGameView(e:Event):void
		{
			dispatcher.dispatchEvent(new GameEvent(ViewConsts.INIT_GAMEVIEW));
		}

	}
}
