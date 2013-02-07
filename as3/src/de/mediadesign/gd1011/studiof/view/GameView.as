/**
 * Created with IntelliJ IDEA.
 * User: anlicht
 * Date: 31.01.13
 * Time: 09:55
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view
{
	import flash.display.BitmapData;

	import starling.core.Starling;

	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;

	public class GameView extends Sprite
	{
        public function GameView()
		{
			if(stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}

		public function init(e:Event = null):void
		{
			trace(Starling.contentScaleFactor);
			removeEventListener(Event.ADDED_TO_STAGE, init);

			var q:Quad = new Quad(1710,870,0x00ff00);
			addChild(q);

			var test:BitmapData = new Wirt_texture(0,0);
			var img:Image = new Image(Texture.fromBitmapData(test));
			addChild(img);

		}

	}
}
