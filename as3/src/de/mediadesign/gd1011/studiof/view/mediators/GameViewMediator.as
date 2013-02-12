package de.mediadesign.gd1011.studiof.view.mediators {
    import de.mediadesign.gd1011.studiof.model.GameLoop;
    import de.mediadesign.gd1011.studiof.view.GameView;

    import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;

    import starling.events.EnterFrameEvent;
    import starling.events.TouchEvent;

    public class GameViewMediator extends StarlingMediator
	{
		[Inject]
		public var contextView:GameView;


        [Inject]
        public var game:GameLoop;

		private function handleTouch(e:TouchEvent):void
		{
		}
		
		override public function initialize():void
		{
			contextView.addEventListener(TouchEvent.TOUCH, handleTouch);
            contextView.addEventListener(EnterFrameEvent.ENTER_FRAME, game.update);
		}

		override public function destroy():void
		{
            contextView.removeEventListener(TouchEvent.TOUCH, handleTouch);
            contextView.removeEventListener(EnterFrameEvent.ENTER_FRAME, game.update);
		}
	}
}
