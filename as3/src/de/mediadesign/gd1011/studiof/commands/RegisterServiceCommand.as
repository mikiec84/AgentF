/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 08.02.13
 * Time: 09:46
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.commands
{
    import de.mediadesign.gd1011.studiof.services.Render;

    import robotlegs.bender.bundles.mvcs.Command;

    public class RegisterServiceCommand extends Command
    {
        [Inject]
        public var render:Render;

        //[Inject]
        // das movement

        override public function execute():void
        {
            //machWasCooles
        }
    }
}
