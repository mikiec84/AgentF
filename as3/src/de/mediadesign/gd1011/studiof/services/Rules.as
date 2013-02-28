/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 05.02.13
 * Time: 09:58
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.services
{
    import de.mediadesign.gd1011.studiof.consts.GameConsts;
    import de.mediadesign.gd1011.studiof.consts.ViewConsts;
    import de.mediadesign.gd1011.studiof.events.GameEvent;
    import de.mediadesign.gd1011.studiof.model.Player;
    import de.mediadesign.gd1011.studiof.model.Unit;
    import de.mediadesign.gd1011.studiof.view.EnemyView;
    import de.mediadesign.gd1011.studiof.view.EnemyView;

    import flash.events.IEventDispatcher;

    public class Rules
    {
        [Inject]
        public var renderProcess:RenderProcess;

        [Inject]
        public var dispatcher:IEventDispatcher;

        private var JSONExtractedInformation:Object;

        public var collisionTolerance:int;

        public function Rules():void
        {
            JSONExtractedInformation = JSONReader.read("enemy")["ENEMY"];
            collisionTolerance = JSONExtractedInformation["collisionTolerance"];
        }

        // unit1: movement -->
        // unit2: movement <--
        public function collisionDetection(unit1:Unit, unit2:Unit):void
        {
            if (unit2.position.x < GameConsts.STAGE_WIDTH)
            {
                if (unit1.currentPlatform == unit2.currentPlatform
                        && unit1.position.x + collisionTolerance >= unit2.position.x)
                {
                    unit1.healthPoints--;
                    unit2.healthPoints--;

                    var damageUnitEvent:GameEvent = new GameEvent(GameConsts.DAMAGE_UNIT, unit2);
                    dispatcher.dispatchEvent(damageUnitEvent);
                }
            }
        }

        public function isDead(unit:Unit):Boolean
        {
            return (unit.healthPoints <= 0);
        }
    }
}
