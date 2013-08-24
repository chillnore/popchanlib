package com.popchan.display.screen
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	
	/**
	 *层,游戏有很多层次，不同的内容放在不同的层次
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	public class Layer extends Sprite
	{
		public var maskShape:Shape;
		private var stageRef:Stage;
		public function Layer(stageRef:Stage)
		{			
			this.stageRef=stageRef;
			maskShape=new Shape();
			maskShape.graphics.beginFill(0x000000,.6);
			maskShape.graphics.drawRect(0,0,stageRef.stageWidth,stageRef.stageHeight);
			
			maskShape.graphics.endFill();
			addChild(maskShape);
			
			maskShape.visible=false;
		}
		/**
		 *显示遮罩 
		 * 
		 */
		public function showMask():void
		{		
			maskShape.visible=true;
		}
		/**
		 *隐藏遮罩 
		 * 
		 */
		public function hideMask():void
		{
			maskShape.visible=false;
		}
	}
}