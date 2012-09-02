//
//  RTDurationPicker.m
//  RelayTionship
//
//  Created by Dru Kepple on 9/1/12.
//  Copyright (c) 2012 Dru Kepple. All rights reserved.
//

#import "RTDurationPicker.h"

@implementation RTDurationPicker

@synthesize durationTime = _durationTime;
@synthesize durationValue = _durationValue;
@synthesize durationDelegate = _durationDelegate;


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
	return 5;
}
- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	switch (component) {
		case 0:
			return 4;
			
		case 1:
		case 3:
			return 1;
			
		case 2:
		case 4:
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
		case 3:
			return @":";
			
		case 2:
		case 4:
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
		case 4:
			return 60.0;
		case 1:
		case 3:
			return 25.0;
	}
	return 60.0;
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	int hrs  = [self selectedRowInComponent:0];
	int mins = [self selectedRowInComponent:2];
	int secs = [self selectedRowInComponent:4];
	self.durationValue = (hrs * 60.0) + mins + (secs/60.0);
	[self.durationDelegate durationPicker:self didSelectDuration:self.durationValue];
}

- (NSString *) pickerView:(UIPickerView *)pickerView accessibilityLabelForComponent:(NSInteger)component {
	switch (component) {
		case 0:
			return @"h";
		case 2:
			return @"m";
		case 4:
			return @"s";
	}
	return @"";
}


#pragma mark - Setters / Getters
- (NSDictionary *) durationComponents {
	NSArray *parts = [self.durationTime componentsSeparatedByString:@":"];
	NSInteger minsIndex, secsIndex;
	if (parts.count == 2) {
		minsIndex = 0;
		secsIndex = 1;
	} else {
		minsIndex = 1;
		secsIndex = 2;
	}
	float hrs  = parts.count == 3 ? ((NSString *)[parts objectAtIndex:0]).floatValue : 0;
	float mins = ((NSString *)[parts objectAtIndex:minsIndex]).floatValue;
	float secs = ((NSString *)[parts objectAtIndex:secsIndex]).floatValue;
	NSLog(@"How to make a C struct?");
	return [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:hrs], @"h",
			[NSNumber numberWithFloat:mins], @"m",
			[NSNumber numberWithFloat:secs], @"s",
			nil];
}

- (void) setDurationTime:(NSString *)durationTime {
	if (_durationTime != durationTime) {
		_durationTime = durationTime;
//		NSArray *parts = [durationTime componentsSeparatedByString:@":"];
//		NSInteger minsIndex, secsIndex;
//		if (parts.count == 2) {
//			minsIndex = 0;
//			secsIndex = 1;
//		} else {
//			minsIndex = 1;
//			secsIndex = 2;
//		}
//		float hrs  = parts.count == 3 ? ((NSString *)[parts objectAtIndex:0]).floatValue : 0;
//		float mins = ((NSString *)[parts objectAtIndex:minsIndex]).floatValue;
//		float secs = ((NSString *)[parts objectAtIndex:secsIndex]).floatValue;
		NSDictionary *comps = self.durationComponents;
		float hrs  = ((NSNumber *)[comps objectForKey:@"h"]).floatValue;
		float mins = ((NSNumber *)[comps objectForKey:@"m"]).floatValue;
		float secs = ((NSNumber *)[comps objectForKey:@"s"]).floatValue;
		
		[self selectRow:hrs  inComponent:0 animated:NO];
		[self selectRow:mins inComponent:2 animated:NO];
		[self selectRow:secs inComponent:4 animated:NO];
		
		_durationValue = (hrs * 60) + mins + (secs/60.0);
	}
}

- (void) setDurationValue:(float)durationValue {
	if (_durationValue != durationValue) {
		_durationValue = durationValue;
		int mins = floor(durationValue);
		int secs = round((durationValue - mins) * 60.0);
		if (mins > 60) {
			int hrs = floor(mins / 60.0);
			mins -= (hrs * 60);
			_durationTime = [NSString stringWithFormat:@"%d:%02d:%02d", hrs, mins, secs];
		} else {
			_durationTime = [NSString stringWithFormat:@"%d:%02d", mins, secs];
		}
	}
}



@end
