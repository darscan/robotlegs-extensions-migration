//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package org.robotlegs.base
{
	import flash.display.DisplayObjectContainer;

	import org.hamcrest.object.instanceOf;
	import org.robotlegs.core.IMediator;
	import org.swiftsuspenders.Injector;

	import robotlegs.bender.extensions.mediatorMap.api.IMediatorFactory;

	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.extensions.mediatorMap.api.MediatorFactoryEvent;
	import robotlegs.bender.extensions.mediatorMap.dsl.IMediatorMappingConfig;

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
			// TODO: think about
			return true;
		}

		public function set enabled(value:Boolean):void
		{
			// TODO: think about
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
			contextView:DisplayObjectContainer,
			injector:Injector,
			mediatorFactory : IMediatorFactory)
		{
			_mediatorMap = mediatorMap;
			_contextView = contextView;
			_injector = injector;
			mediatorFactory.addEventListener(MediatorFactoryEvent.MEDIATOR_REMOVE, onMediatorRemove);
		}

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		public function mapView(viewClass:Class,
			mediatorClass:Class,
			injectViewAs:* = null,
			autoCreate:Boolean = true,
			autoRemove:Boolean = true):void
		{
			const mapping:IMediatorMappingConfig =
				_mediatorMap.map(instanceOf(viewClass)).toMediator(mediatorClass);
			var viewInjectTypes : Array = [];
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
				new MediatorCreationGuardAndHook(viewClass, mediatorClass, viewInjectTypes, _injector);
			mapping.withGuards(guardAndHook);
			mapping.withHooks(guardAndHook);
		}

		public function unmapView(viewClassOrName:*):void
		{
			_mediatorMap.unmap(instanceOf(viewClassOrName)).fromMediators();
		}

		public function createMediator(viewComponent:Object):IMediator
		{
			// TODO: think about
			throw new Error("not implemented");
		}

		public function registerMediator(viewComponent:Object, mediator:IMediator):void
		{
			// TODO: think about
			throw new Error("not implemented");
		}

		public function removeMediator(mediator:IMediator):IMediator
		{
			// TODO: think about
			throw new Error("not implemented");
		}

		public function removeMediatorByView(viewComponent:Object):IMediator
		{
			// TODO: think about
			throw new Error("not implemented");
		}

		public function retrieveMediator(viewComponent:Object):IMediator
		{
			// TODO: think about
			throw new Error("not implemented");
		}

		public function hasMapping(viewClassOrName:*):Boolean
		{
			// TODO: think about
			throw new Error("not implemented");
		}

		public function hasMediator(mediator:IMediator):Boolean
		{
			// TODO: think about
			throw new Error("not implemented");
		}

		public function hasMediatorForView(viewComponent:Object):Boolean
		{
			// TODO: think about
			throw new Error("not implemented");
		}

		private function onMediatorRemove(event:MediatorFactoryEvent):void
		{
			event.mediator.preRemove();
		}
	}
}

import flash.display.DisplayObject;

import org.robotlegs.mvcs.Mediator;

import org.swiftsuspenders.Injector;

class MediatorCreationGuardAndHook
{
	private var _viewType:Class;
	private var _mediatorType:Class;
	private var _viewInjectTypes:Array;
	private var _injector:Injector;
	private var _view:DisplayObject;

	public function MediatorCreationGuardAndHook(viewType : Class, mediatorType : Class,
	                                             viewInjectTypes : Array, injector : Injector)
	{
		_viewType = viewType;
		_mediatorType = mediatorType;
		_viewInjectTypes = viewInjectTypes;
		_injector = injector;
	}

	public function approve() : Boolean
	{
		const view : DisplayObject = _injector.getInstance(_viewType);
		for (var i : int = _viewInjectTypes.length; i--;)
		{
			const type : Class = _viewInjectTypes[i];
			_injector.map(type).toValue(view);
		}
		_view = view;
		return true;
	}

	public function hook() : void
	{
		var mediator : Mediator = _injector.getInstance(_mediatorType);
		for (var i : int = _viewInjectTypes.length; i--;)
		{
			const type : Class = _viewInjectTypes[i];
			_injector.unmap(type);
		}
		mediator.setViewComponent(_view);
		_view = null;
		mediator.preRegister();
	}
}