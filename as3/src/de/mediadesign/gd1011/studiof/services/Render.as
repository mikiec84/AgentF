/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 05.02.13
 * Time: 09:58
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.services
{
    import de.mediadesign.gd1011.studiof.model.components.IRenderable;
    import de.mediadesign.gd1011.studiof.model.components.Renderable;

    public class Render implements IProcess
    {
        private var targets:Vector.<Renderable>;

        public function Render()
        {
            targets = new Vector.<Renderable>();
        }

        public function start():Boolean
        {
            return true;
        }

        public function update(passedTime:Number):void
        {
            for each ( var target:IRenderable in targets)
            {
                target.render();
            }
        }

        public function addEntity(target:Renderable):void
        {
            targets.push(target);
        }

    }
}
