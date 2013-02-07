/**
 * Created with IntelliJ IDEA.
 * User: anlicht
 * Date: 07.02.13
 * Time: 14:09
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view.mediators
{
	import de.mediadesign.gd1011.studiof.view.GUI;

	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;

	public class GUIMediator extends StarlingMediator
	{
		[Inject]
		public var contextView:GUI;

		override public function initialize():void
		{

		}

		override public function destroy():void
		{

		}
	}
}
