/*
*  FlashBug v1.3
*  by Aaron Bassett (htp://www.foobr.co.uk)
*
*  Use the Firebug console to debug flash
*  Thanks to joe hewitt for Firebug (http://www.getfirebug.com/)
*
*  Copyright (C) 2007  Aaron Bassett
*  http://creativecommons.org/licenses/LGPL/2.1/
*
*
* converted to ActionScript 3.0 compliant by Ming Yong & Navin Kumar
* Voiceroute (www.voiceroute.net)
* ming@voiceroute.net
* navin@voiceroute.net
*/
package {
	import flash.external.*;
	import flash.utils.getTimer;

	public class FlashBug {
	
		public var doTrace:Boolean;
		public var live:Boolean;
	
		public var lastGroup:Object;
		public var groupPrefix:Object;
		public	var timers:Object;
	
		public var warnBoundary:Object;
		public var errorBoundary:Object;
	
		public var prefixLog:Object;
		public var prefixInfo:Object;
		public var prefixDebug:Object;
		public var prefixWarning:Object;
		public var prefixError:Object;
		public var prefixGroup:Object;
	
		/*
		  Setup FlashBug
		*/
		public function FlashBug(doTrace:Boolean=true, warnBoundary:String=null, errorBoundary:String=null):void {
	
			this.live = false;
			this.timers = new Object();
	
			//setup trace if required
			if(doTrace) {
				this.doTrace = true;
				// Boundaries help highlight important messages in output console
				// as we cant color them :(
				this.warnBoundary  = (warnBoundary)  ? warnBoundary  : "ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÐ";
				this.errorBoundary = (errorBoundary) ? errorBoundary : "**************************************************************";
				this.setPrefixes();
			} else {
				this.doTrace = false;
			}
		}
	
		/*
		*  When ready finished debugging & pushing live
		*  call console.goLive(); rather than having to remove all debug messages from code
		*  should save errors in browsers without Firebug & stop people snooping your
		*  debug messages
		*/
		public function goLive():void {
			this.live = true;
		}
	
		/*
		  Prefixes for trace()
		  Make sure they all aline up nicely in output console
		*/
		public function setPrefixes():void {
			this.prefixLog      = "LOG:       ";
			this.prefixInfo     = "INFO:      ";
			this.prefixDebug    = "DEBUG:     ";
			this.prefixWarning  = "WARNING:   ";
			this.prefixError    = "ERROR:     ";
			this.prefixGroup    = "";
		}
	
		/*
		  Can be used to check if the firebug is responding/installed
		*/
		public function available():Boolean {
			if(this.live) return false;
			return (ExternalInterface.call("console.firebug.toString") == null) ? false : true;
		}
	
		public function log(msg:*):void {
			if(this.live) return;
			if(this.doTrace) trace(this.prefixGroup + this.prefixLog + msg);
			ExternalInterface.call("console.log", msg);
		}
	
		public function info(msg:String):void {
			if(this.live) return;
			if(this.doTrace) trace(this.prefixGroup + this.prefixInfo + msg);
	
			ExternalInterface.call("console.info", msg);
		}
	
		public function debug(msg:Object):void {
			if(this.live) return;
			if(this.doTrace) trace(this.prefixGroup + this.prefixDebug + msg);
			ExternalInterface.call("console.debug", msg);
		}
	
		public function warn(msg:Object):void {
			if(this.live) return;
			if(this.doTrace) {
				trace(this.prefixGroup + this.warnBoundary);
				trace(this.prefixGroup + this.prefixWarning + msg);
				trace(this.prefixGroup + this.warnBoundary);
			}
			ExternalInterface.call("console.warn", msg);
		}
	
		public function error(msg:Object):void {
			if(this.live) return;
			if(this.doTrace) {
				trace(this.prefixGroup + this.errorBoundary);
				trace(this.prefixGroup + this.prefixError + msg);
				trace(this.prefixGroup + this.errorBoundary);
			}
			ExternalInterface.call("console.error", msg);
		}
	
		/*
		  All group messages are prefixed to show they are in a group
		*/
		public function group(msg:Object):void {
			if(this.live) return;
			this.lastGroup = msg;
			this.prefixGroup = " //  ";
	
			if(this.doTrace) {
				trace("");
				trace(this.prefixGroup + "[ Start group: " + msg + " ]");
			}
			ExternalInterface.call("console.group", msg);
		}
	
		public function groupEnd():void {
			if(this.live) return;
			if(this.doTrace) {
				trace(this.prefixGroup + "[ End group: " + this.lastGroup + " ]");
				trace("");
			}
			ExternalInterface.call("console.groupEnd");
			this.prefixGroup = "";
		}
	
		public function time(name:String):void {
			if(this.live) return;
		  this.timers[name] = getTimer();
			ExternalInterface.call("console.time", name);
		}
	
		public function timeEnd(name:String, returnTime:Boolean):int {
			if(this.live) return int.MIN_VALUE;
			var timeTaken:int = getTimer() - this.timers[name];
			if(returnTime) return timeTaken;
	
			if(this.doTrace) trace(this.prefixGroup + name +": " +timeTaken+"ms");
			ExternalInterface.call("console.timeEnd", name);
			return int.MIN_VALUE;
		}
	
		public function assert(expression:String):void {
			if(this.live) return;
			if(this.doTrace) {
				var check:Boolean = Boolean(expression);
				if(check==false) {
					trace(this.prefixGroup + this.errorBoundary);
					trace(this.prefixGroup + this.prefixError +"Assertion Failure [ "+expression+" ]");
					trace(this.prefixGroup + this.errorBoundary);
				}
			}
			ExternalInterface.call("console.assert", expression);
		}
	
		// no trace() for this - Firebug only!
		public function profile(name:String):void {
			if(!this.live) ExternalInterface.call("console.profile", name);
		}
	
		public function profileEnd(name:String):void {
			if(!this.live) ExternalInterface.call("console.profileEnd", name);
		}
	
		public function count(title:String):void {
			if(!this.live) ExternalInterface.call("console.count", title);
		}
	
		public function spacer():void {
			if(this.live) return;
			if(this.doTrace) trace("");
			ExternalInterface.call("console.debug", "     ");
		}
	}
}