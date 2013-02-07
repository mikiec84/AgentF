/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 07.02.13
 * Time: 09:48
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view.mediators
{
    import de.mediadesign.gd1011.studiof.services.Render;
    import de.mediadesign.gd1011.studiof.view.BackgroundView;

    import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;

    public class BackgroundViewMediator extends StarlingMediator
    {
        [Inject]
        public var bgView:BackgroundView;

        [Inject]
        public var render:Render;

        override public function initialize():void
        {

        }

        override public function destroy():void
        {

        }
    }
}
