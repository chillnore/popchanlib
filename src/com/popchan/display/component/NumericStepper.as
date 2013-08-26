package com.popchan.display.component
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	
	/**
	 *数位框组件 上下按钮宽不变,高度改变即可
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	[Event(name="change", type="flash.events.Event")]
	public class NumericStepper extends Component
	{
		protected var _input:TextInput;
		protected var _downBtn:ButtonBase;
		protected var _upBtn:ButtonBase;
		protected var _maximum:Number=10;
		protected var _minimum:Number=0;
		protected var _value:Number=1;
		protected var _stepSize:Number=1;
		protected var _inputScale9:String="12,7,45,9";
		protected var _buttonScale9:String="1,1,15,8";
		
		public function NumericStepper(parent:DisplayObjectContainer=null, x:Number=0, y:Number=0,skin:String="Skin_numeric")
		{
			super(parent, x, y);
			this.skin=skin;
		}
		override protected function config():void
		{
			_width=80;
			_height=26;
			
			_input=new TextInput(this);
			_input.restrict="0-9.";
			_input.text="0";
			_input.addEventListener(ComponentEvent.ENTER,onInputEnter);
			
			_downBtn=new ButtonBase(this);
			_downBtn.autoRepeat=true;
			_downBtn.addEventListener(ComponentEvent.BUTTON_DOWN,onDownClick);
			
			_upBtn=new ButtonBase(this);
			_upBtn.autoRepeat=true;
			_upBtn.addEventListener(ComponentEvent.BUTTON_DOWN,onUpClick);
		}
		
		protected function onInputEnter(event:Event):void
		{
			_value=Number(_input.text);
			value=_value;
		}
		
		protected function onUpClick(event:Event):void
		{
			_value=Number(_input.text);
			value=_value+_stepSize;
		}
		
		protected function onDownClick(event:Event):void
		{
			_value=Number(_input.text);
			value=_value-_stepSize;
		}
		
		override protected function draw():void
		{
			if(isCallLater(CallLaterEnum.SKIN))
			{
				_input.skin=_skin;
				_input.scale9=_inputScale9;
				_upBtn.skin=_skin+"_up";
				_downBtn.skin=_skin+"_down";
				_upBtn.scale9=_downBtn.scale9=_buttonScale9;
				
			
				
				invalidate(CallLaterEnum.SIZE,false);
			}
			if(isCallLater(CallLaterEnum.SIZE))
			{
				var size:Point=getSkinSize(_skin+"_up");
				_upBtn.setSize(size.x/_upBtn.skinColCount,_height/2);
				
				size=getSkinSize(_skin+"_down");
				_downBtn.setSize(size.x/_downBtn.skinColCount,_height/2);
				
				_input.setSize(_width-_upBtn.width,_height);
				
				_input.validateNow();
				_upBtn.validateNow();
				_downBtn.validateNow();
				
				_upBtn.x=_width-_upBtn.width;
				_upBtn.y=0;
				
				_downBtn.x=_width-_downBtn.width;
				_downBtn.y=_height-_downBtn.height;
			}
			
			clearCallLater();
		}
		
		
		/**
		 *每次增加的值 
		 */
		public function get stepSize():Number
		{
			return _stepSize;
		}
		
		/**
		 * @private
		 */
		public function set stepSize(value:Number):void
		{
			_stepSize = value;
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
			_input.text=_minimum+"";
		}
		
		public function get value():Number
		{
			return _value;
		}
		
		public function set value(val:Number):void
		{
			if(val>_maximum)
				val=_maximum;
			else if(val<_minimum)
				val=_minimum;
			
			_value = Math.round(val/_stepSize)*_stepSize;
			_input.text=_value.toString();
			dispatchEvent(new Event(Event.CHANGE));
		}
		/**
		 *可输入的最大字符数 
		 * @param value
		 * 
		 */
		public function set maxChars(value:int):void
		{
			_input.maxChars=value;
		}
		/**
		 * 指示用户可以输入到控件的字符集
		 * @param value
		 * 
		 */
		public function set restrict(value:String):void
		{
			_input.restrict=value;
		}
		/**
		 *文本字体大小 
		 * @return 
		 * 
		 */
		public function get fontSize():int
		{
			return _input.fontSize;
		}
		public function set fontSize(value:int):void
		{
			_input.fontSize=value;
		}
		/**
		 *文本字体颜色
		 * @return 
		 * 
		 */
		public function get color():uint
		{
			return _input.color;
		}
		public function set color(value:uint):void
		{
			_input.color=value;
		}
		
	}
}