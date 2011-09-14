package net.creativelift.dynamicbanners.signals
{
	import flash.display.MovieClip;
	
	import org.osflash.signals.Signal;
	
	public class CreativeLoadedSignal extends Signal
	{
		public function CreativeLoadedSignal()
		{
			super(MovieClip);
		}
	}
}