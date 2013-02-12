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
			removeEventListener(Event.ADDED_TO_STAGE, init);

            var q:Quad = new Quad(1710,870,0x00ff00);
			addChildAt(q, 0);

            var backgroundView:BackgroundView = new BackgroundView();
            addChildAt(backgroundView, 1);

//			var test:BitmapData = new E1_texture(0,0);
//			var img:Image = new Image(Texture.fromBitmapData(test));
//			addChild(img);
//
//			var test2:BitmapData = new E2_textures(0,0);
//			var img2:Image = new Image(Texture.fromBitmapData(test2));
//			addChild(img2);
//			img2.x = 200;
//
//			var test3:BitmapData = new E3_texture(0,0);
//			var img3:Image = new Image(Texture.fromBitmapData(test3));
//			addChild(img3);
//			img3.x = 400;*/

//			var test4:BitmapData = new AgentF_texture(0,0);
//			var agentF:Image = new Image(Texture.fromBitmapData(test4));
//			addChild(agentF);
//			agentF.x = 600;
		}
	}
}
