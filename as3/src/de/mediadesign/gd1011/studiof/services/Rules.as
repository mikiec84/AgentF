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
	import de.mediadesign.gd1011.studiof.events.GameEvent;
	import de.mediadesign.gd1011.studiof.model.FortFoxBoss;
	import de.mediadesign.gd1011.studiof.model.NautilusBoss;
	import de.mediadesign.gd1011.studiof.model.Player;
	import de.mediadesign.gd1011.studiof.model.Unit;

	import flash.events.IEventDispatcher;

	public class Rules
    {
        [Inject]
        public var renderProcess:RenderProcess;

        [Inject]
        public var dispatcher:IEventDispatcher;

        [Inject]
        public var level:LevelProcess;

        private var _enemyConfig:Object;
        private var cheat:Boolean = true;

        private var collisionToleranceFlying:int;
        private var collisionToleranceFloating:int;
        private var collisionToleranceDiving:int;

        private var caveTolerance:int = 0;

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

            if (unit2.currentPlatform<2)
                collisionTolerance = collisionToleranceFlying;
            if (unit2.currentPlatform==2)
                collisionTolerance = collisionToleranceFloating;
            if (unit2.currentPlatform>2)
                collisionTolerance = collisionToleranceDiving;
            if (unit2 is FortFoxBoss)
                collisionTolerance = JSONReader.read("level/level")[0][0]["endboss"]["collisionTolerance"];
            if (unit2 is NautilusBoss)
                collisionTolerance = JSONReader.read("level/level")[0][1]["endboss"]["collisionTolerance"];

            if (level.boss.initialized && level.currentLevel == 0)
                caveTolerance = 400;
            else
                caveTolerance = 0;

            if (unit2.position.x < GameConsts.STAGE_WIDTH - 50 -caveTolerance)
            {
                if (unit1.currentPlatform == unit2.currentPlatform
                        && unit1.position.x + collisionTolerance >= unit2.position.x
                        && unit1.position.x < unit2.position.x - collisionTolerance*2)
                {
                    unit1.healthPoints--;
                    if (!(unit1 is Player))
                        unit2.healthPoints--;
                    else
                        unit2.healthPoints = 0;

                    var damageUnitEvent:GameEvent = new GameEvent(GameConsts.DAMAGE_UNIT, unit1);
                    dispatcher.dispatchEvent(damageUnitEvent);
                    var damageUnitEvent:GameEvent = new GameEvent(GameConsts.DAMAGE_UNIT, unit2);
                    dispatcher.dispatchEvent(damageUnitEvent);
                }
                // Luftballonheini kann in 2 ebenen abgeschossen werden
                if (unit2.currentPlatform == 1 && cheat)
                {
                    if (unit1.currentPlatform == unit2.currentPlatform - 1
                            && unit1.position.x + collisionTolerance >= unit2.position.x)
                    {
                        unit1.healthPoints--;
                        if (!(unit1 is Player))
                            unit2.healthPoints--;
                        else
                            unit2.healthPoints = 0;
                    }
                }
                //Nautilus kann in 2 ebenen abgeschossen werden
                else if (unit2 is NautilusBoss
                        && unit1.currentPlatform == unit2.currentPlatform+1
                        && unit1.position.x + collisionTolerance >= unit2.position.x)
                {
                    unit1.healthPoints--;
                    unit2.healthPoints--;

                    var damageUnitEvent:GameEvent = new GameEvent(GameConsts.DAMAGE_UNIT, unit1);
                    dispatcher.dispatchEvent(damageUnitEvent);
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
