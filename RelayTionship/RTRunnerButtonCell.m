//
//  RTRunnerButtonCell.m
//  RelayTionship
//
//  Created by Dru Kepple on 9/2/12.
//  Copyright (c) 2012 Dru Kepple. All rights reserved.
//

#import "RTRunnerButtonCell.h"

@implementation RTRunnerButtonCell
@synthesize label;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
