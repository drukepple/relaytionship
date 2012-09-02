//
//  RTLegTableCell.m
//  RelayTionship
//
//  Created by Dru Kepple on 8/28/12.
//  Copyright (c) 2012 Dru Kepple. All rights reserved.
//

#import "RTLegTableCell.h"

@implementation RTLegTableCell
@synthesize legLabel;
@synthesize distanceLabel;
@synthesize runnerLabel;
@synthesize paceLabel;

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
