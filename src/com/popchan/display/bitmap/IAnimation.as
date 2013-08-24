package com.popchan.display.bitmap
{
	/**
	 *动画播放接口
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012,chenbo,All rights reserved
	 *
	 */
	public interface IAnimation
	{
		function play():void;
		function stop():void;
		function gotoAndPlay(frame:Object):void;
		function gotoAndStop(frame:Object):void;
		function nextFrame():void;
		function prevFrame():void;
		function get totalFrames():int;
		function get currentFrame():int;
		function get isPlaying():Boolean;
		/**
		 *播放模式 向前or向后 PlayMode
		 * @return 
		 * 
		 */
		function get playMode():int;
		function get frameRate():int;
		function set frameRate(value:int):void;
	}
}