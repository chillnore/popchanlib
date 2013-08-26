package com.popchan.display.component
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 *用于垂直滚动条的Slider
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	public class ScrollBarSlider extends VSlider
	{
		protected var _pageScrollSize:int=1;
		protected var _thumbPercent:Number=.5;
		protected var _timer:Timer;
		protected var _repeatDelay:Number=500;
		protected var _repeatInterval:Number=100;
		public function ScrollBarSlider(parent:DisplayObjectContainer=null, x:Number=0, y:Number=0, skin:String="Skin_slider")
		{
			super(parent, x, y, skin);
		}
		
		override protected function config():void
		{
			super.config();
			_timer=new Timer(_repeatDelay);
			_timer.addEventListener(TimerEvent.TIMER,onRepeat);
			
			_track.addEventListener(MouseEvent.MOUSE_UP,onTrackUp);
			_track.addEventListener(MouseEvent.ROLL_OVER,onTrackUp);
			_track.addEventListener(MouseEvent.ROLL_OUT,onTrackUp);
		}
		protected function onRepeat(event:TimerEvent):void
		{
			if(_timer.currentCount==1)
				_timer.delay=_repeatInterval;
			handleTrackPress();
			dispatchEvent(new Event(Event.CHANGE));
		}
		protected function handleTrackPress():void
		{
			if(mouseY>_thumb.y)
				value+=_pageScrollSize;
			else
				value-=_pageScrollSize;
			dispatchEvent(new Event(Event.CHANGE));
		}
		protected function onTrackUp(event:MouseEvent):void
		{
			_timer.reset();
		}
		override protected function onTrackPress(event:MouseEvent):void
		{
			_timer.delay=_repeatDelay;
			_timer.start();
			handleTrackPress();
			
		}
		override protected function drawSliderSize():void
		{
			super.drawSliderSize();
			_thumb.height=_height*_thumbPercent;
			if(_thumb.height<10)_thumb.height=10;//最小高度为10
		}
		/**
		 *按下滚动条轨道时滚动滑块的移动量（以像素为单位） 
		 * @return 
		 * 
		 */
		public function get pageScrollSize():int
		{
			return _pageScrollSize;
		}
		
		public function set pageScrollSize(value:int):void
		{
			_pageScrollSize = value;
		}
		/**
		 *滚动条百分比 
		 * @return 
		 * 
		 */
		public function get thumbPercent():Number
		{
			return _thumbPercent;
		}
		
		public function set thumbPercent(value:Number):void
		{
			_thumbPercent =Math.min(1.0,value);
			_thumb.visible=_thumbPercent<1;
			
			
			invalidate(CallLaterEnum.SIZE);
		}
		
	}
}