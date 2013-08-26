package com.popchan.display.ui
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	/**
	 *简单的滚动条
	 * 		由上下2按钮，一个滑动条组成
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	[Event(name="change", type="flash.events.Event")]
	public class ScrollBar extends Component
	{
		protected var _upBtn:ButtonBase;
		protected var _downBtn:ButtonBase;
		protected var _slider:ScrollBarSlider;
		protected var _direction:String=SliderDirection.VERTICAL;
		protected var _lineScrollSize:int=1;
		/*滚动条显示方式 默认根据内容自动显示*/
		protected var _policy:String=ScrollPolicy.AUTO;
		/*皮肤*/
		private var _upBtnSkin:Object=
			{
				upSkin:"upArrowUpSkin",
				overSkin:"upArrowOverSkin",
				downSkin:"upArrowDownSkin",
				disabledSkin:"upArrowDisabledSkin"
			};
		private var _downBtnSkin:Object=
			{
				upSkin:"downArrowUpSkin",
				overSkin:"downArrowOverSkin",
				downSkin:"downArrowDownSkin",
				disabledSkin:"downArrowDisabledSkin"
			};
		private var _sliderSkin:Object=
			{
				thumbUpSkin:"thumbUpSkin",
				thumbOverSkin:"thumbOverSkin",
				thumbDownSkin:"thumbDownSkin",
				trackSkin:"trackSkin"
			};
		/*默认皮肤*/
		private  var _defaultSkin:Object=
			{
				upArrowUpSkin:"ScrollUpArrowUpSkin",
				upArrowOverSkin:"ScrollUpArrowOverSkin",
				upArrowDownSkin:"ScrollUpArrowDownSkin",
				upArrowDisabledSkin:"ScrollUpArrowDownSkin",
				downArrowUpSkin:"ScrollDownArrowUpSkin",
				downArrowOverSkin:"ScrollDownArrowOverSkin",
				downArrowDownSkin:"ScrollDownArrowDownSkin",
				downArrowDisabledSkin:"ScrollDownArrowDownSkin",
				thumbUpSkin:"ScrollThumbUpSkin",
				thumbOverSkin:"ScrollThumbOverSkin",
				thumbDownSkin:"ScrollThumbDownSkin",
				trackSkin:"ScrollTrackSkin"
			};
		
		
		public function ScrollBar(parent:DisplayObjectContainer=null, x:Number=0, y:Number=0,direction:String=SliderDirection.VERTICAL)
		{
			_direction=direction;
			super(parent, x, y);
			
		}
		override protected function preInit():void
		{
			_width=16;
			_height=200;
			_skin=_defaultSkin;
		}
		override protected function createChildren():void
		{
			_slider=new ScrollBarSlider(this,0,0,SliderDirection.VERTICAL);
			_slider.thumbPercent=1;
			_slider.snapInterval=0.01;
			_slider.autoRepeat=true;
			_slider.setSize(_width,_height);
			
			_slider.addEventListener(Event.CHANGE,onSliderChange);
			
			
			_upBtn=new ButtonBase(this,0,0);
			_upBtn.autoRepeat=true;
			_upBtn.setSize(16,16);
			_upBtn.addEventListener(ComponentEvent.BUTTON_DOWN,onUpPress);
			
			
			_downBtn=new ButtonBase(this,0,0);
			_downBtn.autoRepeat=true;
			_downBtn.setSize(16,16);
			_downBtn.addEventListener(ComponentEvent.BUTTON_DOWN,onDownPress);
		}
		
		override protected function draw():void
		{
			if(isCallLater(CallLaterType.SKIN))
			{
				setChildStyles(_slider,_sliderSkin);
				setChildStyles(_upBtn,_upBtnSkin);
				setChildStyles(_downBtn,_downBtnSkin);
				
				_slider.validateNow();
				_upBtn.validateNow();
				_downBtn.validateNow();
			}
			
			if(isCallLater(CallLaterType.SIZE))
			{
				_upBtn.y=0;
				
				_slider.height=_height-_upBtn.height-_downBtn.height;
				_slider.y=_upBtn.height;
				_downBtn.y=_height-_upBtn.height;
				
				if(_direction==SliderDirection.HORIZONTAL)
				{
					rotation=-90;
					scaleX=-1;
				}else
				{
					rotation=0;
					scaleX=1;
				}
				setScrollBarVisible();
				
			}
			clearCallLater();
		}
		/**
		 *设置滚动条的显示 
		 * 
		 */
		protected function setScrollBarVisible():void
		{
			//设置滚动条thumb显示方式
			if(_policy==ScrollPolicy.OFF)
				visible=false;
			else if(_policy==ScrollPolicy.ON)
				visible=true;
			else if(_policy==ScrollPolicy.AUTO)
				visible=_slider.thumbPercent<1;
			
		}
		protected function onSliderChange(event:Event):void
		{
			dispatchEvent(event);
		}
		
		protected function onDownPress(event:Event):void
		{
			_slider.value+=_lineScrollSize;
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		protected function onUpPress(event:Event):void
		{
			_slider.value-=_lineScrollSize;
			dispatchEvent(new Event(Event.CHANGE));
		}		
		public function get value():Number
		{
			return _slider.value;
		}
		public function set value(val:Number):void
		{
			_slider.value=val;
		}
		/**
		 * 按下滚动条轨道时滚动滑块的移动量（以像素为单位） 相当与每页的数量
		 * @return 
		 * 
		 */
		public function get pageScrollSize():int
		{
			return _slider.pageScrollSize;
		}
		public function set pageScrollSize(val:int):void
		{
			_slider.pageScrollSize=val;
		}
		public function get maximum():Number
		{
			return _slider.maximum;
		}
		
		public function set maximum(value:Number):void
		{
			_slider.maximum = value;
		}
		
		public function get minimum():Number
		{
			return _slider.minimum;
		}
		
		public function set minimum(value:Number):void
		{
			_slider.minimum = value;
		}
		/**
		 *按下箭头按钮时的滚动量（以像素为单位） 
		 * @return 
		 * 
		 */
		public function get lineScrollSize():int
		{
			return _lineScrollSize;
		}
		
		public function set lineScrollSize(value:int):void
		{
			_lineScrollSize = value;
		}
		/**
		 *设置滑块的比例，根据内容多少来决定 
		 * @param value
		 * 
		 */
		public function setThumbPercent(value:Number):void
		{
			_slider.thumbPercent=value;
			setScrollBarVisible();
		}
		/**
		 *设置滚动条属性 
		 * @param min
		 * @param max
		 * @param value
		 * 
		 */
		public function setScrollBarProperties(min:Number=0,max:Number=100,value:Number=0):void
		{
			_slider.minimum=min;
			_slider.maximum=max;
			_slider.value=value;
		}
		/**
		 *配置滚动条 
		 * @param min
		 * @param max
		 * @param value
		 * @param pageScrollSize
		 * @param thumbPercent
		 * 
		 */
		public function config(min:Number,max:Number,value:Number,pageScrollSize:int,thumbPercent:Number):void
		{
			_slider.thumbPercent=thumbPercent;
			_slider.validateNow();
			_slider.minimum=min;
			_slider.maximum=max;
			_slider.pageScrollSize=pageScrollSize;
			_slider.value=value;
			setScrollBarVisible();
		}
		/**
		 *滚动条显示策略 ScrollPolicy.AUTO ON OFF 
		 * @return 
		 * 
		 */
		public function get policy():String
		{
			return _policy;
		}
		public function set policy(value:String):void
		{
			_policy=value;
			setScrollBarVisible();
		}
		
	
		
		
	}
}