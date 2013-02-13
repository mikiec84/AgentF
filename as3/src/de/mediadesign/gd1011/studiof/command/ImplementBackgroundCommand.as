/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 13.02.13
 * Time: 15:17
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.command
{
    import de.mediadesign.gd1011.studiof.consts.GameConsts;
    import de.mediadesign.gd1011.studiof.events.GameEvent;
    import de.mediadesign.gd1011.studiof.model.Renderable;
    import de.mediadesign.gd1011.studiof.model.ScrollableBG;
    import de.mediadesign.gd1011.studiof.services.MoveProcess;
    import de.mediadesign.gd1011.studiof.services.RenderProcess;
    import de.mediadesign.gd1011.studiof.view.ScrollBackground;

    import flash.events.IEventDispatcher;

    import robotlegs.bender.bundles.mvcs.Command;

    import starling.display.Sprite;

    public class ImplementBackgroundCommand extends Command
    {
        [Inject]
        public var moveProcess:MoveProcess;

        [Inject]
        public var renderProcess:RenderProcess;

        [Inject]
        public var event:GameEvent;

        [Inject]
        public var dispatcher:IEventDispatcher;

        override public function execute():void
        {
            var view:Sprite = new ScrollBackground();
            var scrBG:ScrollableBG = event.dataObj;

            moveProcess.addEntity(event.dataObj);
            renderProcess.registerRenderable(new Renderable(scrBG.position, view));

            var addToBGEvent:GameEvent = new GameEvent(GameConsts.ADD_BG_TO_GAME, GameConsts.ADD_BG_TO_GAME, view);
            dispatcher.dispatchEvent(addToBGEvent);
        }
    }
}
