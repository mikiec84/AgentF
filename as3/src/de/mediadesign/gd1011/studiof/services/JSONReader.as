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
		private static var _files:Object = new Object();
        public static function read(filename:String):Object
        {
			if(_files[filename]!= null)
				return _files[filename];
			trace("[JSONReader] Load file "+filename+".json");
            var configFile:File = File.applicationDirectory.resolvePath("config/"+filename+".json");
            var fileStream:FileStream = new FileStream();
            fileStream.open(configFile, FileMode.READ);
            var jsonData:String = fileStream.readUTFBytes(fileStream.bytesAvailable);
            var config:Object = JSON.parse(jsonData);
            fileStream.close();
			_files[filename]=config;
            return config;
        }
    }
}
