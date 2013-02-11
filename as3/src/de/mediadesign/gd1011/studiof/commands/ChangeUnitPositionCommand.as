/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 11.02.13
 * Time: 13:45
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.commands
{
    import de.mediadesign.gd1011.studiof.manager.UnitManager;
    import de.mediadesign.gd1011.studiof.model.Unit;
    import de.mediadesign.gd1011.studiof.model.components.PositionComponent;
    import de.mediadesign.gd1011.studiof.view.mediators.UnitViewMediator;

    import robotlegs.bender.bundles.mvcs.Command;

    public class ChangeUnitPositionCommand extends Command
    {
        [Inject]
        public var units:UnitManager;
        [Inject]
        public var UVM:UnitViewMediator

        override public function execute():void
        {
            UVM.updateUnitView("Player", units.player.renderData.position.x, units.player.renderData.position.y);
        }

    }
}
