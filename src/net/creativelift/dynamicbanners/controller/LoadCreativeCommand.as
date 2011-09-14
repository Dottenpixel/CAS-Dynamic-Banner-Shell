package net.creativelift.dynamicbanners.controller
{
	import com.adobe.net.URI;
	
	import flash.display.MovieClip;
	
	import net.creativelift.dynamicbanners.model.ShellModel;
	import net.creativelift.dynamicbanners.model.services.CreativeService;
	import net.creativelift.dynamicbanners.signals.InitViewSignal;
	import net.creativelift.dynamicbanners.view.ShellView;
	
	import org.robotlegs.mvcs.Command;
	
	public class LoadCreativeCommand extends Command
	{
		[Inject] public var url:URI;
		[Inject] public var initViewSignal:InitViewSignal;
		[Inject] public var shellModel:ShellModel;
		[Inject] public var assetService:CreativeService;
		
		override public function execute():void
		{
			assetService.loadSWF(url);
			assetService.creativeLoadedSignal.add(creativeLoaded);
		}
		
		private function creativeLoaded(swf:MovieClip):void
		{
			initViewSignal.dispatch(swf);
		}
	}
}