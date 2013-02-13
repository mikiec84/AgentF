/**
 * Created with IntelliJ IDEA.
 * User: kisalzmann
 * Date: 06.02.13
 * Time: 14:22
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.model.components
{
    import de.mediadesign.gd1011.studiof.consts.GameConsts;

    public class PositionComponent
    {

        public var x:int;
        public var y:int;
        public var currentRotation:int;

        public function PositionComponent()
        {
            x = 0;
            y = GameConsts.EBENE_HEIGHT*2+100;
            currentRotation = 0;
        }
    }
}
