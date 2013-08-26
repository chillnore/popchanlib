package com.popchan.display.component
{
	import flash.display.DisplayObjectContainer;
	
	/**
	 *通用进度条
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	public class ProgressBar extends Component
	{
		protected var _maximum:Number=100;
		protected var _minimum:Number=0;
		protected var _value:Number=0;
		public function ProgressBar(parent:DisplayObjectContainer=null, x:Number=0, y:Number=0)
		{
			super(parent, x, y);
		}

		public function get maximum():Number
		{
			return _maximum;
		}

		public function set maximum(value:Number):void
		{
			_maximum = value;
		}

		public function get minimum():Number
		{
			return _minimum;
		}

		public function set minimum(value:Number):void
		{
			_minimum = value;
		}

		public function get value():Number
		{
			return _value;
		}

		public function set value(value:Number):void
		{
			_value = value;
		}


	}
}