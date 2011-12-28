//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package org.robotlegs.base
{
	import flash.utils.Dictionary;
	import org.robotlegs.core.ICommandMap;
	import org.robotlegs.v2.extensions.eventCommandMap.api.IEventCommandMap;
	import org.swiftsuspenders.Injector;

	public class CommandMap implements ICommandMap
	{

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private const detainedCommands:Dictionary = new Dictionary();

		private var injector:Injector;

		private var eventCommandMap:IEventCommandMap;

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/

		public function CommandMap(injector:Injector, eventCommandMap:IEventCommandMap)
		{
			this.injector = injector.createChildInjector();
			this.eventCommandMap = eventCommandMap;
		}

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		public function detain(command:Object):void
		{
			detainedCommands[command] = true;
		}

		public function release(command:Object):void
		{
			delete detainedCommands[command];
		}

		public function execute(commandClass:Class, payload:Object = null, payloadClass:Class = null, named:String = ""):void
		{
			if (payload && payloadClass)
			{
				injector.map(payloadClass, named).toValue(payload);
			}

			injector.getInstance(commandClass).execute();

			if (payload && payloadClass)
			{
				injector.unmap(payloadClass, named);
			}
		}

		public function mapEvent(eventType:String, commandClass:Class, eventClass:Class = null, oneshot:Boolean = false):void
		{
			eventCommandMap.map(eventType, eventClass, oneshot).toCommand(commandClass)
		}

		public function unmapEvent(eventType:String, commandClass:Class, eventClass:Class = null):void
		{
			eventCommandMap.unmap(eventType, eventClass).fromCommand(commandClass);
		}

		public function unmapEvents():void
		{
			// TODO: rl2 commandMap support
			throw new Error("not implemented");
		}

		public function hasEventCommand(eventType:String, commandClass:Class, eventClass:Class = null):Boolean
		{
			// TODO: rl2 commandMap support
			throw new Error("not implemented");
			return eventCommandMap.hasMapping(commandClass);
		}
	}
}
