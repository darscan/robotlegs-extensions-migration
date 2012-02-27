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
	import org.swiftsuspenders.Injector;
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;

	public class CommandMap implements ICommandMap
	{

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private const _detainedCommands:Dictionary = new Dictionary();

		private var _injector:Injector;

		private var _eventCommandMap:IEventCommandMap;

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/

		public function CommandMap(eventCommandMap:IEventCommandMap, injector:Injector)
		{
			// todo: explore Swiftsuspenders bug where:
			//   CommandMap(injector:Injector, eventCommandMap:IEventCommandMap)
			// injects null injector
			_injector = injector.createChildInjector();
			_eventCommandMap = eventCommandMap;
		}

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		public function detain(command:Object):void
		{
			_detainedCommands[command] = true;
		}

		public function release(command:Object):void
		{
			delete _detainedCommands[command];
		}

		public function execute(commandClass:Class, payload:Object = null, payloadClass:Class = null, named:String = ""):void
		{
			if (payload && payloadClass)
			{
				_injector.map(payloadClass, named).toValue(payload);
			}

			_injector.getInstance(commandClass).execute();

			if (payload && payloadClass)
			{
				_injector.unmap(payloadClass, named);
			}
		}

		public function mapEvent(eventType:String, commandClass:Class, eventClass:Class = null, oneshot:Boolean = false):void
		{
			_eventCommandMap.map(eventType, eventClass, oneshot).toCommand(commandClass)
		}

		public function unmapEvent(eventType:String, commandClass:Class, eventClass:Class = null):void
		{
			_eventCommandMap.unmap(eventType, eventClass).fromCommand(commandClass);
		}

		public function unmapEvents():void
		{
			// TODO: rl2 commandMap support
			throw new Error("not implemented");
		}

		public function hasEventCommand(eventType:String, commandClass:Class, eventClass:Class = null):Boolean
		{
			return _eventCommandMap.getMapping(eventType, eventClass).forCommand(commandClass) != null;
		}
	}
}
