//
//  RTTeamInputCell.h
//  RelayTionship
//
//  Created by Dru Kepple on 9/2/12.
//  Copyright (c) 2012 Dru Kepple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTTextField.h"

@interface RTTeamInputCell : UITableViewCell <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet RTTextField *input;

@property (assign, nonatomic) NSInteger labelWidth;

@end
