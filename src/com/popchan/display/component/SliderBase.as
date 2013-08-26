package com.popchan.display.component
{
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	
	/**
	 *滑动条基类
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	public class SliderBase extends Component
	{
		protected var _maximum:Number=10;
		protected var _minimum:Number=0;
		protected var _value:Number=0;
		
		protected var _track:Image;
		protected var _thumb:ButtonBase;
		protected var _snapInterval:Number=1;
		
		/*轨道9宫格*/
		protected var _trackScale9:String="2,2,4,4";
		/*滑块9宫格*/
		protected var _thumbScale9:String="2,2,4,4";
		public function SliderBase(parent:DisplayObjectContainer=null, x:Number=0, y:Number=0)
		{
			super(parent, x, y);
		}
		
		override protected function config():void
		{
			//draw track
			_track=new Image(this);
			_track.scale9=_trackScale9;
			_track.aspectRatio=false;
			_track.addEventListener(MouseEvent.MOUSE_DOWN,onTrackPress);
			//draw thumb
			_thumb=new ButtonBase(this,0,0,null);
			_thumb.scale9=_thumbScale9;
			_thumb.addEventListener(MouseEvent.MOUSE_DOWN,onThumbDown);
		}
		protected function onTrackPress(event:MouseEvent):void
		{
			
			
		}
		
		protected function onThumbDown(event:MouseEvent):void
		{
			
		}
		protected function onThumbMove(event:MouseEvent):void
		{
		
		}
		protected function onThumbUp(event:MouseEvent):void
		{
		
		}
		override protected function draw():void
		{
			if(isCallLater(CallLaterEnum.SIZE))
			{
				drawSliderSize();	
			}
			clearCallLater();
		}
		
		protected function drawSliderSize():void
		{
			
		}
		/**
		 *设置滑块的位置 
		 * 
		 */
		protected function setThumbPosition():void
		{
			
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
		/**
		 *滑块当前的值 
		 * @return 
		 * 
		 */
		public function get value():Number
		{
			return Math.round(_value/_snapInterval)*_snapInterval;
		}
		
		public function set value(val:Number):void
		{
			if(val<_minimum)
				val=_minimum;
			else if(val>_maximum)
				val=_maximum;
			_value = val;
			setThumbPosition();
			
		}
		/**
		 *指定当用户移动滑块时滑块的增值
		 * @return 
		 * 
		 */
		public function get snapInterval():Number
		{
			return _snapInterval;
		}
		
		public function set snapInterval(value:Number):void
		{
			_snapInterval = value;
		}

		public function get trackScale9():String
		{
			return _trackScale9;
		}

		public function set trackScale9(value:String):void
		{
			_trackScale9 = value;
			_track.scale9=value;
			
		}

		public function get thumbScale9():String
		{
			return _thumbScale9;
		}

		public function set thumbScale9(value:String):void
		{
			_thumbScale9 = value;
			_thumb.scale9=value;
		}
		
		
	}
}