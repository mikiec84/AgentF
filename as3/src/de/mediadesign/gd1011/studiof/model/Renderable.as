/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 07.02.13
 * Time: 11:32
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.model
{
    import de.mediadesign.gd1011.studiof.consts.GameConsts;
    import de.mediadesign.gd1011.studiof.consts.ViewConsts;
    import de.mediadesign.gd1011.studiof.model.components.PositionComponent;
    import de.mediadesign.gd1011.studiof.services.JSONReader;
    import de.mediadesign.gd1011.studiof.view.BulletView;
    import de.mediadesign.gd1011.studiof.view.EnemyView;

    import starling.display.Sprite;

    public class Renderable
    {
        public var position:PositionComponent;
        public var view:Sprite;

        public var JSONExtractedInformation:Object;
        private var flyingOffset:int;
        private var swimmingOffset:int;

        public function Renderable(pos:PositionComponent, view:Sprite)
        {
            this.position = pos;
            this.view = view;
            JSONExtractedInformation = JSONReader.read("viewconfig")["viewOffsets"];
            flyingOffset = JSONExtractedInformation["Flying"];
            swimmingOffset = JSONExtractedInformation["Swimming"];

        }

        public function render(time:Number):void
        {
            view.alpha = 1;
            view.x = position.x;
            if (((view is EnemyView) && (view as EnemyView).enemyType == ViewConsts.PLAYER) || (view is BulletView && (view as BulletView).master.isPlayer))
            {
                view.y = position.y+swimmingOffset;
            }
            else
            {
                if (observePlatform(position.y)<2)
                {
                    view.y = position.y-flyingOffset;
                }
                else
                {
                    view.y = position.y+swimmingOffset;
                }
            }
        }

        public function observePlatform(y:int):int
        {
            var newEbene:int = 10;
            if (y>=0)                                                            {newEbene = 0;}
            if (y+1>GameConsts.STAGE_HEIGHT/6)                                   {newEbene = 1;}
            if (y+1>GameConsts.STAGE_HEIGHT/3)                                   {newEbene = 2;}
            if (y+1>GameConsts.STAGE_HEIGHT/2)                                   {newEbene = 3;}
            if (y+1>GameConsts.STAGE_HEIGHT*(2/3))                               {newEbene = 4;}
            if (y+1>GameConsts.STAGE_HEIGHT*(5/6) && y<=GameConsts.STAGE_HEIGHT) {newEbene = 5;}
            //trace(newEbene+","+y);
            return newEbene;
        }
    }
}
