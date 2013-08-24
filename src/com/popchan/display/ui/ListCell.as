package com.popchan.display.ui
{
	import flash.display.DisplayObjectContainer;
	import flash.text.TextField;
	
	/**
	 *默认的List单元格，自定义的需要继承它
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	public class ListCell extends Component implements IListCell
	{
		protected var _tf:TextField;
		protected var _data:Object;
		protected var _selected:Boolean;
		protected var _index:int;
		public function ListCell(parent:DisplayObjectContainer=null, x:Number=0, y:Number=0)
		{
			super(parent, x, y);
		}
		
		override protected function createChildren():void
		{
			_tf=new TextField();
			_tf.textColor=0x00ffff;
			_tf.autoSize="left";
			_tf.selectable=false;
			
			addChild(_tf);
		}
		public function get data():Object
		{
			return _data;
		}
		
		public function set data(value:Object):void
		{
			_data=value;
			updateData();
		}
		
		protected function updateData():void
		{
			if(_data)
			{
				_tf.text=_data.label as String;
				
				graphics.clear();
				if(_selected)
				{
					graphics.beginFill(0xeeeeee);
				}else
				{
					graphics.beginFill(_index%2?0x666666:0x999999);	
				}
				graphics.drawRect(0,0,100,50);
				graphics.endFill();
			}
		}
		public function get selected():Boolean
		{
			return _selected;
		}
		public function set selected(value:Boolean):void
		{
			_selected=value;
			updateData();
		}

		public function get index():int
		{
			return _index;
		}

		public function set index(value:int):void
		{
			_index = value;
		}

		
	}
}