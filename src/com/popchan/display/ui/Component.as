package com.popchan.display.ui
{
	import com.popchan.display.ui.styles.StyleAssets;
	import com.popchan.utils.FilterUtil;
	import com.popchan.utils.ObjectUtil;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	/**
	 *组件基类(直指本心，明心见性,抓住本质，写出实用的)
	 * 
	 * 	公共属性
	 * 			1.enabled=value 设置组件是否可用
	 * 			2.skin=value组件皮肤
	 *  公共方法 
	 * 			1.setSize(w,h)改变大小
	 * 			2.move(x,y)设置位置
	 * 			3.setStyle(styleName,value)更改部分样式
	 * 			4.getStyleValue(styleName)获取样式的值
	 * 			5.getSkinInstance(value)获取样式实例
	 * 			
	 *   事件
	 * 			1.Event.RESIZE 组件尺寸改变
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
		protected var _skin:Object;
		/*标记那些属性需要延迟绘制*/
		protected var _callLaterTypes:Object;
		/*组件是否可用*/
		protected var _enabled:Boolean=true;
		public function Component(parent:DisplayObjectContainer=null,x:Number=0,y:Number=0)
		{
			
			if(parent!=null)
			{
				parent.addChild(this);
			}
			move(x,y);
			
			_skin={};
			_callLateMethods=new Dictionary();
			_callLaterTypes={};
			invalidate(CallLaterType.ALL);
			
			preInit();
			createChildren();
		}
		/**
		 *预初始化  子类override
		 * 
		 */
		protected function preInit():void
		{
			
		}
		/**
		 *创建子元件 子类override
		 * 
		 */
		protected function createChildren():void
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
			invalidate(CallLaterType.SIZE);
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
		protected function invalidate(type:String=CallLaterType.ALL,needCallLater:Boolean=true):void
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
		 *检测是否要重新绘制 
		 * @param type
		 * @return 
		 * 
		 */
		protected function isCallLater(type:String):Boolean
		{
			return _callLaterTypes[type]||_callLaterTypes[CallLaterType.ALL];
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
		/**********************************皮肤相关处理*********************************/
		/**
		 * 组件皮肤 key-value形式，key为字符串,value可为String,Class,displayObject
		 * @return 
		 * 
		 */
		public function get skin():Object
		{
			return _skin;
		}

		/**
		 * @private
		 */
		public function set skin(value:Object):void
		{
			if(value!=_skin)
			{
				_skin = value;
				invalidate(CallLaterType.SKIN);
			}
		}
		/**
		 *设置样式
		 * @param name
		 * @param value
		 * 
		 */
		public function setStyle(name:String,value:Object):void
		{
			_skin[name]=value;
			invalidate(CallLaterType.SKIN);
		}
		/**
		 *获取样式的值 
		 * @param name
		 * @return 
		 * 
		 */
		public function getStyleValue(name:String):Object
		{
			return _skin[name];
		}
		/**
		 *获取皮肤实例 
		 * @param value 可以传类，displayObject或者字符串
		 * @return 
		 * 
		 */
		public function getSkinInstance(value:Object):DisplayObject
		{
			if (value is Class)
			{
				return DisplayObject(new value());
			}
			else if (value is DisplayObject)
			{
				return value as DisplayObject;
			}else
			{
				return StyleAssets.getDisplayObject(value as String);
			}
			return null;	
		}
		/**
		 *设置子元件的样式 当组件有很多Componet类型子组件时
		 * @param child
		 * @param styles
		 * 
		 */
		public function setChildStyles(child:Component,styles:Object):void
		{
			for(var o:String in styles)
			{
				child.setStyle(o,getStyleValue(styles[o]));
			}
		}
	}
}