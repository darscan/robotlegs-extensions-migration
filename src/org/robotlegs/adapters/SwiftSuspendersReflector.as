//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package org.robotlegs.adapters
{
	import flash.system.ApplicationDomain;
	import org.robotlegs.core.IReflector;
	import org.swiftsuspenders.DescribeTypeJSONReflector;

	/**
	 * SwiftSuspender <code>IReflector</code> adpater - See: <a href="http://github.com/tschneidereit/SwiftSuspenders">SwiftSuspenders</a>
	 *
	 * @author tschneidereit
	 */
	public class SwiftSuspendersReflector implements IReflector
	{

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private const _reflector:DescribeTypeJSONReflector = new DescribeTypeJSONReflector();

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		public function classExtendsOrImplements(classOrClassName:Object, superclass:Class, applicationDomain:ApplicationDomain = null):Boolean
		{
			return _reflector.typeImplements(classOrClassName as Class, superclass);
		}

		public function getClass(value:*, applicationDomain:ApplicationDomain = null):Class
		{
			return _reflector.getClass(value);
		}

		public function getFQCN(value:*, replaceColons:Boolean = false):String
		{
			return _reflector.getFQCN(value, replaceColons);
		}
	}
}
