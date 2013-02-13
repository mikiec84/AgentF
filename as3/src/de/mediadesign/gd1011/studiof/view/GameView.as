/**
 * Created with IntelliJ IDEA.
 * User: anlicht
 * Date: 31.01.13
 * Time: 09:55
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view
{
	import starling.display.Quad;
	import starling.display.Sprite;

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

            var q:Quad = new Quad(1710,1200,0x00ff00);
			q.y = -200;
			addChildAt(q, 0);

			var backgroundView:BackgroundView = new BackgroundView();
			addChild(backgroundView);
		}
	}
}
