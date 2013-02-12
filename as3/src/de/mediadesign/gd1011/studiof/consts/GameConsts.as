/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 05.02.13
 * Time: 13:27
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.consts
{
    import flash.utils.getQualifiedClassName;

    public class GameConsts
    {
        public static const INIT_PLAYER:String = /*getQualifiedClassName(this)+*/"INIT_PLAYER";
        public static const INIT_GAME:String   = /*getQualifiedClassName(this)+*/"INIT_GAME";
        public static const ADD_ENEMY:String = "ADD_ENEMY";
        public static const REGISTER_ENEMY:String = "REGISTER_ENEMY";
        public static const ADD_SPRITE_TO_GAME:String = "ADD_SPRITE_TO_GAME";

        public static const STAGE_HEIGHT:int   = 720;
        public static const STAGE_WIDTH:int    = 1280;
        public static const EBENE_HEIGHT:int    = 120;
        public static const PLAYER_HEIGHT:int  = 226;
        public static const PLAYER_START_HEIGHT = 240;

        public static const MAX_PLATFORM:uint = 6;

    }
}
