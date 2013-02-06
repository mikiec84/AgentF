/**
 * Created with IntelliJ IDEA.
 * User: anlicht
 * Date: 31.01.13
 * Time: 09:55
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.services
{
    import de.mediadesign.gd1011.studiof.model.Unit;

    import starling.display.Sprite;
	import starling.events.Event;

	public class Game extends Sprite
	{
		public var currentScore:int;

        private var player:Unit;

        public function Game()
		{
			if(stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}

		public function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);

            // menu init ???

            gameLoop();
		}

        public function gameLoop():void
        {

        }

	}
}
