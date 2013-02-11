/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 07.02.13
 * Time: 13:26
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view.mediators
{
    import de.mediadesign.gd1011.studiof.view.GameView;

    import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;

    public class UnitViewMediator extends StarlingMediator
    {
        [Inject]
        public var unitView:GameView;

        override public function initialize():void
        {

        }

        override public function destroy():void
        {

        }

        public function updateUnitView(s:String, x:int, y:int):void
        {
            if(s == "Player"){
                unitView.moveThePlayer(x, y);
            }
        }
    }
}
