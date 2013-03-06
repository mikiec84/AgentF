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
    import de.mediadesign.gd1011.studiof.model.NautilusBoss;
    import de.mediadesign.gd1011.studiof.model.FortFoxBoss;
    import de.mediadesign.gd1011.studiof.model.Player;
    import de.mediadesign.gd1011.studiof.model.Unit;
    import de.mediadesign.gd1011.studiof.view.EnemyView;

    import flash.events.IEventDispatcher;

    public class Rules
    {
        [Inject]
        public var renderProcess:RenderProcess;

        [Inject]
        public var dispatcher:IEventDispatcher;

        private var _enemyConfig:Object;

        public var collisionToleranceFlying:int;
        public var collisionToleranceFloating:int;
        public var collisionToleranceDiving:int;

        public function Rules():void
        {
            _enemyConfig = JSONReader.read("enemy")["ENEMY"];
            collisionToleranceFlying = _enemyConfig["collisionToleranceFlying"];
            collisionToleranceFloating = _enemyConfig["collisionToleranceFloating"];
            collisionToleranceDiving = _enemyConfig["collisionToleranceDiving"];

        }

        // unit1: movement -->
        // unit2: movement <--
        public function collisionDetection(unit1:Unit, unit2:Unit):void
        {
            var collisionTolerance:int;

            if (unit1.observePlatform(unit1.position.y)<2)
            {
                collisionTolerance = collisionToleranceFlying;
            }

            if (unit1.observePlatform(unit1.position.y)==2)
            {
                collisionTolerance = collisionToleranceFloating;
            }

            if (unit1.observePlatform(unit1.position.y)>2)
            {
                collisionTolerance = collisionToleranceDiving;
            }

            if (unit2 is FortFoxBoss)
            {
                collisionTolerance = JSONReader.read("level/level")[0][0]["endboss"]["collisionTolerance"];
            }

            if (unit2 is NautilusBoss)
            {
                collisionTolerance = JSONReader.read("level/level")[0][1]["endboss"]["collisionTolerance"];
            }

            if (unit2.position.x < GameConsts.STAGE_WIDTH - 50)
            {
                if (unit1.currentPlatform == unit2.currentPlatform
                        && unit1.position.x + collisionTolerance >= unit2.position.x)
                {
                    unit1.healthPoints--;
                    unit2.healthPoints--;

                    var damageUnitEvent:GameEvent = new GameEvent(GameConsts.DAMAGE_UNIT, unit2);
                    dispatcher.dispatchEvent(damageUnitEvent);
                }
                else if (unit2 is NautilusBoss
                        && unit1.currentPlatform == unit2.currentPlatform+1
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
