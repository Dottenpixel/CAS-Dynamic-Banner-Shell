package net.creativelift.dynamicbanners.signals
{
	import com.adobe.net.URI;
	
	import org.osflash.signals.Signal;
	
	public class LoadCreative extends Signal
	{
		public function LoadCreative()
		{
			super(URI);
		}
	}
}