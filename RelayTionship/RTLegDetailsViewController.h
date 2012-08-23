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

@interface RTLegDetailsViewController : RTTableViewController <UITextFieldDelegate>

@property (strong, nonatomic) Leg* leg;
@property (weak, nonatomic) IBOutlet UITextField *distanceField;

@end
