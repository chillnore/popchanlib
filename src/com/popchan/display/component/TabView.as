package com.popchan.display.component
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 *tabView
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	public class TabView extends Component
	{
		/*数据源{tab:tab名称,view:相关的视图}*/
		protected var _dataProvider:Array;
		protected var _selectedIndex:int=-1;
		protected var _selectedItem:*;
		protected var _tabs:Array;
		/*tab宽高*/
		protected var _tabWidth:Number=0;
		protected var _tabHeight:Number=0;
		protected var _sameSize:Boolean=false;
		public function TabView(parent:DisplayObjectContainer=null, x:Number=0, y:Number=0,skin:String="Skin_toggle")
		{
			super(parent, x, y);
			this.skin=skin;
		}
		override protected function config():void
		{
			_tabWidth=60;
			_tabHeight=28;
			_dataProvider=[];
			_tabs=[];
		}
		/**
		 *添加item 
		 * @param label标签
		 * @param child标签下的界面
		 * 
		 */
		public function addItem(label:String,child:DisplayObject):void
		{
			child.visible=false;
			_dataProvider.push({label:label,child:child});
			invalidate(CallLaterEnum.DATA);
		}
		
		override protected function draw():void
		{
			if(isCallLater(CallLaterEnum.DATA))
			{
				createTab();
				selectedIndex=0;
			}
			if(isCallLater(CallLaterEnum.SIZE))
			{
				layout();
			}
			if(isCallLater(CallLaterEnum.SKIN))
			{
				for each(var tab:ToggleButton in _tabs)
				{
					tab.skin=_skin;
					tab.validateNow();
				}
			}
			clearCallLater();
		}
		
		
		/**
		 *创建tab 
		 * 
		 */
		protected function createTab():void
		{
			for(var i:int=0;i<_dataProvider.length;i++)
			{
				var tab:ToggleButton=new ToggleButton(_dataProvider[i].label,this,0,0,null);
				tab.addEventListener(MouseEvent.CLICK,onTabClick);
				_tabs.push(tab);
			}
			layout();
		}
		
		protected function onTabClick(event:Event):void
		{
			var btn:ToggleButton=event.currentTarget as ToggleButton;
			var index:int=_tabs.indexOf(btn);
			if(index!=-1)
			{
				selectedIndex=index;
			}
		}
		
		protected function layout():void
		{
			var offsetX:Number=0;
			var eachWidth:int=_width/_tabs.length;
			for each(var tab:ToggleButton in _tabs)
			{
				tab.x=offsetX;
				if(_sameSize)
				{
					tab.autoSize=false;
					tab.width=_tabWidth;
					tab.height=_tabHeight;
				}else
				{
					tab.autoSize=true;
				}
				tab.validateNow();
				if(_sameSize)
					offsetX+=_tabWidth;
				else
					offsetX+=tab.width;
				
			}
		}
		/**
		 *数据源 视图
		 * @return 
		 * 
		 */
		public function get dataProvider():Array
		{
			return _dataProvider;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set dataProvider(value:Array):void
		{
			if(value!=_dataProvider&&value!=null)
			{
				_dataProvider = value;
				invalidate(CallLaterEnum.DATA);
			}
		}
		/**
		 *选中项目的基于 0 的索引；或者如果未选中项目，则为基于 -1 的索引。 
		 * @return 
		 * 
		 */
		public function get selectedIndex():int
		{
			return _selectedIndex;
		}
		
		public function set selectedIndex(value:int):void
		{
			if(_selectedIndex!=value)
			{
				hideView();
				_selectedIndex = value;
				_selectedItem=_dataProvider[_selectedIndex].child;
				
				_selectedItem.visible=true;
				_tabs[_selectedIndex].selected=true;
				dispatchEvent(new Event(Event.CHANGE));
			}
		}
		/**
		 *隐藏视图 
		 * 
		 */
		protected function hideView():void
		{
			for each(var tab:ToggleButton in _tabs)
			{
				tab.selected=false;
			}
			for each(var obj:Object in _dataProvider)
			{
				obj.child.visible=false;
			}
		}
		/**
		 *当前已选中的项目 
		 * @return 
		 * 
		 */
		public function get selectedItem():*
		{
			return _selectedItem;
		}
		
		/**
		 *设置选中项目 
		 * @param value
		 * 
		 */
		public function set selectedItem(value:*):void
		{
			if(value!=_selectedItem)
			{
				_selectedItem = value;
				selectedIndex=getIndexByChild(_selectedItem);
			}
		}
		/**
		 *获取索引 通过child
		 * @param tab
		 * @return 
		 * 
		 */
		private function getIndexByChild(child:DisplayObject):int
		{
			var i:int=0;
			for each(var obj:Object in _dataProvider)
			{
				if(obj.child==child)
					return i;
				i++;
			}
			return -1;
		}

		/**
		 *是否使用相同的宽高true=宽高为指定的tabWidth,tabHeight,false则根据文本大小确定 
		 * @return 
		 * 
		 */
		public function get sameSize():Boolean
		{
			return _sameSize;
		}

		public function set sameSize(value:Boolean):void
		{
			_sameSize = value;
		}

		public function get tabWidth():Number
		{
			return _tabWidth;
		}

		public function set tabWidth(value:Number):void
		{
			_tabWidth = value;
		}

		public function get tabHeight():Number
		{
			return _tabHeight;
		}

		public function set tabHeight(value:Number):void
		{
			_tabHeight = value;
		}


	}
}