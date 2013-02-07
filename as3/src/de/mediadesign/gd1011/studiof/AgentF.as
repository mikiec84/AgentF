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

	public class AgentF extends Sprite
    {

        private var _starling:Starling;
        private var _context:IContext;

        public function AgentF()
        {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;

			Starling.handleLostContext = true;
            _starling = new Starling(MainView, stage, new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight));
            _context = new Context()
                    .install( MVCSBundle, StarlingViewMapExtension )
                    .configure( StarlingConfig, this, _starling)
                    .configure(new ContextView(this));

            _starling.addEventListener(Event.ROOT_CREATED,init);
        }
		

        private function init(e:Event = null):void
        {
            _starling.start();
        }
    }
}
