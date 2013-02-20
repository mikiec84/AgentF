/**
 * Created with IntelliJ IDEA.
 * User: kisalzmann
 * Date: 19.02.13
 * Time: 13:23
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.model {
    import de.mediadesign.gd1011.studiof.consts.ViewConsts;
    import de.mediadesign.gd1011.studiof.services.Assets;

    import starling.display.Image;

    import starling.display.Sprite;


    public class UpdateTextureSprite extends Sprite{

        public  var textures:Vector.<Image>;
        private var timeCounter:Number = 0;
        private var currentTextureIndex:int = 0;

        public function UpdateTextureSprite(enemyType:String)
        {
            textures = new Vector.<Image>();
            switch(enemyType)
            {
                case(ViewConsts.PLAYER):
                    textures.push(new Image(Assets.getTexture("E1_texture")));
                    textures.push(new Image(Assets.getTexture("E2_texture")));
                    textures.push(new Image(Assets.getTexture("E3_texture")));
                    break;
                case(ViewConsts.FLYING_ENEMY):
                    textures.push(new Image(Assets.getTexture("E1_texture")));
                    textures.push(new Image(Assets.getTexture("E2_texture")));
                    textures.push(new Image(Assets.getTexture("E3_texture")));
                    break;
                case(ViewConsts.FLOATING_ENEMY):
                    textures.push(new Image(Assets.getTexture("E1_texture")));
                    textures.push(new Image(Assets.getTexture("E2_texture")));
                    textures.push(new Image(Assets.getTexture("E3_texture")));
                    break;
                case(ViewConsts.UNDERWATER_ENEMY):
                    textures.push(new Image(Assets.getTexture("E1_texture")));
                    textures.push(new Image(Assets.getTexture("E2_texture")));
                    textures.push(new Image(Assets.getTexture("E3_texture")));
                    break;
            }
            addChild(textures[0]);

        }

        public function updateTexture(time:Number):void
        {
            timeCounter+=time;
            if (timeCounter>=(1/2)) {
                timeCounter = 0;
                currentTextureIndex+=1;
                removeChildren(0, numChildren-1);
                addChild(textures[currentTextureIndex]);
            }

            if (currentTextureIndex+1 == textures.length) {
                currentTextureIndex = -1;
            }
        }










    }




}
