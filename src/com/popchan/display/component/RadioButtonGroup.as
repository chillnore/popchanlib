package com.popchan.display.component
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	/**
	 *单选按钮组
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	[Event(name="change", type="flash.events.Event")]
	public class RadioButtonGroup extends Component
	{
		protected var _labels:String;
		protected var _groups:Array=[];
		protected var _spacing:int=30;
		protected var _selectedRadio:RadioButton;
		protected var _selectedIndex:int=-1;
		public function RadioButtonGroup(labels:String="单选1,单选2",parent:DisplayObjectContainer=null, x:Number=0, y:Number=0,skin:String="Skin_radiobutton")
		{
			super(parent, x, y);
			this.skin=skin;
			this.labels=labels;
		}
		
		override protected function config():void
		{
			super.config();
			_width=100;
			_height=30;
		}
		
		
		public function get labels():String
		{
			return _labels;
		}

		public function set labels(value:String):void
		{
			if(value!=null)
			{
				_labels = value;
				createRaidoButton();
			}
		}
		protected function layout():void
		{
			for(var i:int=0;i<_groups.length;i++)
			{
				var rg:RadioButton=_groups[i];
				rg.x=x+i*_spacing;
				rg.y=y;
			}
		}
		
		protected function onRadioChange(event:Event):void
		{
			var rg:RadioButton=event.target as RadioButton;
			if(_selectedRadio==rg)return;
			
			for each(var rb:RadioButton in _groups)
			{
				rb.selected=false;
				
			}
			_selectedRadio=rg;
			rg.selected=true;
			_selectedIndex=_groups.indexOf(rg);
			dispatchEvent(event);
		}
		protected function removeAll():void
		{
			for(var i:int=_groups.length-1;i>=0;i--)
			{
				var rg:RadioButton=_groups[i];
				rg.removeEventListener(Event.CHANGE,onRadioChange);
				this.parent.removeChild(rg);
				_groups.splice(i,1);
			}
		}
		/**
		 *间距 
		 * @return 
		 * 
		 */
		public function get spacing():int
		{
			return _spacing;
		}

		public function set spacing(value:int):void
		{
			_spacing = value;
			layout();
		}

		public function get selectedIndex():int
		{
			return _selectedIndex;
		}

		public function set selectedIndex(value:int):void
		{
			if(value!=_selectedIndex)
			{
				_selectedIndex = value;
				_groups[value].selected=true;
			}
		}
		protected function createRaidoButton():void
		{
			removeAll();
			var arr:Array=_labels.split(",");
			for(var i:int=0;i<arr.length;i++)
			{
				var rg:RadioButton=new RadioButton(arr[i],parent,x,y);
				rg.addEventListener(Event.CHANGE,onRadioChange);
				_groups.push(rg);
			}
			layout();
		}
		override protected function draw():void
		{
			if(isCallLater(CallLaterEnum.SKIN))
			{
				for each(var radio:RadioButton in _groups)
				{
					radio.skin=_skin;
					radio.validateNow();
				}
			}
			clearCallLater();
		}
		
		

	}
}