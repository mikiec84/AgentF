package de.mediadesign.gd1011.studiof.view.mediators
{
	import de.mediadesign.gd1011.studiof.consts.ViewConsts;
	import de.mediadesign.gd1011.studiof.view.MainView;

	import flash.events.Event;

	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;

	public class MainViewMediator extends StarlingMediator
	{
		[Inject]
		public var contextView:MainView;
		
		override public function initialize():void
		{
			addContextListener(ViewConsts.INIT_GAMEVIEW,initGameView);
		}

		private function initGameView(e:Event):void
		{
			contextView.initGameView();
		}

		override public function destroy():void
		{

		}
	}
}
