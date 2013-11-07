//
//  RTPacePicker.h
//  RelayTionship
//
//  Created by Dru Kepple on 8/29/12.
//  Copyright (c) 2012 Dru Kepple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RTPacePicker;


struct RTPace {
	int minutes;
	int seconds;
};
typedef struct RTPace RTPace;

@protocol RTPacePickerDelegate <NSObject>

- (void) pacePicker:(RTPacePicker *)pacePicker didSelectPace:(float)paceValue;

@end



@interface RTPacePicker : UIPickerView <UIPickerViewDataSource, UIPickerViewDelegate, UIPickerViewAccessibilityDelegate>

@property (strong, nonatomic) NSString *paceTime;
@property (assign, nonatomic) float paceValue;
@property (assign, nonatomic) id<RTPacePickerDelegate> paceDelegate;

- (NSString *)paceTimeForValue: (float)value;

@end
