package com.popchan.time
{
	import flash.events.Event;
	import flash.events.TimerEvent;

	/**
	 *代替setInterval和setTimeOut
	  *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012,chenbo,All rights reserved
	 */
	public class Interval extends BasicTimer
	{
		protected var _args:Array;
		protected var _callBack:Function;
		public function Interval(delay:int,reapeatCount:int,callBack:Function,args:Array=null)
		{
			super(delay, reapeatCount);
			_args=args;
			_callBack=callBack;
			addEventListener(TimerEvent.TIMER,onTimer,false,0,true);
			
		}
		/**
		 *定时触发 
		 * @param closure
		 * @param delay
		 * @param parameters
		 * @return 
		 * 
		 */
		public static function setInterval(closure:Function,delay:int,...parameters):Interval
		{
			return new Interval(delay,0,closure,parameters);
		}
		/**
		 *触发一次关闭 
		 * @param closure
		 * @param delay
		 * @param parameters
		 * @return 
		 * 
		 */
		public static function setTimeOut(closure:Function,delay:int,...parameters):Interval
		{
			return new Interval(delay,1,closure,parameters);
		}
		protected function onTimer(event:Event):void
		{
			_callBack.apply(null,_args);
			
		}

		public function get callBack():Function
		{
			return _callBack;
		}

		public function set callBack(value:Function):void
		{
			_callBack = value;
		}
		public function dispose():void
		{
			reset();
			removeEventListener(TimerEvent.TIMER,onTimer);
		}

	}
}