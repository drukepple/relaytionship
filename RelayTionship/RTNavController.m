//
//  RTNavController.m
//  RelayTionship
//
//  Created by Dru Kepple on 8/21/12.
//  Copyright (c) 2012 Dru Kepple. All rights reserved.
//

#import "RTNavController.h"

@interface RTNavController ()

@end

@implementation RTNavController

@synthesize localStore = _localStore;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
//	NSLog(@"viewDidLoad");
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - Setters/Getters

- (void) setLocalStore:(RTCoreDataAgent *)localStore {
//	NSLog(@"NAV setLocalStore");
	if (_localStore != localStore) {
		_localStore = localStore;
//		NSLog(@"\tdifferent...setting");
	}
//	NSLog(@"\tview conts: %@", self.viewControllers);
//	NSLog(@"\tself.topViewController: %@", self.topViewController);
	UIViewController <RTViewControllerLocalStore> *vcls = (UIViewController <RTViewControllerLocalStore> *)self.topViewController;
//	NSLog(@"\tvcls: %@", vcls);
	vcls.localStore = self.localStore;
}


@end
