/**
 * Created with IntelliJ IDEA.
 * User: anlicht
 * Date: 13.02.13
 * Time: 16:36
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof
{
	import flash.system.Capabilities;

	public class SystemInfo
	{
		private static var _dp:Number = 0;
		public static function getDP():Number
		{
			if(_dp == 0)
			{
				var serverString:String = unescape(Capabilities.serverString);
				var reportedDpi:Number = Number(serverString.split("&DP=", 2)[1]);
				_dp = 160/reportedDpi;
			}
			return _dp;
		}
	}
}
