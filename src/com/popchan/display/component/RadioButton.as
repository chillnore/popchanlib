package com.popchan.display.component
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;
	
	import flashx.textLayout.elements.OverflowPolicy;
	
	/**
	 *单选按钮
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	[Event(name="change", type="flash.events.Event")]
	public class RadioButton extends Button
	{
		protected var _selected:Boolean;
		public function RadioButton(label:String="",parent:DisplayObjectContainer=null, x:Number=0, y:Number=0,skin:String="Skin_radiobutton")
		{
			super(label,parent, x, y,skin);
			
		}
		override protected function config():void
		{
			super.config();
			setSize(14,14);
			_skinMap={up:0,over:0,down:0,selectedUp:1,selectedOver:1,selectedDown:1};
			_skinColCount=2;
			this.addEventListener(MouseEvent.CLICK,onClick);
		}
		protected function onClick(event:MouseEvent):void
		{
			if(!selected)
				selected=true;
		}
		
		public function get selected():Boolean
		{
			return _selected;
		}
		
		public function set selected(value:Boolean):void
		{
			
			_selected = value;
			if(value)
			{
				dispatchEvent(new Event(Event.CHANGE));
			}
			invalidate(CallLaterEnum.SKIN);
		}
	
		
		override protected function drawText():void
		{
			super.drawText();
			_tf.autoSize=TextFieldAutoSize.LEFT;
			_tf.x=_width+2;
			_tf.y=_height-_tf.height>>1;
		}
		override protected function drawBg():void
		{
			var styleName:String=_enabled?_mouseState:"disabled";
			if(_selected)
				styleName="selected"+styleName.charAt(0).toUpperCase()+styleName.substr(1);
			if(_skinMap.hasOwnProperty(styleName))
				_back.bitmapData=_tiles[_skinMap[styleName]];
		}
	

	}
}