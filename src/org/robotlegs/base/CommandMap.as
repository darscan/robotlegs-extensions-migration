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
	import org.robotlegs.v2.extensions.commandMap.api.ICommandMap;

	public class CommandMap implements org.robotlegs.core.ICommandMap
	{
		protected var detainedCommands:Dictionary;

		private var commandMap:org.robotlegs.v2.extensions.commandMap.api.ICommandMap;

		public function CommandMap(commandMap:org.robotlegs.v2.extensions.commandMap.api.ICommandMap)
		{
			this.commandMap = commandMap;
		}

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
			// TODO: rl2 commandMap support
			throw new Error("not implemented");
		}

		public function mapEvent(eventType:String, commandClass:Class, eventClass:Class = null, oneshot:Boolean = false):void
		{
			commandMap.map(commandClass).toEvent(eventType, eventClass, oneshot);
		}

		public function unmapEvent(eventType:String, commandClass:Class, eventClass:Class = null):void
		{
			commandMap.unmap(commandClass).fromEvent(eventType, eventClass);
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
			return commandMap.hasMapping(commandClass);
		}
	}
}
