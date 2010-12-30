package TradingApi.Client.Core
{	
	import TradingApi.Client.Core.WebClient.WebClient;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import mx.core.Application;
	import mx.rpc.events.ResultEvent;
	
	public class Branding
	{
		private static var _eventDispatcher:EventDispatcher;
			
		private static var _resourceURL:String;
		private static var _resourceXML:XML;
		private static var _resourceXMLRequest:URLRequest;
		private static var _resourceXMLLoader:URLLoader;
		private static var _webClient:WebClient;
		
		private static var _backgroundImageUrl:String = "";
		private static var _backgroundColor:int = 0x000000;
		private static var _language:int = 0;
		
		public static function Initialize():void
		{
			try
			{
				_eventDispatcher = new EventDispatcher();
			}
			catch(err:Error)
			{
				//Errors.Handle(err);
			}
		}
		
		public static function Load(brandingSettingsUrl:String):void
		{
			try
			{
				_resourceURL = brandingSettingsUrl;		
				_resourceXML = new XML();
				
				
				_resourceXMLRequest = new URLRequest(_resourceURL);
				_resourceXMLLoader = new URLLoader();
				_resourceXMLLoader.addEventListener(Event.COMPLETE, onResourcesComplete);
				_resourceXMLLoader.addEventListener(IOErrorEvent.IO_ERROR, onResourcesError);
				_resourceXMLLoader.load(_resourceXMLRequest);
				
				
				/*
				_webClient = WebClientFactory.Create();
				_webClient.addEventListener(WebClient.WEB_RESPONSE_EVENT, onResourcesComplete);
				_webClient.BeginRequest(_resourceURL);
				*/
				
			}
			catch(err:Error)
			{
				//Errors.Handle(err);
			}
		}
		
		public static function get Events():EventDispatcher
		{
			return _eventDispatcher;
		}
		
		private static function onResourcesComplete(event:Event):void
		{
			_resourceXML = ((XML)(_resourceXMLLoader.data));
			
			var baseUrl:String = _resourceURL.substring(0, _resourceURL.lastIndexOf("/"));
			_backgroundImageUrl = baseUrl + _resourceXML.Background_image_url[0];
			_backgroundColor = parseInt("0x"+(_resourceXML.Background_colour[0]).substr(1,7));
			_language = _resourceXML.Language[0];
				
			var e:Event = new Event("BrandingComplete");
			_eventDispatcher.dispatchEvent(e);
		}
		
		private static function onResourcesError(event:IOErrorEvent):void
		{
			// Dispatch event anyway, consumers will load the default values --Chase
			var e:Event = new Event("BrandingComplete");
			_eventDispatcher.dispatchEvent(e);
		}
		
		public static function get BackgroundImageUrl():String
		{
			return _backgroundImageUrl;
		}
		
		public static function get BackgroundColor():int
		{
			return _backgroundColor;
		}
		
		public static function get Language():int
		{
			return _language;
		}
		
		public static function get ResourceXML():XML
		{
			return _resourceXML;
		}
		
		public static function loadStringResource(id:String):String
		{	
			var val:String;
			try 
			{
				val = _resourceXML.data.(@name == id).value;
				
				if (val == null)
					val = id;
			}
			catch(err:Error)
			{
				val = id;
			}
			return val;
		}
		
	}
}


