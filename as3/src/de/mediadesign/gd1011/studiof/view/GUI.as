/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 05.02.13
 * Time: 09:59
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view
{
	import starling.display.Sprite;
	import starling.events.Event;

	public class GUI extends Sprite
    {
		public function GUI()
        {
			if(stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE,init);

        }

		private function init(e:Event=null):void
		{

		}
    }
}
