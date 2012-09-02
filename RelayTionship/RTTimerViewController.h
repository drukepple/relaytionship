//
//  RTTimerViewController.h
//  RelayTionship
//
//  Created by Dru Kepple on 8/22/12.
//  Copyright (c) 2012 Dru Kepple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTCoreDataAgent.h"
#import "RTViewController.h"
#import "RTRunnerPassedViewController.h"

@interface RTTimerViewController : RTViewController <UITableViewDataSource, UITableViewDelegate, RTRunnerPassedViewControllerDelegate> {
	NSArray *legTimes;
	NSTimer *stopwatchTimer;
	NSDate *timeRunnerPassed;
}
@property (weak, nonatomic) IBOutlet UILabel *legTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *projectedTimeLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *legButton;

- (IBAction)newLegTap:(id)sender;
- (IBAction)runnerPassTap:(id)sender;
- (IBAction)projectedTimeTap:(UIButton *)sender;
@end
