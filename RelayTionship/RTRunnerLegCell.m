//
//  RTRunnerLegCell.m
//  RelayTionship
//
//  Created by Dru Kepple on 9/2/12.
//  Copyright (c) 2012 Dru Kepple. All rights reserved.
//

#import "RTRunnerLegCell.h"

@implementation RTRunnerLegCell
@synthesize legLabel;
@synthesize distanceLabel;
@synthesize paceLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void) populateLegNumber:(int16_t)legNum distance:(float)distance pace:(NSString *)pace {
	self.legLabel.text = [NSString stringWithFormat:@"Leg %d", legNum];
	[self.legLabel sizeToFit];
	
	CGRect moveFrame = self.distanceLabel.frame;
	CGRect anchor = self.legLabel.frame;
	moveFrame.origin.x = anchor.origin.x + anchor.size.width + 6;
	self.distanceLabel.frame = moveFrame;
	
	self.distanceLabel.text = [NSString stringWithFormat:@"%.02f mi", distance];
	[self.distanceLabel sizeToFit];
	
	self.paceLabel.text = pace;
	[self.paceLabel sizeToFit];
	
	moveFrame = self.paceLabel.frame;
	anchor = self.accessoryView.frame;
	moveFrame.origin.x = self.frame.size.width - moveFrame.size.width - 50;
	self.paceLabel.frame = moveFrame;
}

@end
