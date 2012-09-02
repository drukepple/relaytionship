//
//  RTLegTableCell.h
//  RelayTionship
//
//  Created by Dru Kepple on 8/28/12.
//  Copyright (c) 2012 Dru Kepple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTLegTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *legLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *runnerLabel;
@property (weak, nonatomic) IBOutlet UILabel *paceLabel;
@end
