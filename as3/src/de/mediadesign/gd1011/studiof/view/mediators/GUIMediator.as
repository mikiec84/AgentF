/**
 * Created with IntelliJ IDEA.
 * User: anlicht
 * Date: 07.02.13
 * Time: 14:09
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view.mediators
{
	import de.mediadesign.gd1011.studiof.consts.ViewConsts;
	import de.mediadesign.gd1011.studiof.events.GameEvent;
	import de.mediadesign.gd1011.studiof.view.GUI;

	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;

	public class GUIMediator extends StarlingMediator
	{
		[Inject]
		public var contextView:GUI;

		override public function initialize():void
		{
			addContextListener(ViewConsts.UPDATE_LIFEPOINTS,updateLifepoints);
			addContextListener(ViewConsts.SHOW_GAMEOVER,showGameOver);
		}

		private function showGameOver(e:GameEvent):void
		{
			contextView.showGameOver(e.dataObj as Boolean);
		}

		private function updateLifepoints(e:GameEvent):void
		{
			contextView.setLifepoints(e.dataObj as int);
		}

		override public function destroy():void
		{

		}
	}
}
