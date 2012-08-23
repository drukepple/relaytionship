//
//  RTTabBarController.m
//  RelayTionship
//
//  Created by Dru Kepple on 8/18/12.
//  Copyright (c) 2012 Dru Kepple. All rights reserved.
//

#import "RTTabBarController.h"
#import "RTViewController.h"

@interface RTTabBarController ()
- (void)setChildLocalStore:(UIViewController *)viewController;
@end

@implementation RTTabBarController

@synthesize localStore = _localStore;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	self.delegate = self;
//	NSLog(@"TAB viewDidLoad");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - Setters/Getters
- (void) setLocalStore:(RTCoreDataAgent *)localStore {
//	NSLog(@"TAB setLocalStore");
	if (_localStore != localStore) {
		_localStore = localStore;
		self.selectedIndex = self.localStore.selectedTab;
		[self setChildLocalStore:[self.viewControllers objectAtIndex:self.selectedIndex]];
	}
}


#pragma mark - Delegate Methods
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
//	if ([viewController conformsToProtocol:@protocol(RTViewControllerLocalStore)]) {
//		NSLog(@"Yes, it's coforms to the protocol");
//		UIViewController <RTViewControllerLocalStore>* ls = (UIViewController <RTViewControllerLocalStore>*)viewController;
//		ls.localStore = self.localStore;
//	} else {
//		NSLog(@"No, no conformo");
//	}
	[self setChildLocalStore:viewController];
	self.localStore.selectedTab = [self.viewControllers indexOfObject:viewController];
}

- (void)setChildLocalStore:(UIViewController *)vc {
	if ([vc conformsToProtocol:@protocol(RTViewControllerLocalStore)]) {
		//NSLog(@"Yes, it's coforms to the protocol");
		UIViewController <RTViewControllerLocalStore>* ls = (UIViewController <RTViewControllerLocalStore>*)vc;
		ls.localStore = self.localStore;
	} else {
		NSLog(@"Tab Bar child View Controller does not conform to RTViewControllerLocalStore protocol");
	}
}

@end
