package com.popchan.utils
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.ui.Mouse;
	
	/**
	 *变形工具
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	public class TransformTool extends Sprite
	{
		[Embed(source="com/popchan/icon/SizeNESW.png")]
		private var SizeNESW:Class;
		[Embed(source="com/popchan/icon/SizeNS.png")]
		private var SizeNS:Class;
		[Embed(source="com/popchan/icon/SizeNWSE.png")]
		private var SizeNWSE:Class;
		[Embed(source="com/popchan/icon/SizeWE.png")]
		private var SizeWE:Class;
		
		
		
		private var _target:Sprite;
		private var _mask:Sprite;
		private var _shape:Shape;
		
		
		private var sizeNESW:Bitmap;
		private var sizeNS:Bitmap;
		private var sizeNWSE:Bitmap;
		private var sizeWE:Bitmap;
		private var sizeObj:Object={};
		
		private var controlPoints:Array=[];
		public function TransformTool()
		{
			this.mouseEnabled=false;
			
			_mask=new Sprite();
			_mask.mouseEnabled=false;
			addChild(_mask);
			
			_shape=new Shape();
			_shape.graphics.beginFill(0xffffff,0);
			_shape.graphics.drawRect(0,0,2,2);
			_mask.addChild(_shape);
			
			sizeNESW=new SizeNESW();
			sizeNESW.visible=false;
			_mask.addChild(sizeNESW);
			sizeObj.ne=sizeNESW;
			sizeObj.sw=sizeNESW;
			
			sizeNS=new SizeNS();
			sizeNS.visible=false;
			_mask.addChild(sizeNS);
			sizeObj.n=sizeNS;
			sizeObj.s=sizeNS;
			
			sizeNWSE=new SizeNWSE();
			sizeNWSE.visible=false;
			_mask.addChild(sizeNWSE);
			sizeObj.nw=sizeNWSE;
			sizeObj.se=sizeNWSE;
			
			sizeWE=new SizeWE();
			sizeWE.visible=false;
			_mask.addChild(sizeWE);
			sizeObj.w=sizeWE;
			sizeObj.e=sizeWE;
			
			var directions:Array=["nw","n","ne","w",null,"e","sw","s","se"];
			for(var i:int=0;i<9;i++)
			{
				var cp:ControlPoint=new ControlPoint();
				cp.direction=directions[i];
				_mask.addChild(cp);
				cp.addEventListener(MouseEvent.MOUSE_DOWN,onCpDown);
				cp.addEventListener(MouseEvent.ROLL_OVER,onCpOver);
				cp.addEventListener(MouseEvent.ROLL_OUT,onCpOut);
				controlPoints.push(cp);
				cp.visible=false;
			}
			
		}
		
		public function register(target:Sprite):void
		{
			_target=target;
			targetOldX=_target.x;
			targetOldY=_target.y;
			this.x=_target.x;
			this.y=_target.y;
			_target.parent.addChild(this);
			
			for(var i:int=0;i<controlPoints.length;i++)
			{
				var cp:ControlPoint=controlPoints[i];
				
				if(i==4)continue;
				cp.visible=true;
				cp.x=i%3*(_target.width/2);
				cp.y=int(i/3)*(_target.height/2);
			}
			
			doLayout();
			
		}
		private function doLayout():void
		{
			
			var x:Number=controlPoints[0].x;
			var y:Number=controlPoints[0].y;
			var w:Number=Math.abs(controlPoints[2].x-controlPoints[0].x);
			var h:Number=Math.abs(controlPoints[8].y-controlPoints[2].y);
			_shape.width=w;
			_shape.height=h;
			_shape.x=x;
			_shape.y=y;
			
			for(var i:int=0;i<controlPoints.length;i++)
			{
				var cp:ControlPoint=controlPoints[i];
				
				if(i==4)continue;
				cp.visible=true;
				cp.x=i%3*(_shape.width/2)+_shape.x;
				cp.y=int(i/3)*(_shape.height/2)+_shape.y;
			}
			
			_mask.graphics.clear();
			_mask.graphics.lineStyle(1,0x00ccff);
			_mask.graphics.moveTo(controlPoints[0].x,controlPoints[0].y);
			_mask.graphics.lineTo(controlPoints[2].x,controlPoints[2].y);
			_mask.graphics.lineTo(controlPoints[8].x,controlPoints[8].y);
			_mask.graphics.lineTo(controlPoints[6].x,controlPoints[6].y);
			_mask.graphics.lineTo(controlPoints[0].x,controlPoints[0].y);
		}
		private var oldX:Number=0;
		private var oldY:Number=0;
		private var targetOldX:Number=0;
		private var targetOldY:Number=0;
		private function onCpOver(e:MouseEvent):void
		{
			Mouse.hide();
			var cp:ControlPoint=e.currentTarget as ControlPoint;
			var icon:Bitmap=sizeObj[cp.direction];
			icon.x=e.target.x-icon.width/2;
			icon.y=e.target.y-icon.height/2;
			icon.visible=true;
		}
		private function onCpOut(e:MouseEvent):void
		{
			Mouse.show();
			var cp:ControlPoint=e.currentTarget as ControlPoint;
			var icon:Bitmap=sizeObj[cp.direction];
			icon.visible=false;
		}
		private function onCpMove(e:Event):void
		{
			var cp:ControlPoint=e.currentTarget as ControlPoint;
			var disX:Number=mouseX-oldX;
			var disY:Number=mouseY-oldY;
		
			if(cp.direction=="nw")
			{
				cp.y+=disY;
				controlPoints[0].y=controlPoints[2].y=cp.y;	
				
				cp.x+=disX;
				controlPoints[0].x=controlPoints[6].x=cp.x;
				
			}else if(cp.direction=="n")
			{
				cp.y+=disY;
				controlPoints[0].y=controlPoints[2].y=cp.y;	
			}else if(cp.direction=="ne")
			{
				cp.y+=disY;
				controlPoints[0].y=controlPoints[2].y=cp.y;	
				
				cp.x+=disX;
				controlPoints[2].x=controlPoints[8].x=cp.x;
				
			}else if(cp.direction=="w")
			{
				cp.x+=disX;
				controlPoints[0].x=controlPoints[6].x=cp.x;
			}else if(cp.direction=="e")
			{
				cp.x+=disX;
				controlPoints[2].x=controlPoints[8].x=cp.x;
			}else if(cp.direction=="sw")
			{
				cp.y+=disY;
				controlPoints[6].y=controlPoints[8].y=cp.y;	
				
				cp.x+=disX;
				controlPoints[0].x=controlPoints[6].x=cp.x;
				
			}else if(cp.direction=="s")
			{
				cp.y+=disY;
				controlPoints[6].y=controlPoints[8].y=cp.y;	
			}else if(cp.direction=="se")
			{
				cp.x+=disX;
				controlPoints[2].x=controlPoints[8].x=cp.x;
				
				cp.y+=disY;
				controlPoints[6].y=controlPoints[8].y=cp.y;	
			}
			doLayout();
			var icon:Bitmap=sizeObj[cp.direction];
			icon.x=cp.x-icon.width/2;
			icon.y=cp.y-icon.height/2;
			oldX=mouseX;
			oldY=mouseY;
		}
		private function onCpUp(e:MouseEvent):void
		{
			oldX=mouseX;
			oldY=mouseY;
			currentCP.removeEventListener(Event.ENTER_FRAME,onCpMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP,onCpUp);
			
			_target.width=_shape.width;
			_target.height=_shape.height;
			_target.x=targetOldX+_shape.x;
			_target.y=targetOldY+_shape.y;
		}
		private function onCpDown(e:MouseEvent):void
		{
			var cp:ControlPoint=e.currentTarget as ControlPoint;
			currentCP=cp;
			oldX=mouseX;
			oldY=mouseY;
			cp.addEventListener(Event.ENTER_FRAME,onCpMove);
			stage.addEventListener(MouseEvent.MOUSE_UP,onCpUp);
		}
		private var currentCP:ControlPoint;
		public function unregister(target:DisplayObject):void
		{
			if(_target!=null&&_target.parent.contains(this))
				_target.parent.removeChild(this);
		}
	}
}
import flash.display.Bitmap;
import flash.display.Shape;
import flash.display.Sprite;

class ControlPoint extends Sprite
{
	public var direction:String;
	public function ControlPoint()
	{
		var shape:Shape=new Shape();
		shape.graphics.lineStyle(1,0x00ccff);
		shape.graphics.beginFill(0xffffff);
		shape.graphics.drawRect(-2,-2,4,4);
		shape.graphics.endFill();
		addChild(shape);
	}
}