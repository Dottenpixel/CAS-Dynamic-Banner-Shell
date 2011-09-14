package net.creativelift.dynamicbanners.model.services 
{
	import com.adobe.net.URI;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	
	import net.creativelift.dynamicbanners.model.ShellModel;
	import net.creativelift.dynamicbanners.signals.CreativeLoadedSignal;
	import net.creativelift.utils.FlashBug;
	
	import org.robotlegs.mvcs.Actor;

	/**
	 * @author FR3SHbook
	 */
	
	public class CreativeService extends Actor 
	{
		[Inject] public var model:ShellModel;

		private const LOADER_ID:String = "SWFLoader";
		private const CONTENT_ID:String = "productHeroSWF";
		
		private var _creativeLoadedSignal:CreativeLoadedSignal;
		private var _swf:MovieClip;

		public function loadSWF(swfSource:URI):void 
		{			
			
			if(!swfSource.isValid())
			{
				throw new URIError("Invalid Creative URL Provided");
			}
			
			_creativeLoadedSignal = new CreativeLoadedSignal();
			
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			loader.contentLoaderInfo.addEventListener(Event.INIT, onInit);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			loader.load(new URLRequest(swfSource.toString()));
		}
		
		private function onInit(e:Event):void
		{
			_swf = e.currentTarget.content as MovieClip;
			_swf["data"] = model.casData.subShell as Object;
		}
		
		private function onComplete(e:Event):void
		{
			_creativeLoadedSignal.dispatch(_swf);
		}
		
		private function onIOError(e:IOErrorEvent):void
		{
			throw new IOError("io error loading swf: " + e);
		}
		
		public function get creativeLoadedSignal():CreativeLoadedSignal
		{
			return _creativeLoadedSignal;
		}
	}
}
