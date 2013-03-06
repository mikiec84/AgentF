/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 13.02.13
 * Time: 15:17
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.command
{
	import de.mediadesign.gd1011.studiof.services.LevelProcess;

	import robotlegs.bender.bundles.mvcs.Command;

	public class ContinueGameCommand extends Command
    {
        [Inject]
        public var level:LevelProcess;

        override public function execute():void
        {
            level.start();
        }
    }
}
