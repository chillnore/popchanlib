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
	public class VSlider extends SliderBase
	{
		public function VSlider(parent:DisplayObjectContainer=null, x:Number=0, y:Number=0,skin:String="Skin_slider")
		{
			super(parent, x, y);
			this.skin=skin;
		}
		
		override protected function config():void
		{
			setSize(10,200);
			super.config();
		}
		override protected function draw():void
		{
			if(isCallLater(CallLaterEnum.SKIN))
			{
				//宽度不变，高度改变即可
				_track.bitmapData=ResourceManager.getBitmapData(_skin);
				var w:int=getSkinSize(_skin).x;
				_track.setSize(w,_height);
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
				setThumbPosition();
			}
			clearCallLater();
		}
		override protected function drawSliderSize():void
		{
			_track.height=_height;
		}
		
		override protected function onTrackPress(event:MouseEvent):void
		{
			_thumb.y=mouseY-_thumb.height/2;
			if(_thumb.y<0)
				_thumb.y=0;
			else if(_thumb.y>_height-_thumb.height)
				_thumb.y=_height-_thumb.height;
			_value=_thumb.y*(_maximum-_minimum)/(_height-_thumb.height)+_minimum;
			dispatchEvent(new Event(Event.CHANGE));
			
		}
		override protected function onThumbDown(event:MouseEvent):void
		{
			_thumb.startDrag(false,new Rectangle(_track.width-_thumb.width>>1,0,0,_height-_thumb.height+1));
			stage.addEventListener(MouseEvent.MOUSE_UP,onThumbUp);
			stage.addEventListener(MouseEvent.MOUSE_MOVE,onThumbMove);	
		}
		override protected function onThumbMove(event:MouseEvent):void
		{
			var oldValue:Number=_value;
			_value=_thumb.y*(_maximum-_minimum)/(_height-_thumb.height)+_minimum;
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
			_thumb.x=_track.width-_thumb.width>>1;
			_thumb.y=(_value-_minimum)*(_height-_thumb.height)/(_maximum-_minimum);
			if(_thumb.y<0)
				_thumb.y=0;
			else if(_thumb.y>_height-_thumb.height)
				_thumb.y=_height-_thumb.height;
		}
		
		
	}
}