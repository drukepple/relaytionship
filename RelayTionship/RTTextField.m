//
//  RTTextFieldNoCursor.m
//  RelayTionship
//
//  Created by Dru Kepple on 10/19/13.
//  Copyright (c) 2013 Dru Kepple. All rights reserved.
//

#import "RTTextField.h"

@implementation RTTextField

@synthesize hidesCursor;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (CGRect)caretRectForPosition:(UITextPosition *)position {
	if (hidesCursor) {
		return CGRectZero;
	} else {
		return [super caretRectForPosition:position];
	}
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/




@end
