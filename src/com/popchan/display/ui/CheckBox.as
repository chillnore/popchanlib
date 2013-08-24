package com.popchan.display.ui
{
	import flash.display.DisplayObjectContainer;
	import flash.text.TextFieldAutoSize;
	
	/**
	 *选择按钮
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	public class CheckBox extends ToggleButton
	{
		/**
		 *默认皮肤 
		 */		
		private var _defaultSkin:Object=
			{
				upSkin:"CheckBoxUp",
				overSkin:"CheckBoxOver",
				downSkin:"CheckBoxDown",
				disabledSkin:"CheckBoxDisabled",
				selectedUpSkin:"CheckBoxSelectedUp",
				selectedOverSkin:"CheckBoxSelectedOver",
				selectedDownSkin:"CheckBoxSelectedDown",
				selectedDisabledSkin:"CheckBoxSelectedDisabled"
			};
		public function CheckBox(parent:DisplayObjectContainer=null, x:Number=0, y:Number=0, textOn:String="on", textOff:String="off")
		{
			super(parent, x, y, textOn, textOff);
			_skin=_defaultSkin;	
		}
		
		override protected function drawText():void
		{
			super.drawText();
			_tf.autoSize=TextFieldAutoSize.LEFT;
			_tf.x=_width+2;
			_tf.y=_height-_tf.height>>1;
		}

	}
}