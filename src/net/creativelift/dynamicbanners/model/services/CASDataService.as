package net.creativelift.dynamicbanners.model.services {
	import net.creativelift.utils.FlashBug;

	import com.adobe.net.URI;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	
	import net.creativelift.dynamicbanners.interfaces.IDataService;
	import net.creativelift.dynamicbanners.model.ShellModel;
	import net.creativelift.dynamicbanners.model.vo.CASDataVO;
	import net.creativelift.dynamicbanners.model.vo.SubShellVO;
	import net.creativelift.dynamicbanners.signals.CASDataParsedSignal;

	public class CASDataService extends DataService implements IDataService
	{
		[Inject] public var shellModel:ShellModel;
		
		private var _casDataParsed:CASDataParsedSignal;
		
		override public function getCASData(feedURL:URI):void
		{
			_casDataParsed = new CASDataParsedSignal();
			
			if(!feedURL.isValid())
			{
				throw new URIError("Invalid feed URL provided");
			}
			var dataLoader:URLLoader = new URLLoader();
			dataLoader.dataFormat = URLLoaderDataFormat.TEXT;
			dataLoader.load(new URLRequest(feedURL.toString()));
			
			dataLoader.addEventListener(Event.COMPLETE, onLoad);
		}
		
		private function onLoad(e:Event):void
		{
			var casDataVO:CASDataVO = parseXMLAsCASData(new XML(e.target.data))
			_casDataParsed.dispatch(casDataVO);
		}
		
		private function parseXMLAsCASData(xml:XML):CASDataVO
		{
			var swfURL:String = String(xml.@swf);
			var regExp_tokenName:RegExp = /\[size\]/;

			//var fl:FlashBug = new FlashBug();
			//fl.log( shellModel.IEAdjustedBannerW || shellModel.bannerW );

			var bannerSizeStr:String = ( shellModel.IEAdjustedBannerW || shellModel.bannerW ) + "x" + shellModel.bannerH;
			
			var templateURL:String = regExp_tokenName.test(swfURL) ? swfURL.replace(regExp_tokenName, bannerSizeStr) : swfURL;
			
			//var o:Object = new Object();
			/*for each( var n:* in xml.param ) {
				o[n.@name.toString()] = n.@value.toString();
			}*/
			
			var headline:String = xml.headline;
			var hasVideo:Boolean = (xml.services.video.toString() == "true") ? true : false;
			var hasData:Boolean = (xml.services.data.toString() == "true") ? true : false;
			var hasPhone:Boolean = (xml.services.phone.toString() == "true") ? true : false;
			
			var learnMore:String = xml.learnMore;
			var videoBullets:Array = [];
			var dataBullets:Array = [];
			var phoneBullets:Array = [];
			
			for each(var bullet:XML in xml.bullets.bullet)
			{
				switch(bullet.@service.toString()){
					case "video": videoBullets.push(bullet);
						break;
					case "data": dataBullets.push(bullet);
						break;
					case "phone": phoneBullets.push(bullet);
						break;
				}
			}
			
			var dollars:String = xml.price.dollars;
			var cents:String = xml.price.cents;
			var prefix:String = xml.price.prefix;
			var suffix:String = xml.price.suffix;
			var term:String = xml.price.term;
			
			var subShellVO:SubShellVO = new SubShellVO(shellModel.bannerW,
														shellModel.bannerH,
														new URI(String(templateURL)), 
														new URI(String(xml.@clickURL)),
														headline,
														hasVideo,
														hasData,
														hasPhone,
														learnMore,
														videoBullets,
														dataBullets,
														phoneBullets,
														dollars,
														cents,
														prefix,
														suffix,
														term);
			var casDataVO:CASDataVO = new CASDataVO(subShellVO);
			
			return casDataVO;
		}
		
		override public function get casDataParsed():CASDataParsedSignal
		{
			return _casDataParsed;
		}
	}
}