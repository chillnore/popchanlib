package com.popchan.display.ui
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 *开关按钮
	 * 		btn.toggle 是否可以切换状态
	 * 		btn.selected 选中
	 * 		btn.setTextOn(value)设置选中时文本
	 * 		btn.setTextOff(value)设置未选中时文本
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	[Event(name="change", type="flash.events.Event")]
	public class ToggleButton extends Button
	{
		protected var _selected:Boolean;
		protected var _toggle:Boolean;
		protected var _textOn:String;
		protected var _textOff:String;
		/**
		 *默认皮肤 
		 */		
		private var _defaultSkin:Object=
			{
				upSkin:"ButtonUp",
				overSkin:"ButtonOver",
				downSkin:"ButtonDown",
				disabledSkin:"ButtonDisabled",
				selectedUpSkin:"ButtonSelected",
				selectedOverSkin:"ButtonSelected",
				selectedDownSkin:"ButtonSelected",
				selectedDisabledSkin:"ButtonDisabled"
			};
		public function ToggleButton(parent:DisplayObjectContainer=null, x:Number=0, y:Number=0,textOn:String="on",textOff:String="off")
		{
			this._textOn=textOn;
			this._textOff=textOff;
			super(parent, x, y); 
			toggle=true;
			invalidate(CallLaterType.SIZE);
		}
		override protected function preInit():void
		{
			super.preInit();
			_skin=_defaultSkin;
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
				invalidate(CallLaterType.SKIN);
				invalidate(CallLaterType.SIZE);
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
				invalidate(CallLaterType.SKIN);
			}
		}
		
		protected function toggleHandler(event:MouseEvent):void
		{
			dispatchEvent(new Event(Event.CHANGE));
			selected=!selected;
			label=selected?_textOn:_textOff;
		}
		
		override protected function drawBg():void
		{
			var bg:DisplayObject=_back;
			var styleName:String=_enabled?_mouseState:"disabled";
			if(_selected)
				styleName="selected"+styleName.charAt(0).toUpperCase()+styleName.substr(1);
			styleName+="Skin";
			_back=getSkinInstance(getStyleValue(styleName));
			addChildAt(_back,0);
			if(bg&&bg!=_back)
			{
				removeChild(bg);
				bg=null;
			}
			if(_width>0&&_height>0)
			{
				_back.width=_width;
				_back.height=_height;
			}
		}
		/**
		 *设置关闭状态下的文字 
		 * @param value
		 * 
		 */
		public function setTextOff(value:String):void
		{
			this._textOff=value;	
			invalidate(CallLaterType.SIZE);
		}
		/**
		 *设置开启状态下的文字 
		 * @param value
		 * 
		 */
		public function setTextOn(value:String):void
		{
			this._textOn=value;
			invalidate(CallLaterType.SIZE);
		}
		protected function setLabel():void
		{
			if(_selected)
				_label=_textOn;
			else
				_label=_textOff;
		}
		
		override protected function draw():void
		{
			if(isCallLater(CallLaterType.SKIN))
			{
				drawBg();
			}
			if(isCallLater(CallLaterType.SIZE))
			{
				changeBgSzie();
				setLabel();
				drawText();
			}
			clearCallLater();
		}
		
		
	}
}