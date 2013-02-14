/**
 * Created with IntelliJ IDEA.
 * User: anlicht
 * Date: 14.02.13
 * Time: 14:32
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view.mediators
{
	import de.mediadesign.gd1011.studiof.consts.ViewConsts;
	import de.mediadesign.gd1011.studiof.events.GameEvent;
	import de.mediadesign.gd1011.studiof.view.StartScreenView;

	import flash.events.IEventDispatcher;

	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;

	import starling.events.Event;

	public class StartScreenViewMediator extends StarlingMediator
	{
		[Inject]
		public var contextView:StartScreenView;

		[Inject]
		public var dispatcher:IEventDispatcher;

		override public function initialize():void
		{
			contextView.startButton.addEventListener(Event.TRIGGERED,changeToGameView);
		}

		private function changeToGameView(e:Event):void
		{
			dispatcher.dispatchEvent(new GameEvent(ViewConsts.INIT_GAMEVIEW));
		}

	}
}
