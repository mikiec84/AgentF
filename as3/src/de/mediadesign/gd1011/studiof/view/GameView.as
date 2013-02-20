/**
 * Created with IntelliJ IDEA.
 * User: anlicht
 * Date: 31.01.13
 * Time: 09:55
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view
{
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;

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

            var q:Quad = new Quad(1710,1070,0x0000FF);
            q.y = -200;
			addChildAt(q, 0);
		}


	}
}
