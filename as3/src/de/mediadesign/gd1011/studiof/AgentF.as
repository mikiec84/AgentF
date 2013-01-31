package de.mediadesign.gd1011.studiof
{

	import flash.display.Sprite;

    import robotlegs.bender.bundles.mvcs.MVCSBundle;

    import robotlegs.bender.framework.api.IContext;
    import robotlegs.bender.framework.impl.Context;
    import robotlegs.extensions.starlingViewMap.StarlingViewMapExtension;

    import starling.core.Starling;

	public class AgentF extends Sprite
    {

        private var _starling:Starling;

        public function AgentF()
        {
            const starling:Starling = new Starling(Game, stage);

            const context:IContext = new Context()
                    .install( MVCSBundle, StarlingViewMapExtension )
                    .configure( StarlingConfig, this, starling );

            starling.start();
        }
    }
}
