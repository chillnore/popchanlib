package com.popchan.display.ui
{
	/**
	 *
	 *Version 1.0
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012-2013,chenbo,All rights reserved
	 *
	 */
	public interface ITreeCell
	{
		function get selected():Boolean;
		function set selected(value:Boolean):void;
		function get data():Object;
		function set data(value:Object):void;
	}
}