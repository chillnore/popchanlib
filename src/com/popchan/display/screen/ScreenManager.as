package com.popchan.display.screen
{
	
	
	import flash.display.DisplayObjectContainer;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	/**
	 *窗口管理类 
	 * @author bo
	 * 
	 */
	public class ScreenManager
	{
		private static var dialogs:Dictionary=new Dictionary(false);
		/**
		 *当前打开的窗口 
		 */		
		private static var currentOpenDialog:Array=[];
		
		/**
		 *显示屏幕 
		 * @param parent 父容器
		 * @param className 类
		 * @param data 数据
		 * @param returnFunction 回调
		 * @param x	
		 * @param y
		 * @param modal 是否模态
		 * @return 
		 * 
		 */
		public static function show(parent:Layer,
									className:Class, data:Object=null,
									returnFunction:Function=null,
									x:Number=NaN,y:Number=NaN,
									modal:Boolean=false):BaseScreen
		{
			var dialog:BaseScreen;
			if(dialogs[className]!=null)
			{
				dialog=dialogs[className];
			}else
			{
				dialog=new className();
				dialog.parentContainer=parent;
				if(modal)parent.showMask();
				dialogs[className]=dialog;
			}
			
			for each(var ibox:BaseScreen in currentOpenDialog)
			{
				if(ibox==dialog)
				{
					parent.addChild(ibox);
					dialog.parentContainer=parent;
					if(modal)parent.showMask();
					return dialog;
				}
			}
			currentOpenDialog.push(dialog);
			

			dialog.x=dialog.parentContainer.width/2-dialog.width/2;
			dialog.y=dialog.parentContainer.height/2-dialog.height/2;
			if(!isNaN(x))
				dialog.x=x;
			if(!isNaN(y))
				dialog.y=y;
			
			dialog.data=data;
			dialog.callBack=returnFunction;
			dialog.parentContainer.addChild(dialog);
			if(modal)dialog.parentContainer.showMask();
		
		
			return dialog;
			
		}
		/**
		 *移除窗口 
		 * @param dialog
		 * @param className
		 * 
		 */
		public static function removeDialog(dialog:BaseScreen,className:Class=null):void
		{
			if(!className)
			{
				var typeName:String = getQualifiedClassName(dialog);
				className=getDefinitionByName(typeName) as Class;			
			}	
			dialog.parentContainer.removeChild(dialog);
			dialog.parentContainer.hideMask();
			
			var i:int;
			for(i=currentOpenDialog.length-1;i>=0;i--)
			{
				if(currentOpenDialog[i]==dialog)
				{
					currentOpenDialog.splice(i,1);
					break;
				}
			}
		}
		/**
		 *关闭所有窗体 
		 * 
		 */
		public static function removeAllDialog():void
		{
			
			while(currentOpenDialog.length>0)
			{
				(currentOpenDialog.shift() as BaseScreen).close();	
			}
		}
		/**
		 *获取窗口 
		 * @param className
		 * @return 
		 * 
		 */
		public static function getDialogByClass(className:Class):BaseScreen
		{
			
			return dialogs[className];
		}
		/**
		 *获取打开的窗口 
		 * @param className
		 * @return 
		 * 
		 */
		public static function getOpenDialog(className:Class):BaseScreen
		{
			
			var i:int;
			for(i=currentOpenDialog.length-1;i>=0;i--)
			{
				if(currentOpenDialog[i]==dialogs[className])
				{
					return dialogs[className];
				}
			}
			return null;
		}
		/**
		 *获去打开窗口的个数 
		 * @return 
		 * 
		 */
		public static function getOpenDialogNum():int
		{
			return currentOpenDialog.length;
		}
	}
}