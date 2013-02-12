/**
 * Created with IntelliJ IDEA.
 * User: kisalzmann
 * Date: 08.02.13
 * Time: 14:51
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.services {
    import de.mediadesign.gd1011.studiof.model.IMovable;

    public class MoveProcess implements IProcess
    {
        private var targets:Vector.<IMovable>;

        public function MoveProcess()
        {
            targets = new Vector.<IMovable>();
        }

        public function execute():void
        {

        }

        public function update(time:Number):void
        {
            for each(var target:IMovable in targets)
            {
                target.move(time);
            }
        }

        public function addEntity(target:IMovable):void{
            targets.push(target);
        }
    }
}
