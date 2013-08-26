package com.popchan.display.ui
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.text.TextField;
	
	/**
	 *
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	public class TreeFolderCell extends Component implements ITreeCell
	{
		private var _data:Object;
		private var _tf:TextField;
		private var _isOpen:Boolean;
		public static var folderOpenIcon:Class;
		public static var folderClosedIcon:Class;
		
		private var _openIcon:DisplayObject;
		private var _closedIcon:DisplayObject;
		private var _back:Shape;
		public function TreeFolderCell(parent:DisplayObjectContainer=null, x:Number=0, y:Number=0)
		{
			super(parent, x, y);
		}
		
		override protected function createChildren():void
		{

			_height=50;
			if(folderClosedIcon)
			{
				_closedIcon=new folderClosedIcon();
				_closedIcon.y=3;
				addChild(_closedIcon);
			}
			if(folderOpenIcon)
			{
				_openIcon=new folderOpenIcon();
				_openIcon.y=3;
				addChild(_openIcon);
			}
			
			isOpen=false;
			
			_tf=new TextField();
			_tf.selectable=false;
			_tf.autoSize="left";
			addChild(_tf);
			_tf.x=16;
			
			
			
		}
		
		
		public function get selected():Boolean
		{
			return false;
		}
		
		public function set selected(value:Boolean):void
		{
		}
		
		public function get data():Object
		{
			return _data;
		}
		
		public function set data(value:Object):void
		{
			_data=value;
			_tf.text=value.@label;
			
		}

		public function get isOpen():Boolean
		{
			return _isOpen;
		}

		public function set isOpen(value:Boolean):void
		{
			_isOpen = value;
			if(value)
			{
				_closedIcon.visible=false;
				_openIcon.visible=true;
			}else
			{
				_closedIcon.visible=true;
				_openIcon.visible=false;	
			}
		}

	}
}