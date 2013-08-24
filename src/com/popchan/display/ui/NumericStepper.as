package com.popchan.display.ui
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	/**
	 *数位框组件
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
		
		//skin
		private var _downBtnSkin:Object=
			{
				upSkin:"downArrowUpSkin",
				overSkin:"downArrowOverSkin",
				downSkin:"downArrowDownSkin",
				disabledSkin:"downArrowDisabledSkin"
			};
		private var _upBtnSkin:Object=
			{
				upSkin:"upArrowUpSkin",
				overSkin:"upArrowOverSkin",
				downSkin:"upArrowDownSkin",
				disabledSkin:"upArrowDisabledSkin"
			};
		private var _inputSkin:Object=
			{
				backSkin:"numericStepperInputSkin"
			};
		private var _defaultSkin:Object=
			{
				upArrowUpSkin:"NumericStepperUpArrowUpSkin",
				upArrowOverSkin:"NumericStepperUpArrowOverSkin",
				upArrowDownSkin:"NumericStepperUpArrowDownSkin",
				upArrowDisabledSkin:"NumericStepperUpArrowDownSkin",
				downArrowUpSkin:"NumericStepperDownArrowUpSkin",
				downArrowOverSkin:"NumericStepperDownArrowOverSkin",
				downArrowDownSkin:"NumericStepperDownArrowDownSkin",
				downArrowDisabledSkin:"NumericStepperDownArrowDisabledSkin",
				numericStepperInputSkin:"NumericStepperInputSkin"
			};
		
		public function NumericStepper(parent:DisplayObjectContainer=null, x:Number=0, y:Number=0)
		{
			super(parent, x, y);
		}
		override protected function preInit():void
		{
			_width=80;
			_height=22;
			_skin=_defaultSkin;
		}
		override protected function createChildren():void
		{
			
			_input=new TextInput(this);
			_input.restrict="0-9.";
			_input.setSize(_width-18,22);
			_input.addEventListener(ComponentEvent.ENTER,onInputEnter);
			
			_downBtn=new ButtonBase(this);
			_downBtn.autoRepeat=true;
			_downBtn.setSize(18,11);
			_downBtn.addEventListener(ComponentEvent.BUTTON_DOWN,onDownClick);
			
			_upBtn=new ButtonBase(this);
			_upBtn.autoRepeat=true;
			_upBtn.setSize(18,11);
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
			value=_value+1;
		}
		
		protected function onDownClick(event:Event):void
		{
			_value=Number(_input.text);
			value=_value-1;
		}
		
		override protected function draw():void
		{
			
			if(isCallLater(CallLaterType.SKIN))
			{
				setChildStyles(_input,_inputSkin);
				setChildStyles(_upBtn,_upBtnSkin);
				setChildStyles(_downBtn,_downBtnSkin);
				invalidate(CallLaterType.SIZE,false);
			}
			if(isCallLater(CallLaterType.SIZE))
			{
				_input.width=_width-18;
				_input.height=_height;
				_upBtn.x=_width-_upBtn.width;
				_upBtn.y=0;
				_downBtn.x=_width-_downBtn.width;
				_downBtn.y=_height-_downBtn.height;
			}
			
			super.draw();
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
			_value = val;
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