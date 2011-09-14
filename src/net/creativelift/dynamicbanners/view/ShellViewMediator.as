package net.creativelift.dynamicbanners.view {
	import net.creativelift.dynamicbanners.helpers.AOLBrowserCall;

	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import net.creativelift.dynamicbanners.model.ShellModel;
	import net.creativelift.dynamicbanners.signals.InitViewSignal;
	
	import org.robotlegs.mvcs.Mediator;

	/**
	 * @author dougefresh
	 */
	
	public class ShellViewMediator extends Mediator 
	{
		[Inject] public var shellView:ShellView;
		[Inject] public var initView:InitViewSignal;
		[Inject] public var model:ShellModel;

		private var subShellSWFClip : MovieClip;
		private var btnClickTag : Sprite;

		override public function onRegister():void 
		{
			initView.add(SWFReady);
		}

		public function SWFReady( swf:MovieClip ):void
		{
			displaySWFFile( swf );
			displayBorderClickTag();
		}

		private function displaySWFFile(swf:MovieClip):void
		{
			subShellSWFClip = swf;
			shellView.addChild( subShellSWFClip );
			subShellSWFClip.gotoAndPlay("start");
		}
		
		private function displayBorderClickTag():void
		{
			shellView.addChild( drawTag() );
		}
		
		private function drawTag() : Sprite 
		{
			btnClickTag = new Sprite();
			btnClickTag.buttonMode = true;
			btnClickTag.mouseChildren = false;
			btnClickTag.graphics.lineStyle(2, 0x000000);
			btnClickTag.graphics.beginFill(0xff0000, 0);
			btnClickTag.graphics.drawRect(0, 0, model.bannerW, model.bannerH);
			btnClickTag.graphics.endFill();
			btnClickTag.addEventListener( MouseEvent.CLICK, onAOLClickTagClick );
			return btnClickTag;
		}

		private function onClickTagClick( e:MouseEvent ) : void {
			var urlReq:URLRequest = new URLRequest( model.casData.subShell.clickURL.toString() );
			navigateToURL( urlReq );
		}
		
		private function onAOLClickTagClick( e:MouseEvent ):void {
			var destURL:String = model.casData.subShell.clickURL.toString();
			var adserverClickTag:String = model.adServerClickTag;
			var url:String = adserverClickTag+destURL;
			AOLBrowserCall.call(url);
		}
	}
}
