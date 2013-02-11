/**
 * Created with IntelliJ IDEA.
 * User: anlicht
 * Date: 31.01.13
 * Time: 09:55
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view
{
    import de.mediadesign.gd1011.studiof.model.Unit;
    import de.mediadesign.gd1011.studiof.model.components.PositionComponent;

    import flash.display.BitmapData;
    import flash.utils.ByteArray;

    import starling.core.Starling;

	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;

	public class GameView extends Sprite
	{
//        private var _player:PositionComponent;
//        private var oldX:int = 0;
//        private var oldY:int = 0;
        private var agentF:Image;

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

            var backgroundView:BackgroundView = new BackgroundView();
            addChild(backgroundView);
            
            //addEventListener(Event.ENTER_FRAME, updateVisuals);
			/*var q:Quad = new Quad(1710,870,0x00ff00);
			addChild(q);

			var test:BitmapData = new E1_texture(0,0);
			var img:Image = new Image(Texture.fromBitmapData(test));
			addChild(img);

			var test2:BitmapData = new E2_textures(0,0);
			var img2:Image = new Image(Texture.fromBitmapData(test2));
			addChild(img2);
			img2.x = 200;

			var test3:BitmapData = new E3_texture(0,0);
			var img3:Image = new Image(Texture.fromBitmapData(test3));
			addChild(img3);
			img3.x = 400;*/

			var test4:BitmapData = new AgentF_texture(0,0);
			agentF = new Image(Texture.fromBitmapData(test4));
			addChild(agentF);
			agentF.x = 600;
		}

        public function moveThePlayer(x:int, y:int):void
        {
            agentF.y = y;
        }
//        private function updateVisuals(event:Event):void
//        {
//            if (_player.y != oldY) {
//                agentF.y = _player.y;
//                oldY = _player.y;
//            }
//        }

//        public function givePlayer(player:PositionComponent):void
//        {
//            _player = player;
//        }
	}
}
