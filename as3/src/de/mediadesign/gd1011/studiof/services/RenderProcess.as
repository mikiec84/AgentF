/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 05.02.13
 * Time: 09:58
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.services
{
    import de.mediadesign.gd1011.studiof.model.Renderable;
    import de.mediadesign.gd1011.studiof.view.EnemyView;

    public class RenderProcess implements IProcess
    {
        public var targets:Vector.<Renderable>;

        private var _running:Boolean;

        public function RenderProcess()
        {
            targets = new Vector.<Renderable>();
            start();
        }

        public function registerRenderable(render:Renderable):void
        {
            targets.push(render);
        }

        public function deleteRenderableByID(i:int):void
        {
            targets.splice(i, 1);
        }

		public function deleteRenderable(r:Renderable):void
		{
			targets.splice(targets.indexOf(r),1);
		}

        public function update(time:Number):void
        {
            if (!_running)
                return
            for each ( var target:Renderable in targets)
            {
                target.render(time);
                if (target.view is EnemyView)
                {
                    EnemyView(target.view).timePassed += time;
                    if (EnemyView(target.view).timePassed >= 0.2)
                    {
                        EnemyView(target.view).setNormal();
                        EnemyView(target.view).timePassed = 0;
                    }
                }
            }
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
