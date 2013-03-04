package de.mediadesign.gd1011.studiof.view.mediators {
    import de.mediadesign.gd1011.studiof.consts.GameConsts;
	import de.mediadesign.gd1011.studiof.consts.ViewConsts;
	import de.mediadesign.gd1011.studiof.events.GameEvent;
    import de.mediadesign.gd1011.studiof.services.LevelProcess;
    import de.mediadesign.gd1011.studiof.services.GameLoop;
    import de.mediadesign.gd1011.studiof.services.JSONReader;
    import de.mediadesign.gd1011.studiof.view.BackgroundView;
    import de.mediadesign.gd1011.studiof.view.GameView;

    import flash.events.IEventDispatcher;
    import flash.geom.Point;

    import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;

	import starling.core.Starling;

	import starling.display.DisplayObject;
    import starling.display.Image;
    import starling.display.MovieClip;

	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
    import starling.utils.AssetManager;

    public class GameViewMediator extends StarlingMediator
	{
		[Inject]
		public var contextView:GameView;

        [Inject]
        public var game:GameLoop;

		[Inject]
		public var level:LevelProcess;

        [Inject]
        public var dispatcher:IEventDispatcher;

		[Inject]
		public var assets:AssetManager;

		private var _touchConfig:Object;
		private var _validTouchID:int = -1;
		private var _startTouchPos:Point;
		private var _timeStamp:Number;
		
		override public function initialize():void
		{
			var backgroundView:BackgroundView = new BackgroundView();
			contextView.addChild(backgroundView);

			_touchConfig = JSONReader.read("viewconfig")["game"];

			contextView.addEventListener(TouchEvent.TOUCH, handleTouch);
            contextView.addEventListener(EnterFrameEvent.ENTER_FRAME, game.update);

			contextView.units = new Sprite();
			contextView.addChild(contextView.units);

			var water:MovieClip = assets.getAsset("Water_") as MovieClip;
			water.fps = 5;
			water.y = 455;
			water.alpha = 0.5;
			Starling.juggler.add(water);
			contextView.addChild(water);
			water.play();

			addContextListener(ViewConsts.ADD_SPRITE_TO_GAME, add);
			addContextListener(ViewConsts.REMOVE_SPRITE_FROM_GAME, remove);
            addContextListener(ViewConsts.CREATE_FORTBG, createFort);

			var initGameEvent:GameEvent = new GameEvent(GameConsts.INIT_GAME);
			dispatcher.dispatchEvent(initGameEvent);
			contextView.visible = true;

		}

        private function createFort(event:GameEvent):void
        {
            removeContextListener(ViewConsts.CREATE_FORTBG, createFort);
            var fortBackLayer:Image = new Image(assets.getTexture("Fort_BackLayer"));
            fortBackLayer.x = GameConsts.STAGE_WIDTH - 890;
            contextView.addChildAt(fortBackLayer, contextView.numChildren-2);
            var fortMiddleLayer:Image = new Image(assets.getTexture("Fort_MidLayer"));
            fortMiddleLayer.x = GameConsts.STAGE_WIDTH - 890;
            contextView.addChildAt(fortMiddleLayer, contextView.numChildren-2);
            var fortUpperLayer:Image = new Image(assets.getTexture("Fort_UpperLayer"));
            fortUpperLayer.x = GameConsts.STAGE_WIDTH - 890;
            contextView.addChildAt(fortUpperLayer, contextView.numChildren-1);
        }

		override public function destroy():void
		{
            contextView.removeEventListener(TouchEvent.TOUCH, handleTouch);
            contextView.removeEventListener(EnterFrameEvent.ENTER_FRAME, game.update);
		}

		private function add(event:GameEvent):void
		{
            contextView.addUnit(event.dataObj as DisplayObject);
		}

        private function remove(event:GameEvent):void
        {
            contextView.removeUnit(event.dataObj as DisplayObject);
        }

		private function handleTouch(e:TouchEvent):void
		{
			var vTouchPos:Number;
			var platform:int;

			//Handle starting touches
			var initTouches:Vector.<Touch> = e.getTouches(contextView, TouchPhase.BEGAN);
			for (var i:int = 0; i < initTouches.length; i++)
			{
				if (initTouches[i].getLocation(contextView).x <= _touchConfig["hTouch"])
				{
					vTouchPos = initTouches[i].getLocation(contextView).y;
					platform = getVTouchzone(vTouchPos);

					if(platform>=0 && _touchConfig["vTouch"][platform]<=vTouchPos && _touchConfig["vTouch"][platform+1]>=vTouchPos)
					{
						_validTouchID = initTouches[i].id;
						_startTouchPos = initTouches[i].getLocation(contextView);
						_timeStamp = e.timestamp;
						if(level.player != null && platform >=0 && platform != level.player.targetPlatform)
						{
							level.player.targetPlatform = platform;
						}
					}
				}
			}

			//Handle moves
			var touches:Vector.<Touch> = e.getTouches(contextView, TouchPhase.MOVED);
			for (var j:int = 0; j < touches.length; j++)
				if (touches[j].id == _validTouchID)
				{
					vTouchPos = touches[j].getLocation(contextView).y;
					platform = getVTouchzone(vTouchPos);

					//Move-down
					if(touches[j].getMovement(contextView).y>0 && platform < _touchConfig["defaultZone"])
					{
						if(level.player != null)
						{

						}
					}

					//Switch platform
					if(level.player != null && platform >=0 && platform != level.player.targetPlatform)
					{
						level.player.targetPlatform = platform;
					}
				}

			//Handle end touch
			var endingTouches:Vector.<Touch> = e.getTouches(contextView, TouchPhase.ENDED);
			for (var k:int = 0; k < endingTouches.length; k++)
				if (endingTouches[k].id == _validTouchID)
				{
					//Interpret if its a tap
					if(e.timestamp-_timeStamp < _touchConfig["max-tap-duration"] &&
						_startTouchPos.x == endingTouches[k].getLocation(contextView).x &&
					   	_startTouchPos.y == endingTouches[k].getLocation(contextView).y)
					{
						onTap(_startTouchPos.clone());
					}

					//On-release-event for the player
					if(level.player != null)
					{
						level.player.startJump();
						_validTouchID = -1;
					}
					_startTouchPos = null;

				}
		}

		private function onTap(tapPosition:Point = null):void
		{

		}

		private function getVTouchzone(vTouchPos:Number):int
		{
			for(var i:int = _touchConfig["vTouch"].length-1 ;i>=0;i--)
			{
				if(vTouchPos>=_touchConfig["vTouch"][i])
				{
					return i;
				}
			}
			return -1;
		}
	}
}
