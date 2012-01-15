//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package org.robotlegs.base
{
	import flash.events.IEventDispatcher;
	import org.robotlegs.core.IEventMap;
	import robotlegs.bender.extensions.localEventMap.api.IEventMap;
	import robotlegs.bender.extensions.localEventMap.impl.EventMap;

	public class EventMap implements org.robotlegs.core.IEventMap
	{

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private var eventMap:robotlegs.bender.extensions.localEventMap.api.IEventMap;

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/

		public function EventMap(dispatcher:IEventDispatcher)
		{
			this.eventMap = new robotlegs.bender.extensions.localEventMap.impl.EventMap(dispatcher);
		}

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		public function mapListener(
			dispatcher:IEventDispatcher,
			type:String,
			listener:Function,
			eventClass:Class = null,
			useCapture:Boolean = false,
			priority:int = 0,
			useWeakReference:Boolean = true):void
		{
			eventMap.mapListener(dispatcher, type, listener, eventClass, useCapture, priority, useWeakReference);
		}

		public function unmapListener(
			dispatcher:IEventDispatcher,
			type:String,
			listener:Function,
			eventClass:Class = null,
			useCapture:Boolean = false):void
		{
			eventMap.unmapListener(dispatcher, type, listener, eventClass, useCapture);
		}

		public function unmapListeners():void
		{
			eventMap.unmapListeners();
		}
	}
}
