package com.popchan.net.socket
{
	import flash.events.Event;
	
	/**
	 *
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	public class SocketEvent extends Event
	{
		public static const CONNECT:String=Event.CONNECT;
		public static const CLOSE:String=Event.CLOSE;
		
		public static const IO_ERROR:String = "ioError";
		public static const SECURITY_ERROR:String = "securityError";
		public function SocketEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}