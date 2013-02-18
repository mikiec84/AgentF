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
    import de.mediadesign.gd1011.studiof.model.Unit;

    public class Rules
    {
        private var JSONExtractedInformation:Object;

        public var collisionTolerance:int;


        public function Rules():void
        {
            JSONExtractedInformation = JSONReader.read("enemy")["ENEMY"];
            collisionTolerance = JSONExtractedInformation["collisionTolerance"];
        }

        // first unit: movement -->
        // second unit: movement <--
        public function collisionDetection(unit1:Unit, unit2:Unit):void
        {
            if (unit2.position.x < GameConsts.STAGE_WIDTH)
            {
                if (unit1.currentPlatform == unit2.currentPlatform
                        && unit1.position.x + collisionTolerance >= unit2.position.x)
                {
                    unit1.healthPoints--;
                    unit2.healthPoints--;
                }
            }
            if (unit1.position.x > GameConsts.STAGE_WIDTH)
                unit1.healthPoints = 0;
            if (unit2.position.x < 0)
                unit2.healthPoints = 0;
        }

        public function isDead(unit:Unit):Boolean
        {
            return (unit.healthPoints <= 0);
        }

        public function loose(player:Unit):Boolean
        {
            return isDead(player);
        }
    }
}
