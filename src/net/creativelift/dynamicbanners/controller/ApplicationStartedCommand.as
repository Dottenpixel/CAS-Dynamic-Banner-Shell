package net.creativelift.dynamicbanners.controller 
{
	import net.creativelift.dynamicbanners.signals.PopulateModel;
	
	import org.robotlegs.mvcs.Command;

	/**
	 * @author DouG Molidor doug@creativelift.net
	 */
	
	public class ApplicationStartedCommand extends Command 
	{
		[Inject] public var populateModelSignal:PopulateModel;
		
		override public function execute() : void 
		{
			var paramObj:Object = contextView.stage.loaderInfo.parameters;
			var flashvar:Object = (paramObj.cid != null) ? paramObj : { cid : "41194", altFeed:"http://data.creativelift.net/cas_dynamic/returndatafeedxml.php?x=cha1010_dynamic_shell.xml&cid=", clickTag:"http://adserver.advertising.com/" };
			notify( flashvar );
		}

		private function notify(data:Object):void 
		{
			populateModelSignal.dispatch(data);
		}
	}
}