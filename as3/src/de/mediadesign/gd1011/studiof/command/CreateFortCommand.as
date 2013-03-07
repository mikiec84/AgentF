/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 06.03.13
 * Time: 11:09
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.command
{
	import de.mediadesign.gd1011.studiof.consts.ViewConsts;
	import de.mediadesign.gd1011.studiof.events.GameEvent;
	import de.mediadesign.gd1011.studiof.model.Fort;
	import de.mediadesign.gd1011.studiof.model.Renderable;
	import de.mediadesign.gd1011.studiof.services.MoveProcess;
	import de.mediadesign.gd1011.studiof.services.RenderProcess;
	import de.mediadesign.gd1011.studiof.view.FortView;

	import flash.events.IEventDispatcher;

	import robotlegs.bender.bundles.mvcs.Command;

	import starling.utils.AssetManager;

	public class CreateFortCommand extends Command
    {
        [Inject]
        public var assets:AssetManager;

        [Inject]
        public var moveProcess:MoveProcess;

        [Inject]
        public var renderProcess:RenderProcess;

        [Inject]
        public var e:GameEvent;

        [Inject]
        public var dispatcher:IEventDispatcher;

		override public function execute():void
        {
			var fortView:FortView = new FortView(assets);

			moveProcess.addEntity((e.dataObj as Fort));
			renderProcess.registerRenderable(new Renderable((e.dataObj as Fort).position, fortView));

			var addEnemySpriteToGameEvent:GameEvent = new GameEvent(ViewConsts.ADD_SPRITE_TO_GAME, fortView);
			dispatcher.dispatchEvent(addEnemySpriteToGameEvent);
        }

    }
}
