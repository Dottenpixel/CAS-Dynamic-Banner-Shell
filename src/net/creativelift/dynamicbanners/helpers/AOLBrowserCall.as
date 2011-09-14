package net.creativelift.dynamicbanners.helpers {
	import flash.net.navigateToURL;
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;

	/**
	 * @author FR3SHbook
	 */

	public class AOLBrowserCall {

		private static var browser:String;

		//Uses external interface to reach out to browser and grab browser useragent info.
		private static var browserAgent:String = ExternalInterface.call("function getBrowser(){return navigator.userAgent;}");
		
		public function AOLBrowserCall()
		{

		}
			
		public static function get browserName():String
		{
			//Determines brand of browser using a find index. If not found indexOf returns (-1).
			if(browserAgent != null && browserAgent.indexOf("Firefox") >= 0)  browser = "Firefox";
			else if(browserAgent != null && browserAgent.indexOf("Safari") >= 0) browser = "Safari";
			else if(browserAgent != null && browserAgent.indexOf("MSIE") >= 0) browser = "IE";
			else if(browserAgent != null && browserAgent.indexOf("Opera") >= 0) browser = "Opera";
			else browser = "Undefined";
			
			return (browser);
			
		}
		
		//Function to pop-open ("_blank") new window:
		public static function call(url:String,window:String="_blank",features:String=""):void
		{
			trace( browserAgent, browserName );
			
			//Sets function name into a variable to be executed by ExternalInterface.
			var WINDOW_OPEN_FUNCTION:String = "window.open";
			var myURL:URLRequest = new URLRequest(url);
			
			if(browserName == "Firefox") ExternalInterface.call(WINDOW_OPEN_FUNCTION, url, window, features);
			else if(browserName == "IE") ExternalInterface.call("function setWMWindow() {window.open('" + url + "');}");
			else if(browserName == "Safari") navigateToURL(myURL, window);
			else if(browserName == "Opera") navigateToURL(myURL, window);
			else navigateToURL(myURL, window);
		}

	}
}
