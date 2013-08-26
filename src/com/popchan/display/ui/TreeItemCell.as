package com.popchan.display.ui
{
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;
	
	/**
	 *
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	public class TreeItemCell extends Component implements ITreeCell
	{
		private var _data:Object;
		private var _tf:TextField;
		public function TreeItemCell(parent:DisplayObjectContainer=null, x:Number=0, y:Number=0)
		{
			super(parent, x, y);
		}
		override protected function createChildren():void
		{
			
			
			
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
	}
}