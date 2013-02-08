package de.mediadesign.gd1011.studiof {

	import de.mediadesign.gd1011.studiof.view.MainView;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.geom.Rectangle;

	import robotlegs.bender.bundles.mvcs.MVCSBundle;
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.impl.Context;
	import robotlegs.extensions.starlingViewMap.StarlingViewMapExtension;

	import starling.core.Starling;
	import starling.events.Event;
    import flash.events.Event;

	public class AgentF extends Sprite
    {

        private var _starling:Starling;
        private var _context:IContext;

        public function AgentF()
        {
			Starling.handleLostContext = true;

			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(flash.events.Event.RESIZE, onResize);
        }

		private function onResize(e:flash.events.Event):void
		{
			stage.removeEventListener(flash.events.Event.RESIZE, onResize);
			_starling = new Starling(MainView, stage, new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight));
			_context = new Context()
					.install( MVCSBundle, StarlingViewMapExtension )
					.configure( StarlingConfig, this, _starling)
					.configure(new ContextView(this));

			_starling.addEventListener(starling.events.Event.ROOT_CREATED,init);
			stage.addEventListener(flash.events.Event.DEACTIVATE, stage_deactivateHandler, false, 0, true);
		}
		

        private function init(e:starling.events.Event = null):void
        {
            _starling.start();
        }

        private function stage_deactivateHandler(event:flash.events.Event):void
        {
            trace("stop starling")
            _starling.stop();
            stage.addEventListener(flash.events.Event.ACTIVATE, stage_activateHandler, false, 0, true);
        }

        private function stage_activateHandler(event:flash.events.Event):void
        {
            trace("continue starling")
            stage.removeEventListener(flash.events.Event.ACTIVATE, stage_activateHandler);
            _starling.start();
        }
    }
}
