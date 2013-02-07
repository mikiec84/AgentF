/**
 * Created with IntelliJ IDEA.
 * User: anlicht
 * Date: 31.01.13
 * Time: 09:55
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view
{
	import flash.geom.Rectangle;

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

			var gameBounds:Rectangle = new Rectangle(0, 0, 1710, 870);
			var deviceSize:Rectangle = new Rectangle(0, 0,
					Math.max(stage.stageWidth, stage.stageHeight),
					Math.min(stage.stageWidth, stage.stageHeight));

			var appScale:Number = 1;
			var appLeftOffset:Number = 0;
			var appTopOffset:Number = 0;

			//if game bounds are wider than device
			if ((deviceSize.width/deviceSize.height) < (gameBounds.width/gameBounds.height)) {
				appScale = deviceSize.width / gameBounds.width;
				appTopOffset = (deviceSize.height-gameBounds.height*appScale)*0.9;
			}
			else {
				appScale = deviceSize.height / gameBounds.height;
				appLeftOffset = deviceSize.width-gameBounds.width*appScale;
			}


			trace("scale game view with scale factor "+appScale);
			var gameView:GameView = new GameView();
			gameView.scaleX = gameView.scaleY = appScale;
			gameView.x = appLeftOffset;
			gameView.y = appTopOffset;
			addChild(gameView);

			var userInterface:UI = new UI();
			addChild(userInterface);
		}

	}
}
