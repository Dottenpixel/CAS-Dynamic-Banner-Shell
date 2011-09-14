package net.creativelift.dynamicbanners.interfaces {
	import com.adobe.net.URI;
	
	import net.creativelift.dynamicbanners.model.vo.SubShellVO;
	import net.creativelift.dynamicbanners.signals.CASDataParsedSignal;

	/**
	 * @author DouG Molidor doug@creativelift.net
	 */
	public interface IDataService {

		//function getSubShellDockingObject( data:String ):SubShellVO;
		function getCASData(feedURL:URI):void;
		function get casDataParsed():CASDataParsedSignal;
	}
}
