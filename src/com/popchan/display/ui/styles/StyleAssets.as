package com.popchan.display.ui.styles
{
	import flash.display.DisplayObject;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;

	/**
	 *皮肤资源
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012,chenbo,All rights reserved
	 *
	 */
	public class StyleAssets
	{
		/*Button*/
		[Embed(source="style.swf", symbol="Button_up")]
		public static var ButtonUp:Class;
		[Embed(source="style.swf", symbol="Button_over")]
		public static var ButtonOver:Class;
		[Embed(source="style.swf", symbol="Button_down")]
		public static var ButtonDown:Class;
		[Embed(source="style.swf", symbol="Button_selected")]
		public static var ButtonSelected:Class;
		[Embed(source="style.swf", symbol="Button_disabled")]
		public static var ButtonDisabled:Class;
		/*Checkbox*/
		[Embed(source="style.swf", symbol="CheckBox_up")]
		public static var CheckBoxUp:Class;
		[Embed(source="style.swf", symbol="CheckBox_over")]
		public static var CheckBoxOver:Class;
		[Embed(source="style.swf", symbol="CheckBox_down")]
		public static var CheckBoxDown:Class;
		[Embed(source="style.swf", symbol="CheckBox_disabled")]
		public static var CheckBoxDisabled:Class;
		[Embed(source="style.swf", symbol="CheckBox_selectedUp")]
		public static var CheckBoxSelectedUp:Class;
		[Embed(source="style.swf", symbol="CheckBox_selectedOver")]
		public static var CheckBoxSelectedOver:Class;
		[Embed(source="style.swf", symbol="CheckBox_selectedDown")]
		public static var CheckBoxSelectedDown:Class;
		[Embed(source="style.swf", symbol="CheckBox_selectedDisabled")]
		public static var CheckBoxSelectedDisabled:Class;
		/*RadioButton*/
		[Embed(source="style.swf", symbol="RadioButton_upIcon")]
		public static var RadioButtonUpSkin:Class;
		[Embed(source="style.swf", symbol="RadioButton_overIcon")]
		public static var RadioButtonOverSkin:Class;
		[Embed(source="style.swf", symbol="RadioButton_downIcon")]
		public static var RadioButtonDownSkin:Class;
		[Embed(source="style.swf", symbol="RadioButton_disabledIcon")]
		public static var RadioButtonDisabledSkin:Class;
		[Embed(source="style.swf", symbol="RadioButtonSelected_upIcon")]
		public static var RadioButtonSelectedUpSkin:Class;
		[Embed(source="style.swf", symbol="RadioButtonSelected_overIcon")]
		public static var RadioButtonSelectedOverSkin:Class;
		[Embed(source="style.swf", symbol="RadioButtonSelected_downIcon")]
		public static var RadioButtonSelectedDownSkin:Class;
		[Embed(source="style.swf", symbol="RadioButtonSelected_disabledIcon")]
		public static var RadioButtonSelectedDisabledSkin:Class;
		/*Slider*/
		[Embed(source="style.swf", symbol="SliderThumb_up")]
		public static var SliderThumbUpSkin:Class;
		[Embed(source="style.swf", symbol="SliderThumb_over")]
		public static var SliderThumbOverSkin:Class;
		[Embed(source="style.swf", symbol="SliderThumb_down")]
		public static var SliderThumbDownSkin:Class;
		[Embed(source="style.swf", symbol="SliderTrack")]
		public static var SliderTrack:Class;
		/*ScrollBar*/
		[Embed(source="style.swf", symbol="ScrollArrowUp_upSkin")]
		public static var ScrollUpArrowUpSkin:Class;
		[Embed(source="style.swf", symbol="ScrollArrowUp_overSkin")]
		public static var ScrollUpArrowOverSkin:Class;
		[Embed(source="style.swf", symbol="ScrollArrowUp_downSkin")]
		public static var ScrollUpArrowDownSkin:Class;
		[Embed(source="style.swf", symbol="ScrollArrowUp_disabledSkin")]
		public static var ScrollUpArrowDisabledSkin:Class;
		
		[Embed(source="style.swf", symbol="ScrollArrowDown_upSkin")]
		public static var ScrollDownArrowUpSkin:Class;
		[Embed(source="style.swf", symbol="ScrollArrowDown_overSkin")]
		public static var ScrollDownArrowOverSkin:Class;
		[Embed(source="style.swf", symbol="ScrollArrowDown_downSkin")]
		public static var ScrollDownArrowDownSkin:Class;
		[Embed(source="style.swf", symbol="ScrollArrowDown_disabledSkin")]
		public static var ScrollDownArrowDisabledSkin:Class;
		
		[Embed(source="style.swf", symbol="ScrollTrack_Skin")]
		public static var ScrollTrackSkin:Class;
		[Embed(source="style.swf", symbol="ScrollThumb_upSkin")]
		public static var ScrollThumbUpSkin:Class;
		[Embed(source="style.swf", symbol="ScrollThumb_overSkin")]
		public static var ScrollThumbOverSkin:Class;
		[Embed(source="style.swf", symbol="ScrollThumb_downSkin")]
		public static var ScrollThumbDownSkin:Class;
		/*ComboBox*/
		[Embed(source="style.swf", symbol="ComboBoxArrow_upSkin")]
		public static var ComboBoxUpSkin:Class;
		[Embed(source="style.swf", symbol="ComboBoxArrow_overSkin")]
		public static var ComboBoxOverSkin:Class;
		[Embed(source="style.swf", symbol="ComboBoxArrow_downSkin")]
		public static var ComboBoxDownSkin:Class;
		[Embed(source="style.swf", symbol="ComboBoxArrow_disabledSkin")]
		public static var ComboBoxDisabledSkin:Class;
		/*TextArea*/
		[Embed(source="style.swf", symbol="TextAreaBackSkin")]
		public static var TextAreaBackSkin:Class;
		/*TextInput*/
		[Embed(source="style.swf", symbol="TextInputBackSin")]
		public static var TextInputBackSkin:Class;
		/*Window*/
		[Embed(source="style.swf", symbol="Window_backSkin")]
		public static var WindowBackSkin:Class;
		[Embed(source="style.swf", symbol="Window_titleSkin")]
		public static var WindowTitleSkin:Class;
		[Embed(source="style.swf", symbol="Window_closeButtonUpSkin")]
		public static var CloseBtnUp:Class;
		[Embed(source="style.swf", symbol="Window_closeButtonOverSkin")]
		public static var CloseBtnOver:Class;
		[Embed(source="style.swf", symbol="Window_closeButtonDownSkin")]
		public static var CloseBtnDown:Class;
		/*NumericStepper*/
		[Embed(source="style.swf", symbol="NumericStepperUpArrow_upSkin")]
		public static var NumericStepperUpArrowUpSkin:Class;
		[Embed(source="style.swf", symbol="NumericStepperUpArrow_overSkin")]
		public static var NumericStepperUpArrowOverSkin:Class;
		[Embed(source="style.swf", symbol="NumericStepperUpArrow_downSkin")]
		public static var NumericStepperUpArrowDownSkin:Class;
		[Embed(source="style.swf", symbol="NumericStepperUpArrow_disabledSkin")]
		public static var NumericStepperUpArrowDisabledSkin:Class;
		[Embed(source="style.swf", symbol="NumericStepperDownArrow_upSkin")]
		public static var NumericStepperDownArrowUpSkin:Class;
		[Embed(source="style.swf", symbol="NumericStepperDownArrow_overSkin")]
		public static var NumericStepperDownArrowOverSkin:Class;
		[Embed(source="style.swf", symbol="NumericStepperDownArrow_downSkin")]
		public static var NumericStepperDownArrowDownSkin:Class;
		[Embed(source="style.swf", symbol="NumericStepperDownArrow_disabledSkin")]
		public static var NumericStepperDownArrowDisabledSkin:Class;
		[Embed(source="style.swf", symbol="NumericStepperInputSkin")]
		public static var NumericStepperInputSkin:Class;
		/*ScrollPane*/
		[Embed(source="style.swf", symbol="ScrollPaneBackSkin")]
		public static var ScrollPaneBackSkin:Class;
		/*Tree*/
		[Embed(source="style.swf", symbol="Tree_folderOpenIcon")]
		public static var TreeFolderOpenIcon:Class;
		[Embed(source="style.swf", symbol="Tree_folderClosedIcon")]
		public static var TreeFolderClosedIcon:Class;
		/*ToolTip*/
		[Embed(source="style.swf", symbol="ToolTip_borderSkin")]
		public static var TooTipBackSkin:Class;
		
		
		private static var _instance:StyleAssets=new StyleAssets();
		/**
		 *获取类 
		 * @param name
		 * @return 
		 * 
		 */
		public static function getClass(name:String):Class
		{
			var className:String=describeType(_instance).@name.toXMLString();
			var fullName:String=className+"_"+name;
			
			var classDef:Object=getDefinitionByName(fullName);
			
				
			
			return  classDef as Class;
		}
		/**
		 *获取皮肤实例 
		 * @param name
		 * @return 
		 * 
		 */
		public static function getDisplayObject(name:String):DisplayObject
		{
			var Res:Class=getClass(name);
			return new Res() as DisplayObject;
		}
	}
}