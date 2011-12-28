//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package org.robotlegs.adapters
{
	import flash.system.ApplicationDomain;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import org.robotlegs.core.IReflector;
	import org.swiftsuspenders.DescribeTypeJSONReflector;

	/**
	 * SwiftSuspender <code>IReflector</code> adpater - See: <a href="http://github.com/tschneidereit/SwiftSuspenders">SwiftSuspenders</a>
	 *
	 * @author tschneidereit
	 */
	public class SwiftSuspendersReflector extends DescribeTypeJSONReflector implements IReflector
	{

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		public function classExtendsOrImplements(classOrClassName:Object,
			superclass:Class, application:ApplicationDomain = null):Boolean
		{
			var actualClass:Class;

			if (classOrClassName is Class)
			{
				actualClass = Class(classOrClassName);
			}
			else if (classOrClassName is String)
			{
				try
				{
					actualClass = Class(getDefinitionByName(classOrClassName as String));
				}
				catch (e:Error)
				{
					throw new Error("The class name " + classOrClassName +
						" is not valid because of " + e + "\n" + e.getStackTrace());
				}
			}

			if (!actualClass)
			{
				throw new Error("The parameter classOrClassName must be a valid Class " +
					"instance or fully qualified class name.");
			}

			if (actualClass == superclass)
				return true;

			const factoryDescription:XML = describeType(actualClass).factory[0];

			return (factoryDescription.children().(
				name() == "implementsInterface" || name() == "extendsClass").(
				attribute("type") == getQualifiedClassName(superclass)).length() > 0);
		}
	}
}
