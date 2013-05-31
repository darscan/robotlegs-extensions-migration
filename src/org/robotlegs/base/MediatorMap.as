//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package org.robotlegs.base
{
	import flash.display.DisplayObjectContainer;
	import org.robotlegs.core.IMediator;
	import org.swiftsuspenders.Injector;

	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.extensions.mediatorMap.dsl.IMediatorConfigurator;

	public class MediatorMap implements org.robotlegs.core.IMediatorMap
	{

		/*============================================================================*/
		/* Public Properties                                                          */
		/*============================================================================*/

		private var _contextView:DisplayObjectContainer;

		public function get contextView():DisplayObjectContainer
		{
			return _contextView;
		}

		public function set contextView(value:DisplayObjectContainer):void
		{
			throw new Error("contextView can not be set");
		}

		public function get enabled():Boolean
		{
			return true;
		}

		public function set enabled(value:Boolean):void
		{
			throw new Error("not implemented");
		}

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private var _mediatorMap:IMediatorMap;

		private var _injector:Injector;

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/

		public function MediatorMap(
			mediatorMap:IMediatorMap,
			contextView:ContextView,
			injector:Injector)
		{
			_mediatorMap = mediatorMap;
			_contextView = contextView.view;
			_injector = injector;
		}

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		public function mapView(
			viewClassOrName:*,
			mediatorClass:Class,
			injectViewAs:* = null,
			autoCreate:Boolean = true,
			autoRemove:Boolean = true):void
		{
			const mapping:IMediatorConfigurator =
				_mediatorMap.map(viewClassOrName).toMediator(mediatorClass);
			var viewInjectTypes:Array = [];
			if (injectViewAs)
			{
				if (injectViewAs is Array)
				{
					viewInjectTypes = (injectViewAs as Array).concat();
				}
				else
				{
					viewInjectTypes = [injectViewAs];
				}
			}
			const guardAndHook:MediatorCreationGuardAndHook =
				new MediatorCreationGuardAndHook(viewClassOrName, mediatorClass, viewInjectTypes, _injector);
			mapping.withGuards(guardAndHook);
			mapping.withHooks(guardAndHook);
		}

		public function unmapView(viewClassOrName:*):void
		{
			_mediatorMap.unmap(viewClassOrName).fromAll();
		}

		public function createMediator(viewComponent:Object):IMediator
		{
			throw new Error("not implemented");
		}

		public function registerMediator(viewComponent:Object, mediator:IMediator):void
		{
			throw new Error("not implemented");
		}

		public function removeMediator(mediator:IMediator):IMediator
		{
			throw new Error("not implemented");
		}

		public function removeMediatorByView(viewComponent:Object):IMediator
		{
			throw new Error("not implemented");
		}

		public function retrieveMediator(viewComponent:Object):IMediator
		{
			throw new Error("not implemented");
		}

		public function hasMapping(viewClassOrName:*):Boolean
		{
			throw new Error("not implemented");
		}

		public function hasMediator(mediator:IMediator):Boolean
		{
			throw new Error("not implemented");
		}

		public function hasMediatorForView(viewComponent:Object):Boolean
		{
			throw new Error("not implemented");
		}

	}
}

import flash.display.DisplayObject;
import org.robotlegs.mvcs.Mediator;
import org.swiftsuspenders.Injector;

class MediatorCreationGuardAndHook
{

	/*============================================================================*/
	/* Private Properties                                                         */
	/*============================================================================*/

	private var _viewType:Class;

	private var _mediatorType:Class;

	private var _viewInjectTypes:Array;

	private var _injector:Injector;

	private var _view:DisplayObject;

	/*============================================================================*/
	/* Constructor                                                                */
	/*============================================================================*/

	public function MediatorCreationGuardAndHook(viewType:Class, mediatorType:Class,
		viewInjectTypes:Array, injector:Injector)
	{
		_viewType = viewType;
		_mediatorType = mediatorType;
		_viewInjectTypes = viewInjectTypes;
		_injector = injector;
	}

	/*============================================================================*/
	/* Public Functions                                                           */
	/*============================================================================*/

	public function approve():Boolean
	{
		const view:DisplayObject = _injector.getInstance(_viewType);
		for (var i:int = _viewInjectTypes.length; i--; )
		{
			const type:Class = _viewInjectTypes[i];
			_injector.map(type).toValue(view);
		}
		_view = view;
		return true;
	}

	public function hook():void
	{
		var mediator:Mediator = _injector.getInstance(_mediatorType);
		for (var i:int = _viewInjectTypes.length; i--; )
		{
			const type:Class = _viewInjectTypes[i];
			_injector.unmap(type);
		}
		mediator.setViewComponent(_view);
		_view = null;
		mediator.preRegister();
	}
}
