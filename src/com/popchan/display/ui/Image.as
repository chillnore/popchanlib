package com.popchan.display.ui
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	
	/**
	 *图片组件
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	public class Image extends Component
	{
		protected var _url:String;
		protected var _loader:Loader;
		protected var _urlRequest:URLRequest;
		protected var _content:DisplayObject;
		protected var _aspectRatio:Boolean=true;
		protected var _scaleContent:Boolean;
		protected var _unscaleWidth:Number;
		protected var _unscaleHeight:Number;
		protected var _contentCenter:Boolean;
		public function Image(parent:DisplayObjectContainer=null, x:Number=0, y:Number=0,url:String="")
		{
			super(parent, x, y);
			if(url!="")
				this.url=url;
		}
		
		override protected function preInit():void
		{
			_loader=new Loader();
			_urlRequest=new URLRequest();
		}
		
		
		public function get url():String
		{
			return _url;
		}

		/**
		 *设置url为数据源 
		 * @param value
		 * 
		 */
		public function set url(value:String):void
		{
			if(value!=_url)
			{
				_url = value;
				load();
			}
		}
		/**
		 *设置类为数据源 
		 * @param value
		 * 
		 */
		public function set source(value:Class):void
		{
			if(_content)
				removeChild(_content);
			_content=new value();
			addChild(_content);
			resizeContent();
		}
		/**
		 *设置bitmapdata为数据源 
		 * @param value
		 * 
		 */
		public function set bitmapData(value:BitmapData):void
		{
			if(_content)
				removeChild(_content);
			_content=new Bitmap(value);
			addChild(_content);
			resizeContent();
		}
		
		private function load():void
		{
			if(_loader)
				_loader.unload();
			if(_content&&this.contains(_content))
				removeChild(_content);
			_urlRequest.url=_url;
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoaded);
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,onLoadedProgress);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onLoadedError);
			
			_loader.load(_urlRequest);
		}
		
		protected function onLoadedError(event:IOErrorEvent):void
		{
			trace("error");
		}
		
		protected function onLoadedProgress(event:ProgressEvent):void
		{
			dispatchEvent(event);
		}
		
		protected function onLoaded(event:Event):void
		{
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,onLoaded);
			_loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,onLoadedProgress);
			_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,onLoadedError);
			
			_content=_loader.content;
			addChild(_content);
			
			resizeContent();
			
		}
		protected function resizeContent():void
		{
			_unscaleWidth=_content.width;
			_unscaleHeight=_content.height;
			if(_scaleContent)
			{
				if(_aspectRatio)
				{
					var sw:Number=_width/_content.width;
					var sh:Number=_height/_content.height;
					var scale:Number=Math.min(sw,sh);
					_content.scaleX=_content.scaleY=scale;
					_content.x=_contentCenter?(_content.width*scale-_width>>1):0;
					_content.y=_contentCenter?(_content.height*scale-_height>>1):0;
				}else
				{
					_content.width=_width;
					_content.height=_height;
				}
			}
			
		}
		public function set aspectRatio(value:Boolean):void
		{
			_aspectRatio=value;
		}

		/**
		 *是否保持原来的长宽比例 
		 * @return 
		 * 
		 */
		public function get aspectRatio():Boolean
		{
			return _aspectRatio;
		}
		/**
		 *是否缩放内容 
		 * @return 
		 * 
		 */
		public function get scaleContent():Boolean
		{
			return _scaleContent;
		}
		public function set scaleContent(value:Boolean):void
		{
			_scaleContent=value;
		}
		/**
		 *未缩放的宽度 
		 * @return 
		 * 
		 */
		public function get unscaleWidth():Number
		{
			return _unscaleWidth;
		}
		/**
		 *未缩放的高度 
		 * @return 
		 * 
		 */
		public function get unscaleHeight():Number
		{
			return _unscaleHeight;
		}

		/**
		 *是否居中对齐 
		 * @return 
		 * 
		 */
		public function get contentCenter():Boolean
		{
			return _contentCenter;
		}

		public function set contentCenter(value:Boolean):void
		{
			_contentCenter = value;
		}


		
	}
}