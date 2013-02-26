/**
 * Created with IntelliJ IDEA.
 * User: anlicht
 * Date: 26.02.13
 * Time: 15:03
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view
{
	import de.mediadesign.gd1011.studiof.services.JSONReader;

	import starling.animation.Tween;
	import starling.core.Starling;

	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;

	public class ProgressBar extends Sprite
	{
		private var _width:Number;
		private var _height:Number;

		private var _border:Image;
		private var _bar:Sprite;

		private var _progress:Number = 0;

		private var _tween:Tween;

		public function ProgressBar(width:Number, height:Number, borderAsset:Image)
		{
			_width = width;
			_height = height;
			_border = borderAsset;
			var q:Quad = new Quad(_width,_height,JSONReader.read("viewconfig")["startscreen"]["progressbar"]["color"]);
			_bar = new Sprite();
			_bar.addChild(q);
			_border.y = _height-1;
			_bar.addChild(_border);
			_bar.y = -_bar.height
			addChild(_bar);
			_tween = new Tween(_bar,JSONReader.read("viewconfig")["startscreen"]["progressbar"]["progress-speed"],"linear");

		}

		public function set progress(state:Number):void
		{
			var progress:Number = Math.max(0,Math.min(1,state));

			Starling.juggler.add(_tween);
			_tween.moveTo(0,_bar.height*progress-_bar.height);
			_progress = progress;

		}
	}
}
