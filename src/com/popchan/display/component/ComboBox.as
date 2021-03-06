package com.popchan.display.component
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/**
	 *下拉列表控件
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	[Event(name="change", type="flash.events.Event")]
	public class ComboBox extends Component
	{
		protected var _prompt:String="";
		protected var _list:List;
		protected var _items:Array=[];
		
		protected var _comboBoxButton:Button;
		

		public function ComboBox(parent:DisplayObjectContainer=null, x:Number=0, y:Number=0,skinName:String="Skin_combobox")
		{
			super(parent, x, y);
			this.skin=skinName;
		}
		override public function set skin(value:String):void
		{
			if(value!=null)
			{
				_skin=value;
				
				//comboBox的宽高为其本身大小
				_comboBoxButton.skin=_skin;
				var _thumbSize:Point=getSkinSize(value);
				_comboBoxButton.setSize(_width,_height);
				
				_list.y=_comboBoxButton.height;
			}
		}
		
		override protected function config():void
		{
			setSize(100,30);
			_comboBoxButton=new Button(_prompt,this,0,0,null);
			_comboBoxButton.setSize(_width,_height);
			_comboBoxButton.addEventListener(MouseEvent.CLICK,onBtnClick);
			
			_list=new List(this,0,_comboBoxButton.height);
			_list.width=_width;
			_list.addEventListener(Event.SELECT,onListSelected);
			addChild(_list);
			_list.visible=false;
			
			if(_prompt!="")
				_comboBoxButton.label=_prompt;
		}
		
		protected function onBtnClick(event:MouseEvent):void
		{
			_list.visible=!_list.visible;
		}
		
		protected function onListSelected(event:Event):void
		{
			_comboBoxButton.label=_list.selectedItem.label;
			onBtnClick(null);
		}		
		
		/**
		 *combobox控件默认提示 当设置selectedIndex=-1时候显示 
		 * @return 
		 * 
		 */
		public function get prompt():String
		{
			return _prompt;
		}
		
		public function set prompt(value:String):void
		{
			_prompt = value;
		}
		public function get selectedIndex():int
		{
			return _list.selectedIndex;
		}
		public function set selectedIndex(value:int):void
		{
			if(value==-1)
			{
				_comboBoxButton.label=prompt;
			}else if(value>=0)
			{
				_list.selectedIndex=value;
			}
			_list.visible=false;
			
		}
		public function get selectedItem():Object
		{
			return _list.selectedItem;
		}
		public function set selectedItem(value:Object):void
		{
			_list.selectedItem=value;
			_list.visible=false;
		}
		public function addItem(value:Object):void
		{
			_list.addItem(value);
		}
		public function removeItem(value:Object):void
		{
			_list.removeItem(value);
		}
		public function removeItemAt(index:int):void
		{
			_list.removeChildAt(index);
		}
		public function removeAll():void
		{
			_list.removeAll();
		}
		public function set itemClass(value:Class):void
		{
			_list.itemClass=value;
		}
		public function set data(value:Array):void
		{
			_list.dataProvider=value;
			if(_prompt!="")
				_comboBoxButton.label=_prompt;
			else
				selectedIndex=0;
			_list.visible=false;
		}
		public function get data():Array
		{
			return _list.dataProvider;
		}
		
		
	}
}