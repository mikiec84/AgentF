package de.mediadesign.gd1011.studiof
{

    import de.mediadesign.gd1011.studiof.robotlegs.extensions.starlingViewMap.StarlingViewMapExtension;

    import flash.display.Sprite;

    import robotlegs.bender.bundles.mvcs.MVCSBundle;
    import robotlegs.bender.extensions.contextView.ContextView;

    import robotlegs.bender.framework.api.IContext;
    import robotlegs.bender.framework.impl.Context;

    import starling.core.Starling;

	public class AgentF extends Sprite
    {

        private var starling:Starling;
        private var context:IContext;

        public function AgentF()
        {
            starling = new Starling(Game, stage);

            context = new Context()
                    .install( MVCSBundle, StarlingViewMapExtension )
                    .configure( StarlingConfig, this, starling)
                    .configure(new ContextView(this));

            starling.start();
        }
    }
}
