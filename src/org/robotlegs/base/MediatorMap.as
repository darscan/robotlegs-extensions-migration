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
	import org.robotlegs.core.IMediatorMap;
	import org.robotlegs.v2.extensions.mediatorMap.api.IMediatorMap;

	public class MediatorMap implements org.robotlegs.core.IMediatorMap
	{
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

		private var mediatorMap:org.robotlegs.v2.extensions.mediatorMap.api.IMediatorMap;

		public function MediatorMap(
			mediatorMap:org.robotlegs.v2.extensions.mediatorMap.api.IMediatorMap,
			contextView:DisplayObjectContainer)
		{
			this.mediatorMap = mediatorMap;
			_contextView = contextView;
		}

		public function mapView(viewClassOrName:*,
			mediatorClass:Class,
			injectViewAs:* = null,
			autoCreate:Boolean = true,
			autoRemove:Boolean = true):void
		{
			// TODO: deal with viewClassOrName if string 
			// TODO: deal with injectViewAs
			// TODO: think about autoCreate and autoRemove
			mediatorMap.map(mediatorClass).toView(viewClassOrName);
		}

		public function unmapView(viewClassOrName:*):void
		{
			// TODO: think about
			throw new Error("not implemented");
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

