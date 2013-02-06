package de.mediadesign.gd1011.studiof {
	import de.mediadesign.gd1011.studiof.services.Game;

	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;

	import starling.display.Quad;

	import starling.events.TouchEvent;

	public class StarlingContextViewMediator extends StarlingMediator
	{
		[Inject]
		public var contextView:Game;

		private function handleTouch(e:TouchEvent):void
		{
			trace("Funktioniert");
		}
		
		override public function initialize():void
		{
			var quad:Quad = new Quad(1000,1000,0x000000);
			quad.x = 100;
			quad.y = 100;


			contextView.addChild(quad);
			contextView.addEventListener(TouchEvent.TOUCH,handleTouch);
		}

		override public function destroy():void
		{

		}
	}
}
