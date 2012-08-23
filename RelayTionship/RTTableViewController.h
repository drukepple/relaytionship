//
//  RTTableViewController.h
//  RelayTionship
//
//  Created by Dru Kepple on 8/20/12.
//  Copyright (c) 2012 Dru Kepple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTCoreDataAgent.h"
#import "RTViewController.h"

@interface RTTableViewController : UITableViewController <RTViewControllerLocalStore>

@property (strong, nonatomic) RTCoreDataAgent *localStore;

- (void) reloadTableData;
@property (weak, nonatomic) IBOutlet UITextField *nameField;

@end
