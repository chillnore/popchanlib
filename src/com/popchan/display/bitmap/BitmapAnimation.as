package com.popchan.display.bitmap
{
	import com.popchan.time.BasicTimer;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.setTimeout;
	/**
	 *位图动画 
	 *Feedback zingblue@163.com,zingblue@gmail.com
	 *Copyright 2012,chenbo,All rights reserved
	 *
	 */
	public class BitmapAnimation extends Sprite implements IAnimation
	{
		/**帧信息*/
		protected var _frames:Vector.<BitmapFrameInfo>;
		/**播放序列*/
		protected var _sequences:Object;
		protected var _currentSequence:Sequence;
		/**播放速率*/
		protected var _frameRate:int;
		/**是否正在播放*/
		protected var _isPlaying:Boolean;
		protected var _currentFrame:int;
		protected var _startFrame:int;
		protected var _endFrame:int;
		protected var _totalFrames:int;
		/**循环记数*/
		protected var _loopCount:int;
		/**循环次数*/
		protected var _loops:int;
		protected var _timer:BasicTimer;
		protected var _bitmap:Bitmap;
		/**脚本列表*/ 
		protected var _scripts:Array=[];
		/**
		 * 
		 * @param frames 帧信息
		 * @param frameRate播放速率
		 * 
		 */
		public function BitmapAnimation(frames:Vector.<BitmapFrameInfo>=null,frameRate:int=30)
		{
			_sequences={};
			
			_bitmap=new Bitmap();
			addChild(_bitmap);
			
			_timer=new BasicTimer(int(1000/frameRate));
			
			this.frames=frames;
			this._frameRate=frameRate;
			
		}
		/**
		 *设置帧信息 
		 * @param value
		 * 
		 */
		public function set frames(value:Vector.<BitmapFrameInfo>):void
		{
			if(value!=null)
			{
				_frames=value;
				addSequence("all",1,_frames.length);
				currentSequence="all";
				_totalFrames=_frames.length;
			}
		}
		
		/**
		 *开始播放 
		 * 
		 */
		public function play():void
		{
			if(!_isPlaying)
			{
				_isPlaying=true;
				_timer.addEventListener(TimerEvent.TIMER,onTimer);
				_timer.start();
			}
		}
		
		/**
		 *停止播放 
		 * 
		 */
		public function stop():void
		{
			if(_isPlaying)
			{
				_isPlaying=false;
				_timer.stop();
				_timer.removeEventListener(TimerEvent.TIMER,onTimer);
				_loopCount=0;
			}
		}
		
		/**
		 *跳转到帧或者标签播放 
		 * @param frame
		 * 
		 */
		public function gotoAndPlay(frame:Object):void
		{
			goto(frame);
			play();	
		}
		
		/**
		 *跳转到帧或标签停止播放 
		 * @param frame
		 * 
		 */
		public function gotoAndStop(frame:Object):void
		{
			goto(frame);
			stop();
		}
		/**
		 *跳转到帧
		 * @param frame 标签或者帧
		 * 
		 */
		protected function goto(frame:Object):void
		{
			if(!isNaN(Number(frame)))
			{
				var f:int=parseInt(String(frame));
				if(f<_startFrame)
					f=_startFrame;
				else if(f>_endFrame)
					f=_endFrame;
				_currentFrame=f;
			}else
			{
				_currentFrame=getFrameByLabel(String(frame));
			}
			animate();
		}
		/**
		 *设置bitmapdata 
		 * 
		 */
		protected function animate():void
		{
			_bitmap.bitmapData=_frames[_currentFrame-1].bitmapData;
			_bitmap.x=-_frames[currentFrame-1].offsetX;
			_bitmap.y=-_frames[currentFrame-1].offsetY;
			//执行脚本
			if(_scripts[currentFrame-1]!=undefined&&_scripts[currentFrame-1]!=null)
			{
				_scripts[currentFrame-1]();
			}
		}
		/**
		 *播放头下移一帧 
		 * 
		 */
		public function nextFrame():void
		{
			stop();
			goto(_currentFrame+1);	
		}
		
		/**
		 *播放头后退一帧 
		 * 
		 */
		public function prevFrame():void
		{
			stop();
			goto(_currentFrame-1);
		}
		/**
		 *timer处理 
		 * @param e
		 * 
		 */
		public function onTimer(e:TimerEvent):void
		{
			if(_currentSequence.playMode==PlayMode.FORWARD)
			{
				_currentFrame++;
				if(_currentFrame>_endFrame)
				{
					_loopCount++;
					if(_loopCount==_loops)
					{
						dispatchEvent(new Event(Event.COMPLETE));
						_currentFrame--;
						stop();
						setNextSequence();
						return;	
					}
					_currentFrame=_startFrame;
				}
			}else if(_currentSequence.playMode==PlayMode.BACKWARD)
			{
				_currentFrame--;
				if(_currentFrame<_startFrame)
				{
					_loopCount++;
					
					if(_loopCount==_loops)
					{
						dispatchEvent(new Event(Event.COMPLETE));
						_currentFrame++;
						stop();
						setNextSequence();
						return;
					}
					_currentFrame=_endFrame;
					
				}
			}
			animate();	
		}
		/**
		 *当前序列播放完成后检测是否需要播放下一个序列 
		 * 
		 */
		protected function setNextSequence():void
		{
			if (_currentSequence.nextSequence)
			{
				if (_currentSequence.nextSequenceDelay<=0)
				{
					currentSequence = _currentSequence.nextSequence;
					play();
				}
				else
				{
					setTimeout(
						function():void 
						{
							currentSequence = _currentSequence.nextSequence;
							play();
						}, _currentSequence.nextSequenceDelay);
				}
			}
		}
		/**
		 *总帧数 
		 * @return 
		 * 
		 */
		public function get totalFrames():int
		{
			return _totalFrames;
		}
		
		/**
		 *当前帧 
		 * @return 
		 * 
		 */
		public function get currentFrame():int
		{
			return _currentFrame;
		}
		
		/**
		 *是否正在播放动画 
		 * @return 
		 * 
		 */
		public function get isPlaying():Boolean
		{
			return _isPlaying;
		}
		
		/**
		 *播放模式 
		 * @return 
		 * 
		 */
		public function get playMode():int
		{
			return _currentSequence.playMode;
		}
		
		/**
		 *播放帧频 
		 * @return 
		 * 
		 */
		public function get frameRate():int
		{
			return _frameRate;
		}
		
		public function set frameRate(value:int):void
		{
			if(value>0)
			{
				_frameRate=value;
				_timer.delay=int(1000/value);
			}
		}
		public function set loops(value:int):void
		{
			_loops=value;
		}
		/**
		 *当前动画序列的循环次数0表示无限循环 
		 * @return 
		 * 
		 */
		public function get loops():int
		{
			return _loops;
		}
		/**
		 *为指定帧添加脚本 
		 * @param frame
		 * @param script
		 * @param arg
		 * 
		 */
		public function addFrameScript(frame:Object,script:Function):void
		{
			var f:int;
			if(!isNaN(Number(frame)))
			{
				f=parseInt(String(frame));
			}else
			{
				f=getFrameByLabel(String(frame));
			}
			_scripts[f-1]=script;	
		}
		/**
		 *为每一帧添加脚本 
		 * @param script
		 * 
		 */
		public function addEachFrameScript(script:Function):void
		{
			for(var i:int=0;i<_totalFrames;i++)
			{
				_scripts[i]=script;
			}
		}
		/**
		 *通过名称获取帧标签 
		 * @param label
		 * @return 
		 * 
		 */
		private function getFrameByLabel(label:String):int
		{
			var i:int=0;
			for each(var frameLabel:BitmapFrameInfo in _frames)
			{
				i++;
				if(frameLabel.label==label)
					return i;
			}
			throw new Error("找不到名称为:"+label+"的标签");
			return -1;
		}
		/**
		 *添加一个动画播放序列 
		 * @param name
		 * @param startFrame 起始帧
		 * @param endFrame	 结束帧
		 * @param loops		 循环次数 =0无限循环
		 * @param playMode	 播放模式，默认顺序播放
		 * @param nextSequence	播放完成后进行下一个动画序列
		 * @param nextSequenceDelay	延迟多少时间播放下一个动画序列
		 * 
		 */
		public function addSequence(name:String,startFrame:int,endFrame:int,loops:int=0,playMode:int=0,nextSequence:String=null,nextSequenceDelay:int=0):void
		{
			_sequences[name]=new Sequence(name,startFrame,endFrame,loops,playMode,nextSequence,nextSequenceDelay);
		}
		/**
		 *删除动画播放序列 
		 * @param name
		 * 
		 */
		public function removeSequence(name:String):void
		{
			if(_sequences[name]!=null)
				delete _sequences[name];
		}
		
		/**
		 * 当前使用的动画序列
		 * @return 
		 * 
		 */
		public function get currentSequence():String
		{
			if(_currentSequence)return _currentSequence.name;
			return null;
		}
		
		/**
		 * 设置当前播放的动画序列名称
		 * @private
		 */
		public function set currentSequence(value:String):void
		{
			_currentSequence=_sequences[value];
			if(_currentSequence)
			{
				_currentFrame=_startFrame=_currentSequence.startFrame;
				_endFrame=_currentSequence.endFrame;
				_loopCount=0;
				_loops=_currentSequence.loops;
				if(playMode==PlayMode.FORWARD)
					gotoAndPlay(_currentFrame);
				else
					gotoAndPlay(_endFrame);
			}else
			{
				throw new Error(value+"序列不存在，请先调用addSequence()");
			}
		}
		/**
		 *平滑 
		 */
		public function get smothing():Boolean
		{
			return _bitmap.smoothing;
		}
		/**
		 * @private
		 */
		public function set smothing(value:Boolean):void
		{
			_bitmap.smoothing=value;
		}
		/**
		 *释放资源 
		 * 
		 */
		public function dispose():void
		{
			stop();
			_scripts=null;
		}
		
	}
}
/**
 *播放序列 
 * 
 */
class Sequence
{
	public var name:String;
	public var startFrame:int;
	public var endFrame:int;
	public var loops:int;
	public var playMode:int;
	public var nextSequence:String;
	public var nextSequenceDelay:int;
	
	function Sequence(name:String,startFrame:int,endFrame:int,loops:int=0,playMode:int=0,nextSequence:String=null,nextSequenceDelay:int=0)
	{
		this.name=name;
		this.startFrame=startFrame;
		this.endFrame=endFrame;
		this.loops=loops;
		this.playMode=playMode;
		this.nextSequence=nextSequence;
		this.nextSequenceDelay=nextSequenceDelay;
	}
}