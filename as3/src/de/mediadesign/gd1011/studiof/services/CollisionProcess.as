/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 22.02.13
 * Time: 11:36
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.services
{
    import de.mediadesign.gd1011.studiof.consts.GameConsts;
    import de.mediadesign.gd1011.studiof.consts.ViewConsts;
    import de.mediadesign.gd1011.studiof.events.GameEvent;
    import de.mediadesign.gd1011.studiof.model.NautilusBoss;
    import de.mediadesign.gd1011.studiof.model.Unit;

    import flash.events.IEventDispatcher;

    public class CollisionProcess implements IProcess
    {
        [Inject]
        public var level:LevelProcess;

        [Inject]
        public var rules:Rules;

        [Inject]
        public var dispatcher:IEventDispatcher;

        private var _running:Boolean;
        private var expCounter:int = 0;

        public function update(time:Number):void
        {
            expCounter++;
            if (expCounter >= 6)
            {
                var noExplosionEvent:GameEvent = new GameEvent(ViewConsts.REMOVE_EXP);
                dispatcher.dispatchEvent(noExplosionEvent);
            }
            for (var i:int = 0; i < level.player.ammunition.length; i++)
            {
                if (rules.isDead(level.player.ammunition[i]))
                {
                    deleteUnits(level.player.ammunition, i);
                    break;
                    break;
                }
                // collision Boss
                if (level.boss.initialized)
                {
                    if (level.boss.idleState)
                        rules.collisionDetection(level.player.ammunition[i], level.boss as Unit);
                    if (level.boss is NautilusBoss)
                    {
                        for (var j:int = 0; j < (level.boss as NautilusBoss).ammunition.length; j++)
                        {
                            rules.collisionDetection(level.player, (level.boss as NautilusBoss).ammunition[j]);
                            rules.collisionDetection(level.player.ammunition[i], (level.boss as NautilusBoss).ammunition[j]);

                            if (rules.isDead((level.boss as NautilusBoss).ammunition[j]))
                            {
                                var explosionEvent:GameEvent = new GameEvent(ViewConsts.EXPLOSION, (level.boss as NautilusBoss).ammunition[j]);
                                dispatcher.dispatchEvent(explosionEvent);
                                deleteUnits((level.boss as NautilusBoss).ammunition, j);
                                break;
                                break;
                            }
                        }
                    }
                }
                // collision SeaMine , Player
                for (var j:int = 0; j < level.enemies.length; j++)
                {
                    //collision playerbullet, enemy
                    rules.collisionDetection(level.player.ammunition[i], level.enemies[j]);

                    if (rules.isDead(level.enemies[j]))
                    {
                        if (!level.boss.initialized)
                        {
                            level.currentScore+=1;
                            var updatePointsEvent:GameEvent = new GameEvent(ViewConsts.ENEMY_KILLED, level.currentScore);
                            dispatcher.dispatchEvent(updatePointsEvent);
                        }

                        if (level.enemies[j].currentPlatform == 2)
                        {
                            var explosionEvent:GameEvent = new GameEvent(ViewConsts.EXPLOSION, level.enemies[j]);
                            dispatcher.dispatchEvent(explosionEvent);
                            deleteUnits(level.enemies, j);
                        }
                        else
                            level.enemies.splice(j, 1);
                        break;
                        break;
                    }
                    if (level.enemies[j].position.x < 0 - GameConsts.ENEMY_SPRITE_WIDTH)
                        deleteUnits(level.enemies, j);
                }
                if (level.player.ammunition[i].position.x > GameConsts.STAGE_WIDTH + GameConsts.ENEMY_SPRITE_WIDTH)
                    deleteUnits(level.player.ammunition, i);
            }

            for (var i:int = 0; i < level.enemies.length; i++)
            {
                //collision player, enemy
                if (level.enemies[i].currentPlatform == 2)
                    rules.collisionDetection(level.player, level.enemies[i]);

                if (rules.isDead(level.enemies[i]))
                {
                    deleteUnits(level.enemies, i);
                    break;
                    break;
                }
            }
            for (var i:int = 0; i < level.enemyBullets.length; i++)
            {
                if (!level.enemyBullets[i].verticalBullet)
                {
                    rules.collisionDetection(level.player, level.enemyBullets[i]);
                }
                else
                {
                    if (level.enemyBullets[i].healthPoints > 0 && level.enemyBullets[i].position.y > level.player.position.y)
                    {
                        level.enemyBullets[i].healthPoints-=1;
                        level.player.healthPoints-=1;
                        var a:GameEvent = new GameEvent(ViewConsts.EXPLOSION, level.enemyBullets[i]);
                        dispatcher.dispatchEvent(a);
                    }
                }
                if (rules.isDead(level.enemyBullets[i]))
                {
                    deleteUnits(level.enemyBullets, i);
//                    var updatePointsEvent:GameEvent = new GameEvent(ViewConsts.ENEMY_KILLED);
//                    dispatcher.dispatchEvent(updatePointsEvent);
                    break;
                    break;
                }
            }
        }
        public function deleteUnits(units:Vector.<Unit>, index:int):void
        {
            level.deleteUnit(units[index]);
            units.splice(index,  1);
        }
        public function start():void
        {
            _running = true
        }
        public function stop():void
        {
            _running = false;
        }
    }
}
