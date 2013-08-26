package com.popchan.display.component
{
	import com.popchan.display.ui.styles.StyleAssets;
	import com.popchan.manager.ResourceManager;
	import com.popchan.utils.FilterUtil;
	import com.popchan.utils.ObjectUtil;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.Dictionary;

	/**
	 *组件基类(直指本心，明心见性,抓住本质，写出实用的)
	 * 基于位图的组件,利用flash的反射机制
	 * 
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012,chenbo,All rights reserved
	 * 
	 */
	[Event(name="resize",type="flash.events.Event")]
	public class Component extends Sprite
	{
		protected var _width:Number=0;
		protected var _height:Number=0;
		/*存储延迟执行的方法*/
		protected var _callLateMethods:Dictionary;
		/*组件皮肤*/
		protected var _skin:String;
		/*标记那些属性需要延迟绘制*/
		protected var _callLaterTypes:Object;
		/*组件是否可用*/
		protected var _enabled:Boolean=true;
		/*组件标识*/
		public var id:String="";
		public function Component(parent:DisplayObjectContainer=null,x:Number=0,y:Number=0)
		{
			
			if(parent!=null)
			{
				parent.addChild(this);
			}
			move(x,y);
			
			_callLateMethods=new Dictionary();
			_callLaterTypes={};
	
			
			config();
		}
		/**
		 *配置一些东西
		 * 
		 */
		protected function config():void
		{
			
		}
		/**
		 *设置尺寸 
		 * @param width
		 * @param height
		 * 
		 */
		public function setSize(width:Number,height:Number):void
		{
			_width=width;
			_height=height;
			invalidate(CallLaterEnum.SIZE);
			dispatchEvent(new Event(Event.RESIZE));
		}
		/**
		 *移动位置
		 * @param x
		 * @param y
		 * 
		 */
		public function move(x:int,y:int):void
		{
			this.x=x;
			this.y=y;
		}
		/**
		 *延迟调用 
		 * @param method
		 * @param args
		 * 
		 */
		protected function callLater(method:Function,args:Array=null):void
		{
			_callLateMethods[method]=args||[];
			addEventListener(Event.ENTER_FRAME,onInvalidate);	
		}
		/**
		 * nextFrame调用
		 * @param type
		 * @param callLater
		 * 
		 */
		protected function invalidate(type:String,needCallLater:Boolean=true):void
		{
			_callLaterTypes[type]=true;
			if(needCallLater)
				callLater(draw);
		}
		/**
		 *执行callLater 
		 * @param event
		 * 
		 */
		protected function onInvalidate(event:Event):void
		{
			removeEventListener(Event.ENTER_FRAME,onInvalidate);
			runCallLaterMethod();
		}
		/**
		 *组件的绘制 
		 * 
		 */
		protected function draw():void
		{
			clearCallLater();
		}
		/**
		 *立即绘制 
		 * 
		 */
		public function validateNow():void
		{
			runCallLaterMethod();
			clearCallLater();
		}
		/**
		 *清除标记的属性 
		 * 
		 */
		protected function clearCallLater():void
		{
			_callLaterTypes={};
		}
		/**
		 *检测是否要绘制 
		 * @param type
		 * @return 
		 * 
		 */
		protected function isCallLater(type:String):Boolean
		{
			return _callLaterTypes[type];
		}
		/**
		 *执行callLater方法列表 
		 * 
		 */
		protected function runCallLaterMethod():void
		{
			for(var obj:Object in _callLateMethods)
			{
				var fun:Function=obj as Function;
				fun.apply(null,_callLateMethods[fun]);
				delete _callLateMethods[fun];
			}
		}
		/**
		 *width 
		 * @return 
		 * 
		 */
		override public function get width():Number
		{
			return _width;
		}
		
		override public function set width(value:Number):void
		{
			if(value==_width)return;
			setSize(value,_height);
		}
		/**
		 *height 
		 * @return 
		 * 
		 */
		override public function get height():Number
		{
			return _height;
		}
		
		override public function set height(value:Number):void
		{
			if(value==_height)return;
			setSize(_width,value);
		}
		
		override public function set x(value:Number):void
		{
			super.x =Math.round(value);
		}
		
		override public function set y(value:Number):void
		{
			super.y =Math.round(value);
		}
		/**
		 *组件是否可以接受用户交互 
		 * @return 
		 * 
		 */
		public function get enabled():Boolean
		{
			return _enabled;
		}
		
		public function set enabled(value:Boolean):void
		{
			if(value!=_enabled)
			{
				_enabled = value;
			}
		}
		/**
		 * 组件皮肤 
		 * @return 
		 * 
		 */
		public function get skin():String
		{
			return _skin;
		}

		/**
		 * @private
		 */
		public function set skin(value:String):void
		{
			_skin=value;
			invalidate(CallLaterEnum.SKIN);
		}
		/**
		 *获取皮肤的宽高 
		 * @param skinName
		 * @return 
		 * 
		 */
		public function getSkinSize(skinName:String):Point
		{
			var bmd:BitmapData=ResourceManager.getBitmapData(skinName);
			if(bmd)
				return new Point(bmd.width,bmd.height);
			return new Point(0,0);
		}
	
		
	}
}