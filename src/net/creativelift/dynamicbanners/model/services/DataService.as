package net.creativelift.dynamicbanners.model.services 
{
	import com.adobe.net.URI;
	
	import net.creativelift.dynamicbanners.interfaces.IDataService;
	import net.creativelift.dynamicbanners.signals.CASDataParsedSignal;
	
	import org.robotlegs.mvcs.Actor;

	/**
	 * @author DouG Molidor doug@creativelift.net
	 */
	
	public class DataService extends Actor implements IDataService 
	{
		public function DataService():void
		{
			
		}
		
		public function getCASData(feedURL:URI):void
		{
			
		}
		
		public function get casDataParsed():CASDataParsedSignal
		{
			return new CASDataParsedSignal();
		}
	}
}
