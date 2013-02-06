package de.mediadesign.gd1011.studiof.view.mediators {
	import de.mediadesign.gd1011.studiof.view.GameView;

	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;

	import starling.events.TouchEvent;

	public class GameViewMediator extends StarlingMediator
	{
		[Inject]
		public var contextView:GameView;

		private function handleTouch(e:TouchEvent):void
		{

		}
		
		override public function initialize():void
		{
			contextView.addEventListener(TouchEvent.TOUCH,handleTouch);
		}

		override public function destroy():void
		{

		}
	}
}
