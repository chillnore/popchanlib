package com.popchan.time
{
	import flash.display.Shape;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.getTimer;
	
	/**
	 *代替Timer，比较精确的计时器
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012,chenbo,All rights reserved
	 */
	public class BasicTimer extends EventDispatcher
	{
		protected var _delay:int;
		protected var _repeateCount:int;
		protected var _offset:int;
		protected var _currentTime:int;
		protected var _isRunnging:Boolean;
		protected var _currentCount:int;
		protected var _shape:Shape;
		public function BasicTimer(delay:int=1000,reapeatCount:int=0)
		{
			this._delay=delay;
			this._repeateCount=reapeatCount;
			_shape=new Shape();
		}
		/**
		 *启动 
		 * 
		 */
		public function start():void
		{
			if(!_isRunnging)
			{
				_isRunnging=true;
				_currentTime=getTimer();
				_shape.addEventListener(Event.ENTER_FRAME,update);
			}
		}
		/**
		 *停止 
		 * 
		 */
		public function stop():void
		{
			if(_isRunnging)
			{
				_isRunnging=false;
				_shape.removeEventListener(Event.ENTER_FRAME,update);
			}
		}
		/**
		 *重置 
		 * 
		 */
		public function reset():void
		{
			stop();
			_offset=_currentCount=0;
		}
		protected function update(event:Event):void
		{
			var dis:int=getTimer()-_currentTime;
			_offset+=dis;
			_currentTime=getTimer();
			if(_offset>_delay)
			{
				while(_offset>_delay)
				{
					_offset-=_delay;
					_currentCount++;
					if(_repeateCount!=0)
					{
						if(_currentCount==_repeateCount)
						{
							dispatchEvent(new TimerEvent(TimerEvent.TIMER));
							dispatchEvent(new TimerEvent(TimerEvent.TIMER_COMPLETE));
							stop();
						}else
						{
							dispatchEvent(new TimerEvent(TimerEvent.TIMER));
						}
					}else
					{
						dispatchEvent(new TimerEvent(TimerEvent.TIMER));
					}
				}
			}
		}
		/**
		 *延迟 
		 * @return 
		 * 
		 */
		public function get delay():int
		{
			return _delay;
		}
		
		public function set delay(value:int):void
		{
			_delay = value;
		}
		
		/**
		 *执行次数 0=无限 
		 * @return 
		 * 
		 */
		public function get repeateCount():int
		{
			return _repeateCount;
		}
		
		public function set repeateCount(value:int):void
		{
			_repeateCount = value;
		}
		
		/**
		 *是否在运行 
		 * @return 
		 * 
		 */
		public function get isRunnging():Boolean
		{
			return _isRunnging;
		}
		
		/**
		 *当前次数 
		 * @return 
		 * 
		 */
		public function get currentCount():int
		{
			return _currentCount;
		}
	
		
		
		
		
	}
}