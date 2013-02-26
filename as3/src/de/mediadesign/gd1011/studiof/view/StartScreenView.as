/**
 * Created with IntelliJ IDEA.
 * User: anlicht
 * Date: 14.02.13
 * Time: 14:31
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view
{
	import de.mediadesign.gd1011.studiof.services.JSONReader;

	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;

	public class StartScreenView extends Sprite
	{
		private var _width:Number;
		private var _height:Number;

		private var _startScreenConfig:Object;
		private var _assets:AssetManager;

		private var _background:Sprite;
		private var _logo:Image;
		public var playButton:TopSecretButton;
		public var optionButton:TopSecretButton;
		public var scoreButton:TopSecretButton;
		public var creditButton:TopSecretButton;

		public var progressBar:ProgressBar;

		public function StartScreenView(width:Number,  height:Number)
		{
			_startScreenConfig = JSONReader.read("viewconfig")["startscreen"];

			_width=width;
			_height=height;
			visible = false;

			playButton = new TopSecretButton(Localization.getString("new game"),_startScreenConfig["button-size"]);
			optionButton = new TopSecretButton(Localization.getString("options"),_startScreenConfig["button-size"]);
			scoreButton = new TopSecretButton(Localization.getString("highscore"),_startScreenConfig["button-size"]);
			creditButton = new TopSecretButton(Localization.getString("credits"),_startScreenConfig["button-size"]);
		}

		public function loadAssets(assets:AssetManager)
		{
			_assets = assets;
			_assets.verbose=true;
			_assets.enqueue(Mainmenu);
			_assets.enqueue("/config/atlasxml/Mainmenu.xml");
			_assets.loadQueue(onLoad);
		}

		private function onLoad(ratio:Number):void
		{
			if(ratio == 1.0)
				createStartScreen();
		}

		public function createStartScreen():void
		{
			_background = new Sprite();
			//White BG
			var bgQuad:Quad = new Quad(_width,_height,0xffffff);
			_background.addChild(bgQuad);

			//Progress Bar
			progressBar = new ProgressBar(_startScreenConfig["progressbar"]["width"],_startScreenConfig["progressbar"]["height"], _assets.getImage("Menu_Blood"));
			progressBar.x = _startScreenConfig["progressbar"]["position-from-left"];
			progressBar.y = (_height/2)-_startScreenConfig["progressbar"]["position-from-center"];
			_background.addChild(progressBar);

			//Fox BG Asset
			var bgImage:Image = _assets.getImage("Menu_BG");
			bgImage.y = (_height - bgImage.height)/2;
			_background.addChild(bgImage);
			addChild(_background);

			//Border
			var leftBorder:Quad = new Quad(_startScreenConfig["border-width"],_height);
			var rightBorder:Quad = new Quad(_startScreenConfig["border-width"],_height);
			rightBorder.x = _width-_startScreenConfig["border-width"];
			var topBorder:Quad = new Quad(_width,_startScreenConfig["border-width"]);
			var bottomBorder:Quad = new Quad(_width,_startScreenConfig["border-width"]);
			bottomBorder.y = _height-_startScreenConfig["border-width"];
			addChild(leftBorder);
			addChild(rightBorder);
			addChild(topBorder);
			addChild(bottomBorder);

			//Agent F Logo
			_logo = _assets.getImage("Menu_Logo");
			_logo.x = _logo.y = _startScreenConfig["padding"];
			addChild(_logo);

			//Menu

			playButton.x = _startScreenConfig["button-offset"];
			var menuHeight:Number = (_height - _logo.height-_startScreenConfig["padding"]);
			playButton.y = _logo.height+_startScreenConfig["padding"]+(menuHeight-(playButton.height*4+_startScreenConfig["vSpace"]*3))/2;
			addChild(playButton);

			optionButton.x = _startScreenConfig["button-offset"];
			optionButton.y = playButton.y+playButton.height+_startScreenConfig["vSpace"];
			addChild(optionButton);


			scoreButton.x = _startScreenConfig["button-offset"];
			scoreButton.y = optionButton.y+optionButton.height+_startScreenConfig["vSpace"];
			addChild(scoreButton);


			creditButton.x = _startScreenConfig["button-offset"];
			creditButton.y = scoreButton.y+scoreButton.height+_startScreenConfig["vSpace"];
			addChild(creditButton);

			visible = true;
		}

	}
}
