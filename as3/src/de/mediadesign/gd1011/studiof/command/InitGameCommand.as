/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 12.02.13
 * Time: 13:39
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.command
{
	import de.mediadesign.gd1011.studiof.services.CollisionProcess;
	import de.mediadesign.gd1011.studiof.services.GameLoop;
	import de.mediadesign.gd1011.studiof.services.LevelProcess;
	import de.mediadesign.gd1011.studiof.services.MoveProcess;
	import de.mediadesign.gd1011.studiof.services.RenderProcess;

	import flash.events.IEventDispatcher;

	import robotlegs.bender.bundles.mvcs.Command;

	public class InitGameCommand extends Command
    {
        [Inject]
        public var gameLoop:GameLoop;

        [Inject]
        public var moveProcess:MoveProcess;

        [Inject]
        public var renderProcess:RenderProcess;

        [Inject]
        public var collisionProcess:CollisionProcess;

        [Inject]
        public var level:LevelProcess;

        [Inject]
        public var dispatcher:IEventDispatcher;

        override public function execute():void
        {
            gameLoop.registerProcess(moveProcess);
            gameLoop.registerProcess(renderProcess);
            gameLoop.registerProcess(collisionProcess);
            gameLoop.registerProcess(level);
			moveProcess.clear();
			renderProcess.clear();
            level.newLevel(level.currentLevel);
        }
    }
}
