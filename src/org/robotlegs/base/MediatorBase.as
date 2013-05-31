/*
 * Copyright (c) 2009 the original author or authors
 *
 * Permission is hereby granted to use, modify, and distribute this file
 * in accordance with the terms of the license agreement accompanying it.
 */

package org.robotlegs.base
{
	import org.robotlegs.core.IMediator;
	
	/**
	 * An abstract <code>IMediator</code> implementation
	 */
	public class MediatorBase implements IMediator
	{
		public var viewComponent:Object;
		
		//---------------------------------------------------------------------
		//  Constructor
		//---------------------------------------------------------------------
		
		/**
		 * Creates a new <code>Mediator</code> object
		 */
		public function MediatorBase()
		{
		}
		
		//---------------------------------------------------------------------
		//  API
		//---------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		public function preRegister():void
		{
		}
		
		/**
		 * @inheritDoc
		 */
		public function onRegister():void
		{
		}
		
		/**
		 * @inheritDoc
		 */
		public function preRemove():void
		{
		}

		/**
		 * @inheritDoc
		 */
		public function onRemove():void
		{
		}
		
		/**
		 * @inheritDoc
		 */
		public function getViewComponent():Object
		{
			return viewComponent;
		}

		/**
		 * @private
		 */
		public function preInitialize():void
		{
			preRegister();
		}

		/**
		 * @private
		 */
		public function initialize():void
		{
			onRegister();
		}

		/**
		 * @private
		 */
		public function preDestroy():void
		{
			preRemove();
		}

		/**
		 * @private
		 */
		public function destroy():void
		{
			onRemove();
		}

		/**
		 * @inheritDoc
		 */
		public function setViewComponent(viewComponent:Object):void
		{
			this.viewComponent = viewComponent;
		}

	}
}
