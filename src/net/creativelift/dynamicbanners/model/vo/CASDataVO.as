package net.creativelift.dynamicbanners.model.vo
{
	import net.creativelift.dynamicbanners.interfaces.ICASData;
	
	public class CASDataVO implements ICASData
	{
		private var _subShell:SubShellVO;
		
		public function CASDataVO(sbvo:SubShellVO)
		{
			_subShell = sbvo;
		}
		
		public function get subShell():SubShellVO
		{
			return _subShell;
		}
	}
}