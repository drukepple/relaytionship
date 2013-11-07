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
#import "RTPacePicker.h"

@interface RTRunnerViewController : RTTableViewController <UITextFieldDelegate, ABPeoplePickerNavigationControllerDelegate, RTPacePickerDelegate>

@property (strong, nonatomic) Runner *runner;
@property (strong, nonatomic) NSArray *legs;

- (IBAction)importFromContactsTap:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *totalMilesLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameField;

@end
