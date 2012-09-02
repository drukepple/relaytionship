//
//  RTLegDetailsViewController.h
//  RelayTionship
//
//  Created by Dru Kepple on 8/21/12.
//  Copyright (c) 2012 Dru Kepple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTTableViewController.h"
#import "Leg.h"
#import "RTPacePicker.h"
#import "RTDurationPicker.h"


@interface RTLegDetailsViewController : RTTableViewController <UITextFieldDelegate, RTPacePickerDelegate, RTDurationPickerDelegate>

@property (strong, nonatomic) Leg* leg;
@property (weak, nonatomic) IBOutlet UITextField *distanceField;
@property (weak, nonatomic) IBOutlet UITextField *paceField;
@property (weak, nonatomic) IBOutlet UITextField *durationField;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;

@end
