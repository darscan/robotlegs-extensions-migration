//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package org.robotlegs.adapters
{
	import flash.system.ApplicationDomain;
	
	import org.robotlegs.core.IInjector;
	import org.swiftsuspenders.Injector;
	import org.swiftsuspenders.dependencyproviders.ForwardingProvider;

	/**
	 * SwiftSuspender <code>IInjector</code> adpater - See:
	 *
	 * <a href="http://github.com/tschneidereit/SwiftSuspenders">SwiftSuspenders</a>
	 *
	 * @author tschneidereit
	 */
	public class SwiftSuspendersInjector implements IInjector
	{

		/*============================================================================*/
		/* Public Properties                                                          */
		/*============================================================================*/

		public function get applicationDomain():ApplicationDomain
		{
			return _injector.applicationDomain;
		}

		/**
		 * @inheritDoc
		 */
		public function set applicationDomain(value:ApplicationDomain):void
		{
			_injector.applicationDomain = value;
		}

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private var _injector:Injector;

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/

		public function SwiftSuspendersInjector(injector:Injector)
		{
			_injector = injector;
		}

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		/**
		 * @inheritDoc
		 */
		public function createChild(applicationDomain:ApplicationDomain = null):IInjector
		{
			return new SwiftSuspendersInjector(
				_injector.createChildInjector(applicationDomain));
		}

		/**
		 * @inheritDoc
		 */
		public function getInstance(clazz:Class, named:String = ""):*
		{
			return _injector.getInstance(clazz, named);
		}

		/**
		 * @inheritDoc
		 */
		public function hasMapping(clazz:Class, named:String = ""):Boolean
		{
			return _injector.satisfies(clazz, named);
		}

		/**
		 * @inheritDoc
		 */
		public function injectInto(target:Object):void
		{
			_injector.injectInto(target);
		}

		/**
		 * @inheritDoc
		 */
		public function instantiate(clazz:Class):*
		{
			return _injector.getInstance(clazz);
		}

		/**
		 * @inheritDoc
		 */
		public function mapClass(
			whenAskedFor:Class, instantiateClass:Class, named:String = ""):*
		{
			return _injector.map(whenAskedFor, named).toType(instantiateClass);
		}

		/**
		 * @inheritDoc
		 */
		public function mapRule(whenAskedFor:Class, useRule:*, named:String = ""):*
		{
			return _injector.map(whenAskedFor, named).toProvider(new ForwardingProvider(useRule));
		}

		/**
		 * @inheritDoc
		 */
		public function mapSingleton(whenAskedFor:Class, named:String = ""):*
		{
			return _injector.map(whenAskedFor, named).asSingleton();
		}

		/**
		 * @inheritDoc
		 */
		public function mapSingletonOf(
			whenAskedFor:Class, useSingletonOf:Class, named:String = ""):*
		{
			return _injector.map(whenAskedFor, named).toSingleton(useSingletonOf);
		}

		/**
		 * @inheritDoc
		 */
		public function mapValue(whenAskedFor:Class, useValue:Object, named:String = ""):*
		{
			return _injector.map(whenAskedFor, named).toValue(useValue);
		}

		/**
		 * @inheritDoc
		 */
		public function unmap(clazz:Class, named:String = ""):void
		{
			_injector.unmap(clazz, named);
		}
	}
}
