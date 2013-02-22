/**
 * Created with IntelliJ IDEA.
 * User: kisalzmann
 * Date: 21.02.13
 * Time: 09:37
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.model {
    public interface IEndboss
    {
        function start():void;              //startet den boss und aktiviert die spawnbosscommand
        function reset():void;              //resettet nur interne Werte, muss noch woanders von moveProcess, renderProcess und stage entfernt werden!
    }
}
