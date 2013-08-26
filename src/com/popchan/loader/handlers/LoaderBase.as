package com.popchan.loader.handlers
{
	import com.popchan.debug.Debug;
	import com.popchan.loader.events.PopLoaderEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;

	/**
	 *抽象的loader 用于子类继承
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	public class LoaderBase extends EventDispatcher
	{
		public static const STATUS_INIT:String="status_init";
		public static const STATUS_LOADED:String="status_loaded";
		public static const STATUS_START:String="status_start";
		public static const STATUS_ERROR:String="status_error";
		public static const STATUS_ABORT:String="status_abort";
		protected var _status:String;
		
		protected var _urlRequest:URLRequest;
		protected var _path:String;
		protected var _size:int;
		protected var _filePath:String;
		protected var _bytesLoaded:int;
		protected var _bytesTotal:int;
		protected var _id:String;
		protected var _priority:int;
		/**类型*/
		protected var _type:String;
		protected var _content:*;
		/**被加入加载列表时候的索引*/
		public var index:int;
		/**重试次数*/
		public var retryCount:int;
		/**
		 * 
		 * @param url 路径
		 * @param id  id
		 * @param type 类型
		 * 
		 */
		public function LoaderBase(url:String,type:String=null)
		{
			this._path=url;
			this._type=type;
			_status=STATUS_INIT;
		}
		/**
		 *开始加载 
		 * 
		 */
		public function load():void
		{
			_urlRequest=new URLRequest(_path);
			_status=STATUS_START;
		}
		/**
		 *清理资源 
		 * 
		 */
		public function dispose():void
		{
			_urlRequest=null;
			_content=null;
			
		}
		/**
		 *取消下载 
		 * 
		 */
		public function close():void
		{
			
		}
		public function get bytesLoaded():int
		{
			return _bytesLoaded;
		}
		public function get bytesTotal():int
		{
			return _bytesTotal;
		}
		public function get content():*
		{
			return _content;
		}
		protected function addListerner(target:IEventDispatcher):void
		{
			target.addEventListener(Event.COMPLETE,onLoaded);
			target.addEventListener(ProgressEvent.PROGRESS,onLoadProgress);
			target.addEventListener(IOErrorEvent.IO_ERROR,onLoadError);
			target.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurityError);
		}
		
		
		protected function removeListener(target:IEventDispatcher):void
		{
			target.removeEventListener(Event.COMPLETE,onLoaded);
			target.removeEventListener(ProgressEvent.PROGRESS,onLoadProgress);
			target.removeEventListener(IOErrorEvent.IO_ERROR,onLoadError);
		}
		
		protected function onLoaded(e:Event):void
		{
			loadedHandler();
			_status=STATUS_LOADED;
			removeListener(e.target as EventDispatcher);
			dispatchEvent(e);
		}
		/**
		 *加载完成处理 
		 * 
		 */
		protected function loadedHandler():void
		{
			
		}
		protected function onLoadProgress(e:ProgressEvent):void
		{
			dispatchEvent(e);
		}

		protected function onLoadError(e:IOErrorEvent):void
		{
			_status=STATUS_ERROR;
			Debug.error("路径错误:"+_path);
			removeListener(e.target as EventDispatcher);
			dispatchEvent(e);	
		}
		protected function onSecurityError(e:SecurityErrorEvent):void
		{
			_status=STATUS_ERROR;
			removeListener(e.target as EventDispatcher);
			dispatchEvent(e);	
		}
		/**
		 *设置属性 
		 * @param value
		 * 
		 */
		public function set props(value:Object):void
		{
			_id=value["id"];
			_priority=value["_priority"]||0;
		}

		public function get size():int
		{
			return _size;
		}

		public function get id():String
		{
			return _id;
		}

		public function get path():String
		{
			return _path;
		}

		/**
		 *加载状态 
		 * @return 
		 * 
		 */
		public function get status():String
		{
			return _status;
		}

		/**优先级*/
		public function get priority():int
		{
			return _priority;
		}


	}
}