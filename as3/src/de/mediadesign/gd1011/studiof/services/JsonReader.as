/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 06.02.13
 * Time: 11:26
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.services
{


    import flash.filesystem.File;
    import flash.filesystem.FileMode;
    import flash.filesystem.FileStream;

    public class JSONReader
    {
        public static function read(filename:String):Object
        {
            var configFile:File = File.applicationDirectory.resolvePath("config/"+filename+".json");
            var fileStream:FileStream = new FileStream();
            fileStream.open(configFile, FileMode.READ);
            var jsonData:String = fileStream.readUTFBytes(fileStream.bytesAvailable);
            var config:Object = JSON.parse(jsonData);
            fileStream.close();

            return config;
        }
    }
}
