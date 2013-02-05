package de.mediadesign.gd1011.studiof {

    import de.mediadesign.gd1011.studiof.services.Game;

	import flash.display.StageAlign;

	import flash.display.StageScaleMode;

	import robotlegs.extensions.starlingViewMap.StarlingViewMapExtension;

    import flash.display.Sprite;

    import robotlegs.bender.bundles.mvcs.MVCSBundle;
    import robotlegs.bender.extensions.contextView.ContextView;
	import starling.core.Starling;
	import starling.events.Event;

    import robotlegs.bender.framework.api.IContext;
    import robotlegs.bender.framework.impl.Context;

    import starling.core.Starling;

	public class AgentF extends Sprite
    {

        private var _starling:Starling;
        private var _context:IContext;

        public function AgentF()
        {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;

			Starling.handleLostContext = true;
            _starling = new Starling(Game, stage);
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
