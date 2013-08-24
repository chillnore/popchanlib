package com.popchan.display.ui
{
	import com.popchan.display.ui.styles.StyleAssets;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	/**
	 *滑动组件
	 * 			track,thumb组成
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012,chenbo,All rights reserved
	 *
	 */
	[Event(name="change", type="flash.events.Event")]
	public class Slider extends Component
	{
		protected var _direction:String;
		protected var _maximum:Number=10;
		protected var _minimum:Number=0;
		protected var _value:Number=0;
		
		protected var _track:Sprite;
		protected var _thumb:ButtonBase;
		
		protected var _snapInterval:Number=1;
		/*滑块皮肤*/
		private var _thumbSkin:Object=
			{
				upSkin:"thumbUpSkin",
				overSkin:"thumbOverSkin",
				downSkin:"thumbDownSkin"
			};
		/*轨道皮肤*/
		private var _trackSkin:Object=
			{
				trackSkin:"trackSkin"
			};
		/*默认皮肤*/
		private  var _defaultSkin:Object=
			{
				thumbUpSkin:"SliderThumbUpSkin",
				thumbOverSkin:"SliderThumbOverSkin",
				thumbDownSkin:"SliderThumbDownSkin",
				trackSkin:"SliderTrack"
			};
		
		public function Slider(parent:DisplayObjectContainer=null, x:Number=0, y:Number=0,direction:String=SliderDirection.HORIZONTAL)
		{
			this._direction=direction;
			super(parent, x, y);
		}
		
		override protected function preInit():void
		{
			//默认宽高，皮肤
			if(_direction==SliderDirection.HORIZONTAL)
			{
				setSize(200,20);
			}else
			{
				setSize(20,200);
			}
			_skin=_defaultSkin;
		}
		
		
		override protected function createChildren():void
		{
			//drawTrack();
			drawThumb();
			setThumbPosition();
		}
		protected function drawTrack():void
		{
			if(_track)
			{
				_track.removeEventListener(MouseEvent.MOUSE_DOWN,onTrackPress);
				removeChild(_track);
			}
			_track=getSkinInstance(getStyleValue("trackSkin")) as Sprite;
			_track.addEventListener(MouseEvent.MOUSE_DOWN,onTrackPress);
			addChildAt(_track,0);
			_track.width=_width;
			_track.height=_height;
		}
		protected function drawThumb():void
		{
			_thumb=new ButtonBase(this);
			_thumb.setSize(26,30);
			setChildStyles(_thumb,_thumbSkin);
			_thumb.buttonMode=true;
			_thumb.useHandCursor=true;
			_thumb.addEventListener(MouseEvent.MOUSE_DOWN,onThumbDown);
		}
		override protected function draw():void
		{
			if(isCallLater(CallLaterType.SKIN))
			{
				drawTrack();
				setChildStyles(_thumb,_thumbSkin);
				setThumbPosition();	
			}
			if(isCallLater(CallLaterType.SIZE))
			{
				drawSliderSize();
			}
			clearCallLater();
		}
		protected function drawSliderSize():void
		{
			_track.width=_width;
			_track.height=_height;	
		}

		protected function onTrackPress(event:MouseEvent):void
		{
			if(_direction==SliderDirection.HORIZONTAL)
			{
				_thumb.x=mouseX-_thumb.width/2;
				if(_thumb.x<0)
					_thumb.x=0;
				else if(_thumb.x>_width-_thumb.width)
					_thumb.x=_width-_thumb.width;
				_value=_thumb.x*(_maximum-_minimum)/(_width-_thumb.width)+_minimum;
			}else
			{
				_thumb.y=mouseY-_thumb.height/2;
				if(_thumb.y<0)
					_thumb.y=0;
				else if(_thumb.y>_height-_thumb.height)
					_thumb.y=_height-_thumb.height;
				_value=_thumb.y*(_maximum-_minimum)/(_height-_thumb.height)+_minimum;
			}
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		protected function onThumbDown(event:MouseEvent):void
		{
			if(_direction==SliderDirection.HORIZONTAL)
				_thumb.startDrag(false,new Rectangle(0,0,_width-_thumb.width,0));
			else
				_thumb.startDrag(false,new Rectangle(0,0,0,_height-_thumb.height));
			stage.addEventListener(MouseEvent.MOUSE_UP,onThumbUp);
			stage.addEventListener(MouseEvent.MOUSE_MOVE,onThumbMove);
		}
		
		protected function onThumbMove(event:MouseEvent):void
		{
			var oldValue:Number=_value;
			if(_direction==SliderDirection.HORIZONTAL)
			{
				_value=_thumb.x*(_maximum-_minimum)/(_width-_thumb.width)+_minimum;
			}else
			{
				_value=_thumb.y*(_maximum-_minimum)/(_height-_thumb.height)+_minimum;
			}
			if(_value!=oldValue)
				dispatchEvent(new Event(Event.CHANGE));
		}
		
		protected function onThumbUp(event:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP,onThumbUp);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE,onThumbMove);
			_thumb.stopDrag();
		}
		
		/**
		 *设置滑块的位置 
		 * 
		 */
		protected function setThumbPosition():void
		{
			if(_direction==SliderDirection.HORIZONTAL)
			{
				_thumb.x=(_value-_minimum)*(_width-_thumb.width)/(_maximum-_minimum);
				if(_thumb.x<0)
					_thumb.x=0;
				else if(_thumb.x>_width-_thumb.width)
					_thumb.x=_width-_thumb.width;
				_thumb.y=0;
			}else
			{
				_thumb.x=0;
				_thumb.y=(_value-_minimum)*(_height-_thumb.height)/(_maximum-_minimum);
				if(_thumb.y<0)
					_thumb.y=0;
				else if(_thumb.y>_height-_thumb.height)
					_thumb.y=_height-_thumb.height;
			}
		}
		/**
		 *设置滑块属性 
		 * @param min
		 * @param max
		 * @param value
		 * 
		 */
		public function setSliderProperties(min:Number=0,max:Number=100,value:Number=0):void
		{
			this.maximum=max;
			this.minimum=min;
			this.value=value;
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
		}
		
		
		/**
		 *滑块当前的值 
		 * @return 
		 * 
		 */
		public function get value():Number
		{
			return Math.round(_value/_snapInterval)*_snapInterval;
		}
		
		public function set value(val:Number):void
		{
			if(val!=_value)
			{
				if(val<_minimum)
					val=_minimum;
				else if(val>_maximum)
					val=_maximum;
				_value = val;
				setThumbPosition();
			}
		}
		
		/**
		 *指定当用户移动滑块时滑块的增值
		 * @return 
		 * 
		 */
		public function get snapInterval():Number
		{
			return _snapInterval;
		}
		
		public function set snapInterval(value:Number):void
		{
			_snapInterval = value;
		}
		
		
	}
}