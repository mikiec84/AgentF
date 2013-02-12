/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 07.02.13
 * Time: 13:50
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.commands
{
    import de.mediadesign.gd1011.studiof.manager.UnitManager;
    import de.mediadesign.gd1011.studiof.model.Unit;

    import flash.geom.Point;

    import robotlegs.bender.bundles.mvcs.Command;

    public class GetUnitPositionCommand extends Command
    {
        [Inject]
        public var units:UnitManager;

        override public function execute():void
        {
            for each (var unit:Unit in units.units)
            {
                var xy:Point = (unit.renderData.position.x, unit.renderData.position.y);
            }

        }
    }
}
