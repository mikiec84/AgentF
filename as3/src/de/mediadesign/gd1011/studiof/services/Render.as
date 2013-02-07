/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 05.02.13
 * Time: 09:58
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.services
{
    import de.mediadesign.gd1011.studiof.view.IRenderable;

    public class Render
    {
        private var targets:Vector.<IRenderable>;

        public function start():Boolean
        {
            return true;
        }

        public function update(time:Number):void
        {
            for each ( var target:IRenderable in targets)
            {
                target.render();
            }
        }
    }
}
