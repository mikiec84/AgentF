package de.mediadesign.gd1011.studiof {

    import starlingViewMap.StarlingViewMapExtension;

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
