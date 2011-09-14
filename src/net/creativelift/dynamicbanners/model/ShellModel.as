package net.creativelift.dynamicbanners.model 
{
	import net.creativelift.dynamicbanners.model.vo.CASDataVO;
	
	import org.robotlegs.mvcs.Actor;
	
	public class ShellModel extends Actor 
	{
		public var subShellSWFSource:String;
		private var message : String;
		private var _campaignId : String;
		private var _casResponseData : XML;
		private var _dataURLPrefix : String;
		private var _bannerW:Number;
		private var _bannerH:Number;
		private var _IEAdjustedBannerW : Number;
		
		private var _casData:CASDataVO;
		private var _adServerClickTag : String;

		public function ShellModel();
		
		public function get campaignId():String 
		{
			return _campaignId;
		}
		
		public function set campaignId( cid:String ):void 
		{
			_campaignId = cid;
		}
		
		public function get dataURLPrefix():String
		{
			return _dataURLPrefix;	
		}
		
		public function set dataURLPrefix( p_value:String ):void 
		{
			_dataURLPrefix = p_value;
		}

		public function get bannerW():Number 
		{
			return _bannerW;	
		}
		
		public function set bannerW(w:Number):void 
		{
			_bannerW = w;
		}

		public function get bannerH():Number 
		{
			return _bannerH;	
		}
		
		public function set bannerH(h:Number):void 
		{
			_bannerH = h;
		}
		

		public function get IEAdjustedBannerW():Number 
		{
			return _IEAdjustedBannerW;	
		}
		
		public function set IEAdjustedBannerW(w:Number):void 
		{
			_IEAdjustedBannerW = w;
		}		
		
		public function get adServerClickTag():String 
		{
			return _adServerClickTag;	
		}

		public function set adServerClickTag( p_value:String ):void 
		{
			_adServerClickTag = p_value;
		}
		
		public function get casData():CASDataVO 
		{
			return _casData;	
		}
		
		public function set casData( p:CASDataVO ):void 
		{
			_casData = p;
		}
		
	}	

}