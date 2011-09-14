package net.creativelift.dynamicbanners.signals
{
	import net.creativelift.dynamicbanners.model.vo.CASDataVO;
	
	import org.osflash.signals.Signal;
	
	public class CASDataParsedSignal extends Signal
	{
		public function CASDataParsedSignal()
		{
			super(CASDataVO);
		}
	}
}