package com.popchan.loader.core
{
	import com.popchan.debug.Debug;
	import com.popchan.loader.events.PopLoaderEvent;
	import com.popchan.loader.handlers.ImageLoader;
	import com.popchan.loader.handlers.LoaderBase;
	import com.popchan.loader.handlers.SWFLoader;
	import com.popchan.loader.handlers.TextLoader;
	import com.popchan.loader.handlers.XMLLoader;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.utils.Dictionary;
	
	/**
	 *文件加载器 v1.0
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	public class PopLoader extends EventDispatcher
	{
		protected var _files:Array;
		protected var _maxConnection:int;
		protected var _isLoading:Boolean;
		protected var _index:int;
		protected var _retryMax:int;
		/**当前使用的链接*/
		protected var _connections:Object;
		/**不同类型的文件所对应的加载器*/
		protected var _loaderClassObj:Object={image:ImageLoader,swf:SWFLoader,text:TextLoader,xml:XMLLoader};
		/**
		 * 
		 * @param maxConnnection最大连接数
		 * @param retryMax 重试次数
		 * 
		 */
		public function PopLoader(maxConnnection:int=5,retryMax:int=2)
		{
			this._maxConnection=maxConnnection;
			this._retryMax=retryMax;
			_files=[];
			_connections={};
		}
		
		/**
		 *添加下载 列表
		 * @param url
		 * @param props
		 * 
		 */
		public function addFile(url:String,props:Object=null):LoaderBase
		{
			var type:String;
			props=props||{};
			if(props["type"]!=null)
			{
				type=props["type"];
			}else
			{
				type=getTypeByUrl(url);
			}
			var loadItem:LoaderBase=getLoader(props["id"]);
			if(loadItem)
				return loadItem;
			
			_index++;
			loadItem=new _loaderClassObj[type](url,type);
			loadItem.index=_index;
			loadItem.props=props;
			
			addListener(loadItem);
			_files.push(loadItem);
			sortLoadItem();
			
			return loadItem;
		}
		
		/**
		 *按照优先级排序或者index排列 
		 * 
		 */
		private function sortLoadItem():void
		{
			_files.sortOn(["index","priority"],Array.NUMERIC);
		}
		/**
		 *启动下载 
		 * 
		 */
		public function load():void
		{
			if (_isLoading) return;
			_isLoading = true;
			loadNext();
		}
		private function next():void
		{
			loadNext();
			if(isAllLoaded())
			{
				handleAllLoaded();
			}
		}
		private function loadNext():void
		{
			var loadItem:LoaderBase=getNextLoader();
			if(loadItem!=null)
			{
				_connections[loadItem.path]=true;
				loadItem.load();
				if(getNextLoader()!=null)
					loadNext();
			}
		}
		/**
		 *获取下一个加载项 
		 * @return 
		 * 
		 */
		private function getNextLoader():LoaderBase
		{
			for each(var loader:LoaderBase in _files)
			{
				if(loader.status!=LoaderBase.STATUS_START&&loader.status!=LoaderBase.STATUS_ABORT&&loader.status!=LoaderBase.STATUS_LOADED&&getCurrentConnectCount()<_maxConnection)
				{
					if(loader.status!=LoaderBase.STATUS_ERROR)
						return loader;
					else
					{
						if(loader.retryCount<_retryMax)
						{
							loader.retryCount++;
							Debug.error("retry"+loader.retryCount)
							return loader;
						}
					}
				}
			}
			return null;
		}
		/**
		 *通过url来确定加载文件的类型,默认为文本类型 
		 * @param url
		 * @return 
		 * 
		 */
		private function getTypeByUrl(url:String):String
		{
			var extensionIndex:int=url.lastIndexOf(".");
			if(extensionIndex!=-1)
			{
				var extension:String=url.substring(extensionIndex+1,url.length);
				extension=extension.toLowerCase();
				if(LoaderType.IMAGE_EXTENSIONS.indexOf(extension)!=-1)
					return LoaderType.IMAGE;
				else if(LoaderType.SWF_EXTENSIONS.indexOf(extension)!=-1)
					return LoaderType.SWF;
				else if(LoaderType.TEXT_EXTENSIONS.indexOf(extension)!=-1)
					return LoaderType.TEXT;
				else if(LoaderType.XML_EXTENSIONS.indexOf(extension)!=-1)
					return LoaderType.XML;
			}
			return LoaderType.TEXT;
		}
		
		/**
		 *添加事件 
		 * @param loader
		 * 
		 */
		public function addListener(loaderBase:LoaderBase):void
		{
			loaderBase.addEventListener(Event.COMPLETE,onComplete);	
			loaderBase.addEventListener(ProgressEvent.PROGRESS,onProgress);	
			loaderBase.addEventListener(IOErrorEvent.IO_ERROR,onError);	
		}
		/**
		 *移出事件 
		 * @param loader
		 * 
		 */
		public function removeListener(loaderBase:LoaderBase):void
		{
			loaderBase.removeEventListener(Event.COMPLETE,onComplete);	
			loaderBase.removeEventListener(ProgressEvent.PROGRESS,onProgress);	
			loaderBase.removeEventListener(IOErrorEvent.IO_ERROR,onError);	
		}
		/**
		 *获取当前使用的链接个数 
		 * @return 
		 * 
		 */
		private function getCurrentConnectCount():int
		{
			var i:int;
			for each(var obj:Object in _connections)
			{
				i++;
			}
			return i;
		}
		private function handleAllLoaded():void
		{
			_isLoading=false;
			dispatchEvent(new PopLoaderEvent(Event.COMPLETE));
		}
		/**
		 *是否所有的都下载完成 
		 * @return 
		 * 
		 */
		private function isAllLoaded():Boolean
		{
			for each(var loader:LoaderBase in _files)
			{
				if(loader.status==LoaderBase.STATUS_START||loader.status==LoaderBase.STATUS_INIT)
					return false;
			}
			return true;
		}
		/**
		 *获取文本 
		 * @param key
		 * @param dispose
		 * @return 
		 * 
		 */
		public function getText(key:String,dispose:Boolean=false):String
		{
			return getContentAsType(key,String,dispose);
		}
		/**
		 *获取XML
		 * @param key
		 * @param dispose
		 * @return 
		 * 
		 */
		public function getXML(key:String,dispose:Boolean=false):XML
		{
			return getContentAsType(key,XML,dispose);
		}
		/**
		 * 获取Bitmap
		 * @param key
		 * @param dispose 释放内存
		 * @return 
		 * 
		 */
		public function getBitmap(key:String,dispose:Boolean=false):Bitmap
		{
			return getContentAsType(key,Bitmap,dispose);
		}
	
		/**
		 *获取BitmapData 
		 * @param key
		 * @param dispose
		 * @return 
		 * 
		 */
		public function getBitmapData(key:String,dispose:Boolean=false):BitmapData
		{
			try
			{
				return getBitmap(key,dispose).bitmapData;
			}catch(e:Error)
			{
				Debug.error("获取"+key+"的BitmapData出错");
			}
			return null;
		}
		/**
		 *获取mc 
		 * @param key
		 * @param dispose
		 * @return 
		 * 
		 */
		public function getMovieClip(key:String,dispose:Boolean):MovieClip
		{
			return getContentAsType(key,MovieClip,dispose);
		}
		/**
		 *获取sprite 
		 * @param key
		 * @param dispose
		 * @return 
		 * 
		 */
		public function getSprite(key:String,dispose:Boolean):Sprite
		{
			return getContentAsType(key,Sprite,dispose);
		}
		private function getContentAsType(key:String,type:Class,dispose:Boolean=false):*
		{
			var loadItem:LoaderBase=getLoader(key);
			if(loadItem==null)return null;
			try
			{
				if(loadItem.status==LoaderBase.STATUS_LOADED)
				{
					var content:*= loadItem.content as type;
					if(content==null)
					{
						throw new  Error("获取"+key+",类型为type"+type+"内容出错")
					}
					if(dispose)
						removeLoader(key);
					return content;
				}
			}catch(e:Error)
			{
				Debug.error("获取"+key+"内容出错");
			}
		}
		/**
		 *获取LoaderBase 
		 * @param key
		 * @return 
		 * 
		 */
		public function getLoader(key:String):LoaderBase
		{
			if(key==null)return null;
			for each(var item:LoaderBase in _files)
			{
				if(item.id==key||item.path==key)
					return item;
			}
			return null;
		}
		/**
		 *移出LoaderBase 
		 * @param key
		 * @return 
		 * 
		 */
		private function removeLoader(key:String):void
		{
			for each(var item:LoaderBase in _files)
			{
				if(item.id==key||item.path==key)
				{
					item.dispose();
					_files.splice(_files.indexOf(item),1);
					removeConnect(item);
					item=null;
					break;
				}
			}
		}
		/**
		 *移出链接 
		 * @param loader
		 * 
		 */
		private function removeConnect(loader:LoaderBase):void
		{
			for(var str:String in _connections)
			{
				if(str==loader.path)
				{
					_connections[str]=false;
					delete _connections[str];
					break;
				}
			}
		}
		private function onProgress(e:ProgressEvent):void
		{
			var fileTotal:int=0;
			var fileLoaded:int=0;
			for each(var loader:LoaderBase in _files)
			{
				fileTotal++;
				if(loader.status==LoaderBase.STATUS_LOADED)
					fileLoaded++;
			}
			var evt:PopLoaderEvent=new PopLoaderEvent(PopLoaderEvent.PROGRESS);
			evt.setProgressInfo(fileLoaded,fileTotal);
			dispatchEvent(evt);
		}
		private function onComplete(e:Event):void
		{
			var loader:LoaderBase=e.target as LoaderBase;
			removeConnect(loader);
			
			var evt:PopLoaderEvent=new PopLoaderEvent(PopLoaderEvent.SINGLE_FILE_LOADED);
			dispatchEvent(evt);
			
			next();
		}
		private function onError(e:IOErrorEvent):void
		{
			var loader:LoaderBase=e.target as LoaderBase;
			removeConnect(loader);
			next();
		}
		public function dispose():void
		{
			
		}
		
		public function get isLoading():Boolean
		{
			return _isLoading;
		}

		/**
		 *重试次数 
		 */
		public function get retryMax():int
		{
			return _retryMax;
		}

		/**
		 * @private
		 */
		public function set retryMax(value:int):void
		{
			if(value<0)value=0;
			value=Math.min(int.MAX_VALUE,value);
			_retryMax = value;
		}

		/**
		 *并发下载个数 
		 * @return 
		 * 
		 */
		public function get maxConnection():int
		{
			return _maxConnection;
		}

		public function set maxConnection(value:int):void
		{
			if(value<0)value=0;
			value=Math.min(int.MAX_VALUE,value);
			_maxConnection = value;
		}


	}
}