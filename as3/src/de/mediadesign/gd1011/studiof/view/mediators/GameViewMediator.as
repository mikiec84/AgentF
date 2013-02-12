package de.mediadesign.gd1011.studiof.view.mediators {
	import de.mediadesign.gd1011.studiof.model.GameLoop;
	import de.mediadesign.gd1011.studiof.services.JSONReader;
	import de.mediadesign.gd1011.studiof.view.GameView;

	import flash.geom.Point;

	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;

	import starling.events.EnterFrameEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class GameViewMediator extends StarlingMediator
	{
		[Inject]
		public var contextView:GameView;


        [Inject]
        public var game:GameLoop;

		private var _touchConfig:Object;
		private var _validTouchID:int = -1;
		private function handleTouch(e:TouchEvent):void
		{
			//Handle starting touches
			var initTouches:Vector.<Touch> = e.getTouches(contextView, TouchPhase.BEGAN);
			for (var i:int = 0; i < initTouches.length; i++)
			{
				if (initTouches[i].getLocation(contextView).x <= _touchConfig["hTouch"])
				{
					var vTouchPos:Number = initTouches[i].getLocation(contextView).y;
					var platform:int = getVTouchzone(vTouchPos);
					if(platform>=0 && _touchConfig["vTouch"][platform]<=vTouchPos && _touchConfig["vTouch"][platform+1]>=vTouchPos)
						_validTouchID = initTouches[i].id;

					trace("Zone"+platform);
				}
			}



			//Handle moves
			var touches:Vector.<Touch> = e.getTouches(contextView, TouchPhase.MOVED);
			for (var j:int = 0; j < touches.length; j++)
				if (touches[j].id == _validTouchID)
				{
					var vTouchPos:Number = touches[j].getLocation(contextView).y;
					var platform:int = getVTouchzone(vTouchPos);
					trace("move "+platform);
				}

			//Handle end touch
			var endingTouches:Vector.<Touch> = e.getTouches(contextView, TouchPhase.ENDED);
			for (var k:int = 0; k < endingTouches.length; k++)
				if (endingTouches[k].id == _validTouchID)
				{
					trace("Ende mit aldente");
					_validTouchID = -1;
				}
		}

		private function getVTouchzone(vTouchPos:Number):int
		{
			for(var i:int = 0;i<_touchConfig["vTouch"].length-1;i++)
			{
				if(_touchConfig["vTouch"][i]<=vTouchPos && _touchConfig["vTouch"][i+1]>=vTouchPos)
				{
					return i;
				}
			}
			return -1;
		}
		
		override public function initialize():void
		{
			_touchConfig = JSONReader.read("viewconfig")["game"];
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
