//
//  RTRunnerViewController.h
//  RelayTionship
//
//  Created by Dru Kepple on 8/21/12.
//  Copyright (c) 2012 Dru Kepple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTTableViewController.h"
#import "Runner.h"

@interface RTRunnerViewController : RTTableViewController <UITextFieldDelegate>

@property (strong, nonatomic) Runner *runner;

@end
