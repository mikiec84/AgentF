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
	import de.mediadesign.gd1011.studiof.services.JSONReader;
	import de.mediadesign.gd1011.studiof.services.LevelProcess;
	import de.mediadesign.gd1011.studiof.view.LevelEndScreen;
	import de.mediadesign.gd1011.studiof.view.Localization;
	import de.mediadesign.gd1011.studiof.view.StartScreenView;
	import de.mediadesign.gd1011.studiof.view.TopSecretButton;

	import flash.events.IEventDispatcher;

	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;

	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;

	import starling.events.Event;
	import starling.utils.AssetManager;

	public class LevelEndScreenMediator extends StarlingMediator
	{
		[Inject]
		public var contextView:LevelEndScreen;

		[Inject]
		public var dispatcher:IEventDispatcher;

		[Inject]
		public var level:LevelProcess;

        private var loaded:Boolean = false;

		override public function initialize():void
		{
			contextView.nextButton.addEventListener(Event.TRIGGERED, changeToGameView);

		}

		private function changeToGameView(e:Event):void
		{
            if (!loaded) {
                loaded = true;
                dispatcher.dispatchEvent(new GameEvent(ViewConsts.LOAD_GAMEVIEW, level.currentLevel));
            }
		}

	}
}
