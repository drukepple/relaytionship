//
//  RTPacePicker.m
//  RelayTionship
//
//  Created by Dru Kepple on 8/29/12.
//  Copyright (c) 2012 Dru Kepple. All rights reserved.
//

#import "RTPacePicker.h"

@implementation RTPacePicker

@synthesize paceTime = _paceTime;
@synthesize paceValue = _paceValue;
@synthesize paceDelegate = _paceDelegate;


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
		self.dataSource = self;
//		self.ac
		self.showsSelectionIndicator = YES;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


#pragma mark - Picker DataSource
- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 3;
}
- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	switch (component) {
		case 0:
			return 20;
			
		case 1:
			return 1;
			
		case 2:
			return 60;
			
		default:
			break;
	}
	return 1;
}


#pragma mark - Picker Delegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	switch (component) {
		case 0:
			return [NSString stringWithFormat:@"%d", row];
			break;
			
		case 1:
			return @":";
			
		case 2:
			return [NSString stringWithFormat:@"%02d", row];
			
		default:
			break;
	}
	return [NSString stringWithFormat:@"%d", row];
}

- (CGFloat) pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
	switch (component) {
		case 0:
		case 2:
			return 60.0;
		case 1:
			return 25.0;
	}
	return 60.0;
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	int mins = [self selectedRowInComponent:0];
	int secs = [self selectedRowInComponent:2];
	self.paceValue = mins + (secs/60.0);
	[self.paceDelegate pacePicker:self didSelectPace:self.paceValue];
}

- (NSString *) pickerView:(UIPickerView *)pickerView accessibilityLabelForComponent:(NSInteger)component {
	switch (component) {
		case 0:
			return @"min";
		case 2:
			return @"sec";
	}
	return @"";
}


#pragma mark - Setters / Getters
- (void) updateDisplayWithMins:(int)mins secs:(int)secs {
	[self selectRow:mins inComponent:0 animated:NO];
	[self selectRow:secs inComponent:2 animated:NO];
}
- (void) setPaceTime:(NSString *)paceTime {
	if (_paceTime != paceTime) {
		_paceTime = paceTime;
		NSArray *parts = [paceTime componentsSeparatedByString:@":"];
		float mins = ((NSString *)[parts objectAtIndex:0]).floatValue;
		float secs = ((NSString *)[parts objectAtIndex:1]).floatValue;
		_paceValue = mins + (secs/60.0);
		
		// Update display
//		int mins = floor(self.leg.projectedPaceValue);
//		int secs = round((self.leg.projectedPaceValue - mins) * 60);
		[self updateDisplayWithMins:mins secs:secs];
	}
}

- (void) setPaceValue:(float)paceValue {
	if (_paceValue != paceValue) {
		_paceValue = paceValue;
		int mins = floor(paceValue);
		int secs = round((paceValue - mins) * 60.0);
		_paceTime = [NSString stringWithFormat:@"%d:%02d", mins, secs];
		[self updateDisplayWithMins:mins secs:secs];
	}
}


@end
