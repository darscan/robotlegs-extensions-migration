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
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;

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

		private var mediatorMap:robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/

		public function MediatorMap(
			mediatorMap:robotlegs.bender.extensions.mediatorMap.api.IMediatorMap,
			contextView:DisplayObjectContainer)
		{
			this.mediatorMap = mediatorMap;
			_contextView = contextView;
		}

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		public function mapView(viewClassOrName:*,
			mediatorClass:Class,
			injectViewAs:* = null,
			autoCreate:Boolean = true,
			autoRemove:Boolean = true):void
		{
			// TODO: deal with viewClassOrName if string 
			// TODO: deal with injectViewAs
			// TODO: think about autoCreate and autoRemove
			mediatorMap.map(viewClassOrName).toMediator(mediatorClass);
		}

		public function unmapView(viewClassOrName:*):void
		{
			mediatorMap.unmap(viewClassOrName).fromAll();
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
	}
}

