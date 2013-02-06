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

    import starling.display.Sprite;
	import starling.events.Event;

	public class MainView extends Sprite
	{
	    public function MainView()
		{
			if(stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}

		public function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);



			var gameView:GameView = new GameView();
			addChild(gameView);

			var userInterface:UI = new UI();
			addChild(userInterface);
		}

	}
}
