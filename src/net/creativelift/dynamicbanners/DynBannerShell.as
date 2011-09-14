package net.creativelift.dynamicbanners {
	import flash.external.ExternalInterface;

	import net.creativelift.dynamicbanners.helpers.AOLBrowserCall;
	import net.creativelift.utils.FlashBug;

	import flash.events.Event;
	import flash.system.Security;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display.Sprite;
	
	[SWF(frameRate='30', backgroundColor='#FFFFFF')]
	
	public class DynBannerShell extends Sprite {
		private static const CONTEXT_INIT : String = "contextInit";
		private var context : DynBannerShellContext;
		private var fl : FlashBug = new FlashBug();

		public function DynBannerShell()
		{
			Security.allowDomain("*");
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			stage.addEventListener(Event.RESIZE, sizeListener);
			loaderInfo.addEventListener(Event.INIT, onLoaderInfo);
			addEventListener( CONTEXT_INIT, onContextInit );
			stage.dispatchEvent(new Event(Event.RESIZE));
		}

		private function onContextInit(event : String) : void {
			if( stage.stageWidth > 0 && stage.stageHeight > 0 ) {
				fl.log( "Context Init:" + stage.stageWidth + "x" + stage.stageHeight );
				removeEventListener( CONTEXT_INIT, onContextInit );
				context = new DynBannerShellContext(this);
			}
		}

		//most time it is this event relay that will init the banner
		private function onLoaderInfo( e:Event ) : void {
			fl.log( "LoaderInfo Ready:" + stage.stageWidth + "x" + stage.stageHeight );
			dispatchEvent( new Event( CONTEXT_INIT ) );
		}

		//on a cached SWF in IE, the RESIZE event seems to fire until it finds a value > 0
		private function sizeListener( e:Event ) : void {
			fl.log( "Stage Resized:" + stage.stageWidth + "x" + stage.stageHeight );
			dispatchEvent( new Event( CONTEXT_INIT ) );
		}
	}
}