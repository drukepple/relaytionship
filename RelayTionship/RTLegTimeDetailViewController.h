//
//  RTLegTimeDetailViewController.h
//  RelayTionship
//
//  Created by Dru Kepple on 8/23/12.
//  Copyright (c) 2012 Dru Kepple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTTableViewController.h"
#import "Leg.h"

@interface RTLegTimeDetailViewController : RTTableViewController {
	NSArray *keys;
}

@property (strong, nonatomic) Leg * leg;

@end
