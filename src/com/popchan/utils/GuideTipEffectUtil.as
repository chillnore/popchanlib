package com.popchan.utils
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	/**
	 *引导提示效果工具
	 *@create 2013-2-26下午9:22:06
	 *@author chenbo
	 */
	public class GuideTipEffectUtil
	{
		private static var _instance:GuideTipEffectUtil;
		private var list:Array=[];
		private var tempList:Array=[];
		private var _isRunning:Boolean;
		private var showTimer:Timer;
		private var removeTimer:Timer;
		private var count:int;
		private var aim:DisplayObject;
		private var parentContainer:DisplayObjectContainer;
		public function GuideTipEffectUtil(c:Single)
		{
			if(c==null)
			{
				throw new Error("单例");
				return;
			}
		}
		public static function get instance():GuideTipEffectUtil
		{
			if(_instance==null)
				_instance=new GuideTipEffectUtil(new Single());
			return _instance;
		}
		/**
		 * 注册
		 * @param aim 目标
		 * @param parent 效果要添加哪个容器里面
		 * 
		 */
		public function register(aim:DisplayObject,parent:DisplayObjectContainer,parentW:int=1250,parentH:int=650):void
		{
			if(_isRunning)return;
			this.aim=aim;
			this.parentContainer=parent;
			var rect:Rectangle=aim.getRect(aim);
			var p:Point=getGlobalPoint(aim);
			
			var shape:Shape=new Shape();
			shape.graphics.lineStyle(2,0xfeeca3,1);
			
			shape.graphics.drawRect(p.x,p.y,rect.width,rect.height);
			parent.addChild(shape);
			shape.visible=false;
			list.push(shape);
			for(var i:int=1;i<=8;i++)
			{
				var left:int=p.x;
				var top:int=p.y;
				var right:int=parentW-left-rect.width;
				var bottom:int=parentH-top-rect.height;
				var px:int=p.x-left/8*i;
				var py:int=p.y-top/8*i;
				var pw:int=rect.width+left/8*i+right/8*i;
				var ph:int=rect.height+top/8*i+bottom/8*i;
				if(px<0)
					px=0;
				if(py<0)
					py=0;
				if(px+pw>parentW)
					pw=parentW-px;
				if(py+ph>parentH)
					ph=parentH-py;
			
			
			
				shape=new Shape();
				shape.visible=false;
				
				shape.graphics.lineStyle(2,0xfeeca3,1);
				shape.graphics.drawRect(px,py,pw,ph);
				list.push(shape);
				parent.addChild(shape);
				/*if(pw>=parentW&&ph>=parentH)
					break;*/
			}
			count=0;
			aim.addEventListener(Event.ENTER_FRAME,update,false,0,true);
			
			showTimer=new Timer(19,list.length);
			showTimer.addEventListener(TimerEvent.TIMER,onShowUpdate,false,0,true);
			showTimer.start();
			
			removeTimer=new Timer(20,list.length);
			removeTimer.addEventListener(TimerEvent.TIMER,onRemoveUpdate,false,0,true);
			removeTimer.start();
			
			_isRunning=true;
		}
		
		protected function onRemoveUpdate(event:TimerEvent):void
		{
			var t:Timer=event.currentTarget as Timer;
			tempList.push(list[list.length-t.currentCount]);
		}
		
		protected function onShowUpdate(event:TimerEvent):void
		{
			var t:Timer=event.currentTarget as Timer;
			list[list.length-t.currentCount].visible=true;
		}
		
		/**
		 *更新 
		 * @param event
		 * 
		 */
		protected function update(event:Event):void
		{
			
			for(var i:int=tempList.length-1;i>=0;i--)
			{
				var shape:Shape=tempList[i];
				shape.alpha-=0.1;
				if(shape.alpha<0)
				{
					tempList.splice(i,1);
					count++;
				}
			}
			if(count==list.length)
				removeAll();
		}
		private function removeAll():void
		{
			aim.removeEventListener(Event.ENTER_FRAME,update);
			showTimer.stop();
			showTimer.removeEventListener(TimerEvent.TIMER,onShowUpdate);
			showTimer=null;
			
			removeTimer.stop();
			removeTimer.removeEventListener(TimerEvent.TIMER,onRemoveUpdate);
			removeTimer=null;
			
			_isRunning=false;
			
			for(var i:int=list.length-1;i>=0;i--)
			{
				var shape:Shape=list[i];
				list.splice(i,1);
				parentContainer.removeChild(shape);
			}
			trace("GuideTipEffect移出");
		}
		/**
		 *得到全局坐标 
		 * @param aim
		 * @return 
		 * 
		 */
		private function getGlobalPoint(aim:DisplayObject):Point
		{
			var aimRect:Rectangle=aim.getRect(aim);
			return aim.localToGlobal(new Point(aimRect.x,aimRect.y));
		}
		
		/**
		 *正在播放特效 
		 */
		public function get isRunning():Boolean
		{
			return _isRunning;
		}
		
	}
}
class Single
{}