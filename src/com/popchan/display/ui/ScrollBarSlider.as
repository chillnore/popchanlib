package com.popchan.display.ui
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	
	/**
	 *用于滚动条的slider (增加了调整thumb的百分比,设置_pageScrollSize)
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	public class ScrollBarSlider extends Slider
	{
		protected var _pageScrollSize:int=1;
		protected var _thumbPercent:Number=1.0;
		protected var _timer:Timer;
		protected var _repeatDelay:Number=500;
		protected var _repeatInterval:Number=100;
		protected var _autoRepeat:Boolean;
		public function ScrollBarSlider(parent:DisplayObjectContainer=null, x:Number=0, y:Number=0, direction:String=SliderDirection.HORIZONTAL)
		{
			super(parent, x, y, direction);
		}
		
		override protected function createChildren():void
		{
			_timer=new Timer(_repeatDelay);
			_timer.addEventListener(TimerEvent.TIMER,onRepeat);
		}
		override protected function drawTrack():void
		{
			if(_track)
			{
				_track.removeEventListener(MouseEvent.MOUSE_DOWN,onTrackPress);
				_track.removeEventListener(MouseEvent.MOUSE_UP,onTrackUp);
				_track.removeEventListener(MouseEvent.ROLL_OVER,onTrackUp);
				_track.removeEventListener(MouseEvent.ROLL_OUT,onTrackUp);
				removeChild(_track);
			}
			_track=getSkinInstance(getStyleValue("trackSkin")) as Sprite;
			_track.addEventListener(MouseEvent.MOUSE_DOWN,onTrackPress);
			_track.addEventListener(MouseEvent.MOUSE_UP,onTrackUp);
			_track.addEventListener(MouseEvent.ROLL_OVER,onTrackUp);
			_track.addEventListener(MouseEvent.ROLL_OUT,onTrackUp);
			addChildAt(_track,0);
			_track.width=_width;
			_track.height=_height;
		}
		
		protected function onRepeat(event:TimerEvent):void
		{
			if(!_autoRepeat)
				_timer.stop();
			if(_timer.currentCount==1)
				_timer.delay=_repeatInterval;
			handleTrackPress();
			dispatchEvent(new Event(Event.CHANGE));
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
			
			
			invalidate(CallLaterType.SIZE);
		}
		protected function onTrackUp(event:MouseEvent):void
		{
			_timer.reset();
		}
		override protected function onTrackPress(event:MouseEvent):void
		{
			if(_autoRepeat)
			{
				_timer.delay=_repeatDelay;
				_timer.start();
			}
			handleTrackPress();
			
		}
		protected function handleTrackPress():void
		{
			if(_direction==SliderDirection.HORIZONTAL)
			{
				if(mouseX>_thumb.x)
					value+=_pageScrollSize;
				else
					value-=_pageScrollSize;
			}else
			{
				if(mouseY>_thumb.y)
					value+=_pageScrollSize;
				else
					value-=_pageScrollSize;
			}
			dispatchEvent(new Event(Event.CHANGE));
		}
		
	
		
		override protected function drawSliderSize():void
		{
			super.drawSliderSize();
	
			if(_direction==SliderDirection.HORIZONTAL)
			{
				_thumb.height=_width*_thumbPercent;
				_thumb.width=_height;
				
			}else
			{
				_thumb.width=_width;
				_thumb.height=_height*_thumbPercent;
			}
			if(_thumb.height<10)_thumb.height=10;//最小高度为10
		}
		
		
		public function get autoRepeat():Boolean
		{
			return _autoRepeat;
		}
		
		public function set autoRepeat(value:Boolean):void
		{
			_autoRepeat = value;
		}
		
		
	}
}