package com.popchan.display.ui
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;
	
	import flashx.textLayout.elements.OverflowPolicy;
	
	/**
	 *选项按钮
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	[Event(name="change", type="flash.events.Event")]
	public class RadioButton extends Button
	{
		protected var _selected:Boolean;
		protected var _groupName:String="RadioButtonGroup";
		private static var _groups:Array;
		/**
		 *默认皮肤 
		 */		
		private var _defaultSkin:Object=
			{
				upSkin:"RadioButtonUpSkin",
				overSkin:"RadioButtonOverSkin",
				downSkin:"RadioButtonDownSkin",
				disabledSkin:"RadioButtonDisabledSkin",
				selectedUpSkin:"RadioButtonSelectedUpSkin",
				selectedOverSkin:"RadioButtonSelectedOverSkin",
				selectedDownSkin:"RadioButtonSelectedDownSkin",
				selectedDisabledSkin:"RadioButtonSelectedDisabledSkin"
			};
		public function RadioButton(parent:DisplayObjectContainer=null, x:Number=0, y:Number=0, label:String=null)
		{
			super(parent, x, y, label);
			
			
		}
		override protected function preInit():void
		{
			super.preInit();
			_skin=_defaultSkin;
			setSize(14,14);
			this.addEventListener(MouseEvent.CLICK,onClick);
			if(_groups==null)
				_groups=[];
			addRadioButton(this);
		}
		/**
		 *添加radiobutton到组 
		 * @param radio
		 * 
		 */
		public static function addRadioButton(radio:RadioButton):void
		{
			_groups.push(radio);
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
				cancelRaidoButtonSelected();
				dispatchEvent(new Event(Event.CHANGE));
			}
			invalidate(CallLaterType.SKIN);
		}
		public  function cancelRaidoButtonSelected():void
		{
			for each(var radio:RadioButton in _groups)
			{
				if(radio!=this&&radio.groupName==_groupName)
					radio.selected=false;
			}
		}

		public function get groupName():String
		{
			return _groupName;
		}

		public function set groupName(value:String):void
		{
			_groupName = value;
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
	}
}