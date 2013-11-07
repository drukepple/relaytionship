//
//  RTTeamInputCell.m
//  RelayTionship
//
//  Created by Dru Kepple on 9/2/12.
//  Copyright (c) 2012 Dru Kepple. All rights reserved.
//

#import "RTTeamInputCell.h"

@implementation RTTeamInputCell
@synthesize label;
@synthesize input;
@synthesize labelWidth = _labelWidth;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	NSLog(@"init");
    if (self) {
        // Initialization code
		NSLog(@"Init 2");
		self.input.delegate = self;
    }
    return self;
}



#pragma mark - UITextFieldDelegate

- (void) textFieldDidEndEditing:(UITextField *)textField {
	NSLog(@"did end editing");
}



#pragma mark - Setters/Getters
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setLabelWidth:(NSInteger)labelWidth {
	if (_labelWidth != labelWidth) {
		_labelWidth = labelWidth;
		CGRect labelRect = self.label.frame;
		CGFloat originalWidth = labelRect.size.width;
		labelRect.size.width = labelWidth;
		self.label.frame = labelRect;
		
		CGRect inputRect = self.input.frame;
		inputRect.size.width -= labelWidth - originalWidth;
		inputRect.origin.x += labelWidth - originalWidth;
		self.input.frame = inputRect;
	}
}
- (NSInteger) labelWidth {
	return self.label.frame.size.width;
}

@end
