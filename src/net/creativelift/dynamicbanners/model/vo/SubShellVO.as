package net.creativelift.dynamicbanners.model.vo 
{
	import com.adobe.net.URI;

	/**
	 * @author DouG Molidor doug@creativelift.net
	 * @author DouG Molidor doug@creativelift.net
	 */
	
	public class SubShellVO {

		private var _width:Number;
		private var _height:Number;
		private var _clickURL:URI;
		private var _templateURL:URI;
		private var _headline:String;
		private var _hasVideo:Boolean;
		private var _hasData:Boolean;
		private var _hasPhone:Boolean;
		private var _learnMore:String;
		private var _videoBullets:Array;
		private var _dataBullets:Array;
		private var _phoneBullets:Array;
		private var _dollars:String;
		private var _cents:String;
		private var _pricePrefix:String;
		private var _priceSuffix:String;
		private var _term:String;

		public function SubShellVO(width:Number,
								   height:Number,
								   templateURL:URI, 
								   clickURL:URI,
								   headline:String,
								   hasVideo:Boolean,
								   hasData:Boolean,
								   hasPhone:Boolean,
								   learnMore:String,
								   videoBullets:Array,
								   dataBullets:Array,
								   phoneBullets:Array,
								   dollars:String,
								   cents:String,
								   pricePrefix:String,
								   priceSuffix:String,
								   term:String)
								   
		
		{
			this._width = width;
			this._height = height;
			this._templateURL = templateURL;
			this._clickURL = clickURL;
			this._headline = headline;
			this._hasVideo = hasVideo;
			this._hasData = hasData;
			this._hasPhone = hasPhone;
			this._learnMore = learnMore;
			this._videoBullets = videoBullets;
			this._dataBullets = dataBullets;
			this._phoneBullets = phoneBullets;
			this._dollars = dollars;
			this._cents = cents;
			this._pricePrefix = pricePrefix;
			this._priceSuffix = priceSuffix;
			this._term = term;
			
		}

		public function get width():Number
		{
			return _width;
		}
		
		public function get height():Number
		{
			return _height;
		}
		
		public function get clickURL():URI
		{
			return _clickURL;
		}
		
		public function get templateURL():URI 
		{
			return _templateURL;
		}

		public function get headline():String
		{
			return _headline;
		}

		public function get hasVideo():Boolean
		{
			return _hasVideo;
		}

		public function get hasData():Boolean
		{
			return _hasData;
		}

		public function get hasPhone():Boolean
		{
			return _hasPhone;
		}

		public function get learnMore():String
		{
			return _learnMore;
		}

		public function get videoBullets():Array
		{
			return _videoBullets;
		}

		public function get dataBullets():Array
		{
			return _dataBullets;
		}

		public function get phoneBullets():Array
		{
			return _phoneBullets;
		}

		public function get dollars():String
		{
			return _dollars;
		}

		public function get cents():String
		{
			return _cents;
		}

		public function get pricePrefix():String
		{
			return _pricePrefix;
		}

		public function get priceSuffix():String
		{
			return _priceSuffix;
		}

		public function get term():String
		{
			return _term;
		}


	}
}
