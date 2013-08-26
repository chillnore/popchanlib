package com.popchan.display.component
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;
	
	/**
	 *复选框
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	public class CheckBox extends Button
	{
		protected var _selected:Boolean;
		public function CheckBox(label:String="checkBox", parent:DisplayObjectContainer=null, x:Number=0, y:Number=0,skinName:String="Skin_checkbox")
		{
			super(label, parent, x, y,skinName);
		}
		override protected function config():void
		{
			super.config();
			_width=100;
			_height=23;
			_skinMap={up:0,over:1,down:2,selectedUp:3,selectedOver:4,selectedDown:5};
			_skinColCount=6;
			addEventListener(MouseEvent.CLICK, toggleHandler);
		}
		protected function toggleHandler(event:MouseEvent):void
		{
			selected=!selected;
			dispatchEvent(new Event(Event.CHANGE));
		}
		public function get selected():Boolean
		{
			return _selected;
		}
		
		public function set selected(value:Boolean):void
		{
			if(value!=_selected)
			{
				_selected = value;
				invalidate(CallLaterEnum.SKIN);
			}
		}
		
		override protected function drawText():void
		{
			_tf.defaultTextFormat=_textformat;
			_tf.text=_label;
			_tf.autoSize=TextFieldAutoSize.LEFT;
			if(_tf.width>_width-_back.width-2)
			{
				_tf.autoSize=TextFieldAutoSize.NONE;
				_tf.width=_width-_back.width-2;
			}
			_tf.x=_back.width+2;
		}
		
		override protected function drawBg():void
		{
			var styleName:String=_enabled?_mouseState:"disabled";
			if(_selected)
				styleName="selected"+styleName.charAt(0).toUpperCase()+styleName.substr(1);
			if(_skinMap.hasOwnProperty(styleName))
				_back.bitmapData=_tiles[_skinMap[styleName]];
		}
		override protected function changeBgSzie():void
		{
			_tf.x=_back.width+2;
		}
		
	}
}