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
        public static var INIT_PLAYER:String = getQualifiedClassName(this)+"INIT_PLAYER";
        public static var INIT_GAME:String = getQualifiedClassName(this)+"INIT_GAME";

        public static var MAX_PLATFORM:uint = 6;

    }
}
