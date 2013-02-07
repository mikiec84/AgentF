/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 05.02.13
 * Time: 09:45
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.manager
{
    import de.mediadesign.gd1011.studiof.model.Unit;

    public class MovementManager implements IMovementManager
    {
        public function MovementManager()
        {
        }

        public function tick(allRelevantUnits:Array):void{
            for (var index:int = 0; index<allRelevantUnits.length; index++) {
                if (allRelevantUnits[index].movement.horizontalVelocityEnabled) {
                    allRelevantUnits[index].movement.pos.x += allRelevantUnits[index].movement.directionVector[0];
                    allRelevantUnits[index].movement.pos.y += allRelevantUnits[index].movement.directionVector[1];//falls sie sich nicht in einer absolut geraden linie bewegen
                } else if (allRelevantUnits[index].movement.verticalVelocityEnabled) {
                    //Falls die Vertikale Bewegung der Unit erlaubt ist sollt dieser Block ausgeführt werden
                }
            }
        }

        public function handlePlayerMovement(yKoord:int, Player:Unit){

        }
    }
}
