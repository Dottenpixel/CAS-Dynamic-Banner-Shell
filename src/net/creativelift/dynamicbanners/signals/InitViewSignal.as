package net.creativelift.dynamicbanners.signals
{
	import flash.display.MovieClip;
	
	import org.osflash.signals.Signal;
	
	public class InitViewSignal extends Signal
	{
		public function InitViewSignal()
		{
			super(MovieClip);
		}
	}
}