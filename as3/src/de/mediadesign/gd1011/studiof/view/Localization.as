/**
 * Created with IntelliJ IDEA.
 * User: anlicht
 * Date: 26.02.13
 * Time: 13:18
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view
{
	import de.mediadesign.gd1011.studiof.services.JSONReader;

	import flash.globalization.LocaleID;
	import flash.system.Capabilities;

	public class Localization
	{
		private static var _currentLanguage:String;
		private static var _strings = JSONReader.read("strings");

		public static function getString(key:String):String
		{
			if(_currentLanguage==null)
			{
				_currentLanguage = Capabilities.language.substr(0,2);
				if(_strings[_currentLanguage]==null)
					_currentLanguage = "en";
			}

			var outString:String = _strings[_currentLanguage][key];
			if(outString == null)
				outString = "no value"
			return outString;
		}
	}
}
