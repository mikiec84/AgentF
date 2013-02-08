package de.mediadesign.gd1011.studiof.view.mediators {
    import de.mediadesign.gd1011.studiof.model.Game;
    import de.mediadesign.gd1011.studiof.services.Render;
    import de.mediadesign.gd1011.studiof.view.MainView;

	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;

    import starling.events.EnterFrameEvent;

    public class MainViewMediator extends StarlingMediator
	{
		[Inject]
		public var contextView:MainView;

        [Inject]
        public var game:Game;
		
		override public function initialize():void
		{

		}

		override public function destroy():void
		{

		}
	}
}
