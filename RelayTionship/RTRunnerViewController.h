//
//  RTRunnerViewController.h
//  RelayTionship
//
//  Created by Dru Kepple on 8/21/12.
//  Copyright (c) 2012 Dru Kepple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>
#import "RTTableViewController.h"
#import "Runner.h"

@interface RTRunnerViewController : RTTableViewController <UITextFieldDelegate, ABPeoplePickerNavigationControllerDelegate>

@property (strong, nonatomic) Runner *runner;
- (IBAction)importFromContactsTap:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *totalMilesLabel;

@end
