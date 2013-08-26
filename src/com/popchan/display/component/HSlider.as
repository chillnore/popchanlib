package com.popchan.display.component
{
	import com.popchan.manager.ResourceManager;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 *水平滑动条
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	public class HSlider extends SliderBase
	{
		public function HSlider(parent:DisplayObjectContainer=null, x:Number=0, y:Number=0,skin:String="Skin_slider")
		{
			super(parent, x, y);
			this.skin=skin;
		}
		
		override protected function config():void
		{
			setSize(200,10);
			super.config();
		}
		override protected function draw():void
		{
			if(isCallLater(CallLaterEnum.SKIN))
			{
				//高度不变，宽度改变即可
				_track.bitmapData=ResourceManager.getBitmapData(_skin);
				var h:int=getSkinSize(_skin).y;
				_track.setSize(_width,h);
				_track.validateNow();
				//滑块的宽高不变
				_thumb.skin=_skin+"_thumb";
				var _thumbSize:Point=getSkinSize(_skin+"_thumb");
				_thumb.setSize(_thumbSize.x/_thumb.skinColCount,_thumbSize.y/_thumb.skinRowCount);
				setThumbPosition();	
			}
			if(isCallLater(CallLaterEnum.SIZE))
			{
				drawSliderSize();	
			}
			clearCallLater();
		}
		override protected function drawSliderSize():void
		{
			_track.width=_width;
		}
		
		override protected function onTrackPress(event:MouseEvent):void
		{
			_thumb.x=mouseX-_thumb.width/2;
			if(_thumb.x<0)
				_thumb.x=0;
			else if(_thumb.x>_width-_thumb.width)
				_thumb.x=_width-_thumb.width;
			_value=_thumb.x*(_maximum-_minimum)/(_width-_thumb.width)+_minimum;
			dispatchEvent(new Event(Event.CHANGE));
			
		}
		override protected function onThumbDown(event:MouseEvent):void
		{
			_thumb.startDrag(false,new Rectangle(0,_track.height-_thumb.height>>1,_width-_thumb.width+1,0));
			stage.addEventListener(MouseEvent.MOUSE_UP,onThumbUp);
			stage.addEventListener(MouseEvent.MOUSE_MOVE,onThumbMove);	
		}
		override protected function onThumbMove(event:MouseEvent):void
		{
			var oldValue:Number=_value;
			_value=_thumb.x*(_maximum-_minimum)/(_width-_thumb.width)+_minimum;
			if(_value!=oldValue)
				dispatchEvent(new Event(Event.CHANGE));
		}
		
		override protected function onThumbUp(event:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP,onThumbUp);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE,onThumbMove);
			_thumb.stopDrag();
		}
		/**
		 *设置滑块的位置 
		 * 
		 */
		override protected function setThumbPosition():void
		{
			_thumb.x=(_value-_minimum)*(_width-_thumb.width)/(_maximum-_minimum);
			if(_thumb.x<0)
				_thumb.x=0;
			else if(_thumb.x>_width-_thumb.width)
				_thumb.x=_width-_thumb.width;
			_thumb.y=_track.height-_thumb.height>>1;
		}
		
		
	}
}