/**
 * Created with IntelliJ IDEA.
 * User: anlicht
 * Date: 05.03.13
 * Time: 15:02
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view
{
	import de.mediadesign.gd1011.studiof.services.JSONReader;
	import de.mediadesign.gd1011.studiof.view.ProgressBar;

	import starling.display.Image;

	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.utils.AssetManager;

	public class LoadingScreen extends Sprite
	{
		private var _screenConfig:Object;
		private var _width:Number;
		private var _height:Number;
		private var _background:Sprite;
		private var _progressBar:ProgressBar;
		private var _assets:AssetManager;

		public function LoadingScreen(width:Number,  height:Number, assets)
		{
			assets.verbose = true;
			_assets = assets;
			_screenConfig = JSONReader.read("viewconfig")["startscreen"];
			_width=width;
			_height=height;
			createLoadingScreen();
		}

		private function createLoadingScreen():void
		{
			_background = new Sprite();
			//White BG
			var bgQuad:Quad = new Quad(_width, _height, 0xffffff);
			_background.addChild(bgQuad);

			//Progress Bar
			_progressBar = new ProgressBar(_screenConfig["progressbar"]["width"], _screenConfig["progressbar"]["height"], _assets.getImage("Menu_Blood"));
			_progressBar.x = _screenConfig["progressbar"]["position-from-left"];
			_progressBar.y = (_height / 2) - _screenConfig["progressbar"]["position-from-center"];
			_background.addChild(_progressBar);

			//Fox BG Asset
			var bgImage:Image = _assets.getImage("Menu_BG");
			bgImage.y = (_height - bgImage.height) / 2;
			_background.addChild(bgImage);
			addChild(_background);

			//Border
			var leftBorder:Quad = new Quad(_screenConfig["border-width"], _height);
			var rightBorder:Quad = new Quad(_screenConfig["border-width"], _height);
			rightBorder.x = _width - _screenConfig["border-width"];
			var topBorder:Quad = new Quad(_width, _screenConfig["border-width"]);
			var bottomBorder:Quad = new Quad(_width, _screenConfig["border-width"]);
			bottomBorder.y = _height - _screenConfig["border-width"];
			addChild(leftBorder);
			addChild(rightBorder);
			addChild(topBorder);
			addChild(bottomBorder);
		}

		public function addAssetPackages(pack:String):void
		{
			_assets.loadAssetPackage(pack);
		}

		public function load(onLoad:Function=null)
		{
			_progressBar.onLoad = onLoad;
			_assets.loadQueue(this.onLoad);
		}

		private function onLoad(ratio:Number):void
		{
			_progressBar.progress = ratio;
		}
	}
}
