//
//  RTRaceTableViewController.h
//  RelayTionship
//
//  Created by Dru Kepple on 8/24/12.
//  Copyright (c) 2012 Dru Kepple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTTableViewController.h"
#import <MessageUI/MessageUI.h>

@interface RTRaceTableViewController : RTTableViewController <MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIDatePicker *startTimePicker;
- (IBAction)startTimePickerChanged:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *scheduledFinishClockLabel;
@property (weak, nonatomic) IBOutlet UILabel *scheduledFinishTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *projectedFinishClockLabel;
@property (weak, nonatomic) IBOutlet UILabel *projectedFinishTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *actualFinishClockLabel;
@property (weak, nonatomic) IBOutlet UILabel *actualFinishTimeLabel;



@end
