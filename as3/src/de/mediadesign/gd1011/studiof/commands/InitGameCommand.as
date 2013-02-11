/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 11.02.13
 * Time: 11:05
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.commands
{
    import de.mediadesign.gd1011.studiof.model.Game;

    import robotlegs.bender.bundles.mvcs.Command;

    public class InitGameCommand extends Command
    {
        [Inject]
        public var game:Game;

        override public function execute():void
        {
            
        }
    }
}
