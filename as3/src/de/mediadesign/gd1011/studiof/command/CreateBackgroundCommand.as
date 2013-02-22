/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 13.02.13
 * Time: 15:17
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.command
{
	import de.mediadesign.gd1011.studiof.consts.ViewConsts;
	import de.mediadesign.gd1011.studiof.events.GameEvent;
	import de.mediadesign.gd1011.studiof.model.Renderable;
	import de.mediadesign.gd1011.studiof.model.BGTile;
	import de.mediadesign.gd1011.studiof.services.LevelProcess;
	import de.mediadesign.gd1011.studiof.services.MoveProcess;
	import de.mediadesign.gd1011.studiof.services.RenderProcess;
	import de.mediadesign.gd1011.studiof.view.ScrollBackgroundView;

	import flash.events.IEventDispatcher;

	import robotlegs.bender.bundles.mvcs.Command;

	import starling.display.Sprite;

	public class CreateBackgroundCommand extends Command
    {
        [Inject]
        public var moveProcess:MoveProcess;

        [Inject]
        public var renderProcess:RenderProcess;

        [Inject]
        public var event:GameEvent;

        [Inject]
        public var dispatcher:IEventDispatcher;

        [Inject]
        public var level:LevelProcess;

        override public function execute():void
        {
            var bg:BGTile = event.dataObj;
			var view:Sprite = new ScrollBackgroundView(bg.layerID);

            moveProcess.addEntity(bg);
            renderProcess.registerRenderable(new Renderable(bg.position, view));

            var addToBGEvent:GameEvent = new GameEvent(ViewConsts.ADD_BG, view);
            dispatcher.dispatchEvent(addToBGEvent);
        }
    }
}
