package com.popchan.display.component
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 *开关按钮 可以切换为选中状态
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	[Event(name="change", type="flash.events.Event")]
	public class ToggleButton extends Button
	{
		protected var _selected:Boolean;
		protected var _toggle:Boolean;

		public function ToggleButton(label:String=null,parent:DisplayObjectContainer=null, x:Number=0, y:Number=0,skinName:String="Skin_toggle")
		{
			super(label,parent,x,y,skinName);
		}
		override protected function config():void
		{
			super.config();
			_width=52;
			_height=27;
			_skinMap={up:0,over:1,down:2,selectedUp:3,selectedOver:3,selectedDown:3};
			_skinColCount=4;
			toggle=true;
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
				invalidate(CallLaterEnum.SIZE);
			}
		}
		
		/**
		 *控制 Button 是否处于切换状态。 
		 * @return 
		 * 
		 */
		public function get toggle():Boolean
		{
			return _toggle;
		}
		
		public function set toggle(value:Boolean):void
		{
			if(!value&&_selected)
				selected=false;
			if(value!=_toggle)
			{
				_toggle=value;
				if (_toggle)
					addEventListener(MouseEvent.CLICK, toggleHandler);
				else
					removeEventListener(MouseEvent.CLICK, toggleHandler);
				invalidate(CallLaterEnum.SKIN);
			}
		}
		
		protected function toggleHandler(event:MouseEvent):void
		{
			dispatchEvent(new Event(Event.CHANGE));
			selected=!selected;
		}
		
		override protected function drawBg():void
		{
			var bg:DisplayObject=_back;
			var styleName:String=_enabled?_mouseState:"disabled";
			if(_selected)
				styleName="selected"+styleName.charAt(0).toUpperCase()+styleName.substr(1);
			_back.bitmapData=_tiles[_skinMap[styleName]];
		}
		
		
	}
}