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
	import starling.text.TextField;

	public class GUI extends Sprite
    {

		private var _lifepoints:TextField;
		public function GUI()
        {
			_lifepoints = new TextField(100,100,"3","Verdana",60,0xffffff,true);
			addChild(_lifepoints);

			if(stage)
				adjust();
			else
				addEventListener(Event.ADDED_TO_STAGE,adjust);


        }

		private function adjust(e:Event=null):void
		{


		}

		public function setLifepoints(points:int):void
		{
			_lifepoints.text=points.toString();
		}

		public function showLostGame():void
		{
			_lifepoints.text="Verloren!";
		}
    }
}
