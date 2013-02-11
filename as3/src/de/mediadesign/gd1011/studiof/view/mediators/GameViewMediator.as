package de.mediadesign.gd1011.studiof.view.mediators {
    import de.mediadesign.gd1011.studiof.manager.MovementManager;
    import de.mediadesign.gd1011.studiof.manager.Game;
    import de.mediadesign.gd1011.studiof.view.GameView;

	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;

    import starling.events.EnterFrameEvent;

    import starling.events.TouchEvent;

	public class GameViewMediator extends StarlingMediator
	{
		[Inject]
		public var contextView:GameView;
        [Inject]
        public var MM:MovementManager;

        [Inject]
        public var game:Game;

		private function handleTouch(e:TouchEvent):void
		{
            MM.handleTouch(e.getTouch(contextView.stage), e.getTouch(contextView.stage).getLocation(contextView.stage));
		}
		
		override public function initialize():void
		{
			contextView.addEventListener(TouchEvent.TOUCH, handleTouch);
            //giveThePlayerToTheView();
            contextView.addEventListener(EnterFrameEvent.ENTER_FRAME, game.update);
		}

		override public function destroy():void
		{
            contextView.removeEventListener(TouchEvent.TOUCH, handleTouch);
            contextView.removeEventListener(EnterFrameEvent.ENTER_FRAME, game.update);
		}
//
//        public function giveThePlayerToTheView():void
//        {
//            contextView.givePlayer(game.playerPos);
//        }
	}
}
