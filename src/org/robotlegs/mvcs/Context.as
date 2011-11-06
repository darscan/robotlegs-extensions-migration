//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package org.robotlegs.mvcs
{
	import flash.events.IEventDispatcher;
	import org.robotlegs.base.ContextBase;
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.core.IContext;

	[Event(name="shutdownComplete", type="org.robotlegs.base.ContextEvent")]
	[Event(name="startupComplete", type="org.robotlegs.base.ContextEvent")]
	public class Context extends ContextBase implements IContext
	{

		public function Context(dispatcher:IEventDispatcher)
		{
			super(dispatcher);
		}

		public function startup():void
		{
			dispatchEvent(new ContextEvent(ContextEvent.STARTUP_COMPLETE));
		}

		public function shutdown():void
		{
			dispatchEvent(new ContextEvent(ContextEvent.SHUTDOWN_COMPLETE));
		}
	}
}
