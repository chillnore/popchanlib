package com.popchan.display.component
{
	import com.popchan.manager.ResourceManager;
	import com.popchan.utils.BitmapUtil;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 *滑动组件
	 * track,thumb组成 当尺寸改变时候，只改变track的宽度,thumb的宽高保持不变
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
		
		protected var _track:Image;
		protected var _thumb:ButtonBase;
		/*间隔*/
		protected var _snapInterval:Number=1;
		protected var _trackScale9:String="2,2,4,4";
		
		public function Slider(skinName:String=null,direction:String=SliderDirection.HORIZONTAL,parent:DisplayObjectContainer=null, x:Number=0, y:Number=0)
		{
			this._direction=direction;
			super(parent, x, y);
			
			this.skin=skinName;
		}
		
		override protected function config():void
		{
			//默认宽高，皮肤
			if(_direction==SliderDirection.HORIZONTAL)
			{
				setSize(200,10);
			}else
			{
				setSize(10,200);
			}
			//draw track
			_track=new Image(this);
			_track.aspectRatio=false;
			_track.addEventListener(MouseEvent.MOUSE_DOWN,onTrackPress);
			//draw thumb
			_thumb=new ButtonBase(this,0,0,null);
			_thumb.addEventListener(MouseEvent.MOUSE_DOWN,onThumbDown);
			//设置位置
			setThumbPosition();	
	
		}
		
		override public function set skin(value:String):void
		{
			if(value!=null)
			{
				_skin=value;
				_thumb.skin=value;
				var _thumbSize:Point=getSkinSize(_skin);
				_thumb.setSize(_thumbSize.x/_thumb.skinColCount,_thumbSize.y/_thumb.skinRowCount);
				
				_track.bitmapData=ResourceManager.getBitmapData(_skin+"_track");
				_track.setSize(_width,_height);
			}
		}
		override protected function draw():void
		{
			if(isCallLater(CallLaterEnum.SIZE))
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
			if(val<_minimum)
				val=_minimum;
			else if(val>_maximum)
				val=_maximum;
			_value = val;
			setThumbPosition();
			
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

		/**
		 *track的scale9 
		 */
		public function get trackScale9():String
		{
			return _trackScale9;
		}

		/**
		 * @private
		 */
		public function set trackScale9(value:String):void
		{
			_trackScale9 = value;
			_track.scale9=value;
		}
		/**
		 *获取滑块 
		 * @return 
		 * 
		 */
		public function get thumb():ButtonBase
		{
			return _thumb;
		}
		
	}
}