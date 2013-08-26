package com.popchan.net.socket
{
	import com.popchan.debug.Debug;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.ObjectEncoding;
	import flash.net.Socket;
	import flash.system.Security;
	
	/**
	 *socket客户端核心代码
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	public class SocketClient extends EventDispatcher
	{
		protected var _socket:Socket;
		protected var _connected:Boolean;
		protected var _messageHandler:IMessageHandler;
		public function SocketClient(messageHandler:IMessageHandler)
		{
			this._messageHandler=messageHandler;
			
			_socket=new Socket();
			_socket.objectEncoding=ObjectEncoding.AMF3;
			addListener();
		}
		public function connect(ip:String, port:int) : void
		{
			try
			{
				Security.loadPolicyFile("xmlsocket://" + ip + ":" + port);
				_socket.connect(ip, port);
			}
			catch(e:Error)
			{
				Debug.error(e.getStackTrace());
			}
		}
		public function send() : void
		{
			
		}
		public function disConnect():void
		{
			_socket.close();
			removeListener();
		}
		protected function removeListener():void
		{
			_socket.removeEventListener(Event.CLOSE,onClose);
			_socket.removeEventListener(Event.CONNECT,onConnect);
			_socket.removeEventListener(ProgressEvent.SOCKET_DATA,onSocketData);
			_socket.removeEventListener(IOErrorEvent.IO_ERROR,onError);
			_socket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurityError);
		}
		protected function addListener():void
		{
			_socket.addEventListener(Event.CLOSE,onClose);
			_socket.addEventListener(Event.CONNECT,onConnect);
			_socket.addEventListener(ProgressEvent.SOCKET_DATA,onSocketData);
			_socket.addEventListener(IOErrorEvent.IO_ERROR,onError);
			_socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurityError);
		}
		
		protected function onClose(event:Event):void
		{
			_connected=false;
			_socket.removeEventListener(Event.CLOSE, onClose);
			dispatchEvent(new Event(SocketEvent.CLOSE));
		}
		
		protected function onConnect(event:Event):void
		{
			_connected=true;
			dispatchEvent(new Event(SocketEvent.CONNECT));
		}
		
		protected function onSocketData(event:ProgressEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		
		protected function onError(event:IOErrorEvent):void
		{
			_socket.removeEventListener(IOErrorEvent.IO_ERROR,onError);
			dispatchEvent(new Event(SocketEvent.CLOSE));
			Debug.info("io error");
		}
		
		protected function onSecurityError(event:SecurityErrorEvent):void
		{
			dispatchEvent(new Event(SocketEvent.SECURITY_ERROR));
			Debug.info("socket security error");
		}
		
	}
}