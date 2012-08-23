//
//  RTAppDelegate.m
//  RelayTionship
//
//  Created by Dru Kepple on 8/18/12.
//  Copyright (c) 2012 Dru Kepple. All rights reserved.
//

#import "RTAppDelegate.h"
#import "RTTabBarController.h"
#import "RTTeamRosterViewController.h"

@implementation RTAppDelegate

@synthesize localStore = _localStore;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
	_localStore = [[RTCoreDataAgent alloc] initWithStoreName:@"RelayTionship"];
	RTTabBarController *controller = (RTTabBarController *)self.window.rootViewController;
	controller.delegate = self;
	
//	RTTeamRosterViewController *teamRosterVC;
	
	//	//check to see if navbar "get" worked
	//	if (controller.viewControllers) {
	//
	//		//look for the nav controller in tab bar views
	//		for (UINavigationController *view in controller.viewControllers) {
	//
	//			//when found, do the same thing to find the MasterViewController under the nav controller
	//			if ([view isKindOfClass:[UINavigationController class]])
	//				for (UIViewController *view2 in view.viewControllers)
	//					if ([view2 isKindOfClass:[RTTeamRosterViewController class]])
	//						teamRosterVC = (RTTeamRosterViewController *) view2;
	//		}
	//	}
//	teamRosterVC = (RTTeamRosterViewController *)controller.selectedViewController;
//	NSLog(@"teamRoster: %@", teamRosterVC);
//	NSLog(@"controller.selectedViewController: %@", controller.selectedViewController);
//	NSLog(@"controller.viewControllers: %@", controller.viewControllers);
//	NSLog(@"controller.selectedIndex: %d", controller.selectedIndex);
//	UINavigationController *navController = [controller.viewControllers objectAtIndex:0];
//	NSLog(@"navController: %@", navController);
	
	controller.localStore = self.localStore;
	
	//controller.selectedIndex =
	
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	[self.localStore saveContext];
}




#pragma mark - UITabBar Controller Delegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
	NSLog(@"DID SELECT TAB: %d", tabBarController.selectedIndex);
}

@end
