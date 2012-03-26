//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package org.robotlegs.mvcs
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import org.robotlegs.base.ContextBase;
	import org.robotlegs.base.ContextError;
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.core.ICommandMap;
	import org.robotlegs.core.IContext;
	import org.robotlegs.core.IInjector;
	import org.robotlegs.core.IMediatorMap;
	import org.robotlegs.core.IReflector;
	import org.robotlegs.core.IViewMap;
	import robotlegs.bender.bundles.mvcs.MVCSBundle;
	import robotlegs.bender.extensions.migration.MigrationExtension;
	import robotlegs.bender.framework.context.api.IContext;
	import robotlegs.bender.framework.context.impl.Context;

	[Event(name="shutdownComplete", type="org.robotlegs.base.ContextEvent")]
	[Event(name="startupComplete", type="org.robotlegs.base.ContextEvent")]
	public class Context extends ContextBase implements org.robotlegs.core.IContext
	{
		protected var _autoStartup:Boolean;
		protected var _contextView:DisplayObjectContainer;

		private var _rl2Context:robotlegs.bender.framework.context.api.IContext;

		public function Context(contextView:DisplayObjectContainer = null, autoStartup:Boolean = true)
		{
			super(new EventDispatcher(this));

			_contextView = contextView;
			_autoStartup = autoStartup;

			if (_contextView)
			{
				mapInjections();
				checkAutoStartup();
			}
		}

		public function startup():void
		{
			dispatchEvent(new ContextEvent(ContextEvent.STARTUP_COMPLETE));
		}

		public function shutdown():void
		{
			dispatchEvent(new ContextEvent(ContextEvent.SHUTDOWN_COMPLETE));
		}

		/**
		 * The <code>DisplayObjectContainer</code> that scopes this <code>IContext</code>
		 */
		public function get contextView():DisplayObjectContainer
		{
			return _contextView;
		}

		/**
		 * @private
		 */
		public function set contextView(value:DisplayObjectContainer):void
		{
			if (value == _contextView)
				return;

			if (_contextView)
				throw new ContextError(ContextError.E_CONTEXT_VIEW_OVR);

			_contextView = value;
			mapInjections();
			checkAutoStartup();
		}

		//---------------------------------------------------------------------
		//  Protected, Lazy Getters and Setters
		//---------------------------------------------------------------------

		/**
		 * The <code>IInjector</code> for this <code>IContext</code>
		 */
		protected function get injector():IInjector
		{
			return _rl2Context.injector.getInstance(IInjector);
		}

		/**
		 * @private
		 */
		protected function set injector(value:IInjector):void
		{
			_rl2Context.injector.map(IInjector).toValue(value);
		}

		/**
		 * The <code>IReflector</code> for this <code>IContext</code>
		 */
		protected function get reflector():IReflector
		{
			return _rl2Context.injector.getInstance(IReflector);
		}

		/**
		 * @private
		 */
		protected function set reflector(value:IReflector):void
		{
			_rl2Context.injector.map(IReflector).toValue(value);
		}

		/**
		 * The <code>ICommandMap</code> for this <code>IContext</code>
		 */
		protected function get commandMap():ICommandMap
		{
			return _rl2Context.injector.getInstance(ICommandMap);
		}

		/**
		 * @private
		 */
		protected function set commandMap(value:ICommandMap):void
		{
			_rl2Context.injector.map(ICommandMap).toValue(value);
		}

		/**
		 * The <code>IMediatorMap</code> for this <code>IContext</code>
		 */
		protected function get mediatorMap():IMediatorMap
		{
			return _rl2Context.injector.getInstance(IMediatorMap);
		}

		/**
		 * @private
		 */
		protected function set mediatorMap(value:IMediatorMap):void
		{
			_rl2Context.injector.map(IMediatorMap).toValue(value);
		}

		/**
		 * The <code>IViewMap</code> for this <code>IContext</code>
		 */
		protected function get viewMap():IViewMap
		{
			return _rl2Context.injector.getInstance(IViewMap);
		}

		/**
		 * @private
		 */
		protected function set viewMap(value:IViewMap):void
		{
			_rl2Context.injector.map(IViewMap).toValue(value);
		}

		private function mapInjections():void
		{
			_rl2Context = new robotlegs.bender.framework.context.impl.Context()
				.extend(MVCSBundle, MigrationExtension)
				.configure(_contextView);
		}

		protected function checkAutoStartup():void
		{
			if (_autoStartup && contextView)
			{
				contextView.stage ? startup() : contextView.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true);
			}
		}
		protected function onAddedToStage(e:Event):void
		{
			contextView.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			startup();
		}
	}
}
