//
//  RTRunnerLegCell.h
//  RelayTionship
//
//  Created by Dru Kepple on 9/2/12.
//  Copyright (c) 2012 Dru Kepple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTRunnerLegCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *legLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *paceLabel;

- (void) populateLegNumber: (int16_t)legNum distance:(float)distance pace:(NSString *)pace;


@end
