package net.creativelift.dynamicbanners
{
	import flash.display.DisplayObjectContainer;
	
	import net.creativelift.dynamicbanners.controller.*;
	import net.creativelift.dynamicbanners.model.services.*;
	import net.creativelift.dynamicbanners.signals.*;
	import net.creativelift.dynamicbanners.interfaces.IDataService;
	import net.creativelift.dynamicbanners.model.ShellModel;
	import net.creativelift.dynamicbanners.view.ShellView;
	import net.creativelift.dynamicbanners.view.ShellViewMediator;
	
	import org.robotlegs.mvcs.SignalContext;

	/**
	 * @author dougefresh
	 */
	public class DynBannerShellContext extends SignalContext
	{
		public function DynBannerShellContext(contextView : DisplayObjectContainer = null, autoStartup : Boolean = true) 
		{
			super(contextView, autoStartup);
		}
		
		override public function startup():void 
		{
			
			// Map Services
			injector.mapSingletonOf(IDataService, CASDataService);
			injector.mapSingleton(CreativeService);
			
			// Map Model
			injector.mapSingleton( ShellModel );

			// Map Signals
			injector.mapSingleton(InitViewSignal);
			
			// Map Mediators
			mediatorMap.mapView(ShellView, ShellViewMediator);
			contextView.addChild(new ShellView());

			// Map Signals to Commands
			signalCommandMap.mapSignalClass(PopulateModel, PopulateModelCommand);
			signalCommandMap.mapSignalClass(LoadCreative, LoadCreativeCommand);
			
			
			ApplicationStarted(signalCommandMap.mapSignalClass(
				ApplicationStarted, ApplicationStartedCommand, true)).dispatch();
		}
	}
}
