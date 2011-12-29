//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.migration
{
	import org.robotlegs.adapters.SwiftSuspendersInjector;
	import org.robotlegs.adapters.SwiftSuspendersReflector;
	import org.robotlegs.base.CommandMap;
	import org.robotlegs.base.EventMap;
	import org.robotlegs.base.MediatorMap;
	import org.robotlegs.base.ViewMap;
	import org.robotlegs.core.ICommandMap;
	import org.robotlegs.core.IEventMap;
	import org.robotlegs.core.IInjector;
	import org.robotlegs.core.IMediatorMap;
	import org.robotlegs.core.IReflector;
	import org.robotlegs.core.IViewMap;
	import org.swiftsuspenders.Injector;
	import robotlegs.bender.core.api.IContext;
	import robotlegs.bender.core.api.IContextExtension;

	public class MigrationExtension implements IContextExtension
	{

		/*============================================================================*/
		/* Private Properties                                                         */
		/*============================================================================*/

		private var context:IContext;

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		public function install(context:IContext):void
		{
			this.context = context;

			const injector:Injector = context.injector;
			const iinjector:IInjector = new SwiftSuspendersInjector(injector);

			injector.map(IInjector).toValue(iinjector);
			injector.map(IReflector).toSingleton(SwiftSuspendersReflector);
			injector.map(ICommandMap).toSingleton(CommandMap);
			injector.map(IMediatorMap).toSingleton(MediatorMap);
			injector.map(IViewMap).toSingleton(ViewMap);
			injector.map(IEventMap).toType(EventMap);
		}

		public function initialize():void
		{
		}

		public function uninstall():void
		{
			// TODO: uninstall
		}
	}
}
