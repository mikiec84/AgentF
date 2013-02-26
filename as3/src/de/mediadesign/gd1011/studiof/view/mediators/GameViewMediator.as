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

    import starling.display.Quad;
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

            contextView.loadQuad = new Quad(800, 50, 0x0FFF0F);
            contextView.loadQuad.x = GameConsts.STAGE_HEIGHT/2 + 50;
            contextView.loadQuad.y = (GameConsts.STAGE_WIDTH-800)/2;

			addAssets();
            assets.loadQueue(loadAssets);
		}

		override public function destroy():void
		{
            contextView.removeEventListener(TouchEvent.TOUCH, handleTouch);
            contextView.removeEventListener(EnterFrameEvent.ENTER_FRAME, game.update);
		}

		private function addAssets():void
		{
            assets.enqueue(Background1);
            assets.enqueue(Background2);

            assets.enqueue(TileSystemLevel1_1);
            assets.enqueue(TileSystemLevel1_2);
            assets.enqueue(TileSystemLevel1_3);
            assets.enqueue(TileSystemLevel2_1);
            assets.enqueue(TileSystemLevel2_2);
            assets.enqueue(TileSystemLevel2_3);

            assets.enqueue("config/atlasxml/(TileSystemLevel1_1.xml");
            assets.enqueue("config/atlasxml/(TileSystemLevel1_2.xml");
            assets.enqueue("config/atlasxml/(TileSystemLevel1_3.xml");
            assets.enqueue("config/atlasxml/(TileSystemLevel2_1.xml");
            assets.enqueue("config/atlasxml/(TileSystemLevel2_1.xml");
            assets.enqueue("config/atlasxml/(TileSystemLevel2_1.xml");

			assets.enqueue(AgentF_texture);
			assets.enqueue(E1_texture);
			assets.enqueue(E3_texture);
			assets.enqueue(BG1_texture);
			assets.enqueue(BG2_texture);
			assets.enqueue(BG3_texture);
			assets.enqueue(Gras01_texture);
			assets.enqueue(Gras02_texture);
            assets.enqueue(Wasser_texture);

            assets.enqueue(AgentF_Idle_texture);
            assets.enqueue(Barrel_texture);
            assets.enqueue(FlyCoon_texture);
            assets.enqueue(SwimCoon_texture);

            assets.enqueue("config/atlasxml/AgentF_Idle_texture.xml");
            assets.enqueue("config/atlasxml/Barrel_texture.xml");
            assets.enqueue("config/atlasxml/FlyCoon_texture.xml");
            assets.enqueue("config/atlasxml/SwimCoon_texture.xml");
		}

		private function loadAssets(ratio:Number):void
		{
            contextView.loadQuad.scaleX = ratio;

            //trace("Lade Spiel: "+ratio);
			if(ratio == 1.0)
			{
				contextView.removeChild(contextView.loadQuad);

				addContextListener(ViewConsts.ADD_SPRITE_TO_GAME, add);
				addContextListener(ViewConsts.REMOVE_SPRITE_FROM_GAME, remove);

				var initGameEvent:GameEvent = new GameEvent(GameConsts.INIT_GAME);
				dispatcher.dispatchEvent(initGameEvent);
			}
            else
                contextView.addChild(contextView.loadQuad);
		}

		private function add(event:GameEvent):void
		{
            contextView.addChildAt(event.dataObj, contextView.numChildren);
		}

        private function remove(event:GameEvent):void
        {
            contextView.removeChild(event.dataObj);
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
