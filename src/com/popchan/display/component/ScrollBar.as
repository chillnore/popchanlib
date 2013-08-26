package com.popchan.display.component
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 *滚动条
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	public class ScrollBar extends Component
	{
		protected var _upBtn:ButtonBase;
		protected var _downBtn:ButtonBase;
		protected var _slider:ScrollBarSlider;
		protected var _direction:String=SliderDirection.VERTICAL;
		protected var _lineScrollSize:int=1;
		/*滚动条显示方式 默认根据内容自动显示*/
		protected var _policy:String=ScrollPolicy.AUTO;
		public function ScrollBar(parent:DisplayObjectContainer=null, x:Number=0, y:Number=0,direction:String=SliderDirection.VERTICAL,skinName:String="Skin_scrollbar")
		{
			super(parent, x, y);
			
			_direction=direction;
			skin=skinName;
		}
		override protected function config():void
		{
			_width=18;
			_height=150;
			
			_slider=new ScrollBarSlider(this,0,0,null);
			_slider.thumbPercent=0.2;
			_slider.snapInterval=0.01;
			_slider.addEventListener(Event.CHANGE,onSliderChange);
			
			_upBtn=new ButtonBase(this,0,0,null);
			_upBtn.autoRepeat=true;
			_upBtn.addEventListener(ComponentEvent.BUTTON_DOWN,onUpPress);
			
			_downBtn=new ButtonBase(this,0,0,null);
			_downBtn.autoRepeat=true;
			_downBtn.addEventListener(ComponentEvent.BUTTON_DOWN,onDownPress);
		}
		override public function set skin(value:String):void
		{
			if(value!=null)
			{
				_skin=value;
				
				
				_upBtn.skin=value+"_up";
				var _thumbSize:Point=getSkinSize(value+"_up");
				_upBtn.setSize(_thumbSize.x/_upBtn.skinColCount,_thumbSize.y/_upBtn.skinRowCount);
				
				_downBtn.skin=value+"_down";
				_thumbSize=getSkinSize(value+"_down");
				_downBtn.setSize(_thumbSize.x/_downBtn.skinColCount,_thumbSize.y/_downBtn.skinRowCount);
				
				_slider.trackScale9="3,3,12,12";
				_slider.thumbScale9="2,2,4,4";
				_slider.skin=value;
				_slider.height=_height-_upBtn.height-_downBtn.height;
				_slider.y=_upBtn.height;
				_upBtn.y=0;
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
			}
		}
		override protected function draw():void
		{
			
			if(isCallLater(CallLaterEnum.SIZE))
			{
				_upBtn.y=0;
				
				_slider.width=_width;
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
		protected function onDownPress(event:Event):void
		{
			_slider.value+=_lineScrollSize;
			dispatchEvent(new Event(Event.CHANGE));
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
		protected function onUpPress(event:Event):void
		{
			_slider.value-=_lineScrollSize;
			dispatchEvent(new Event(Event.CHANGE));
		}
		protected function onSliderChange(event:Event):void
		{
			dispatchEvent(event);
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
		 *设置滑块的九宫格属性 
		 * @param value
		 * 
		 */
		public function set thumbScale9(value:String):void
		{
			_slider.thumbScale9=value;
		}
		/**
		 *设置轨道的九宫格属性 
		 * @param value
		 * 
		 */
		public function set trackScale9(value:String):void
		{
			_slider.trackScale9=value;
		}
	}
}