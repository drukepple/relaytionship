//
//  RTDurationPicker.h
//  RelayTionship
//
//  Created by Dru Kepple on 9/1/12.
//  Copyright (c) 2012 Dru Kepple. All rights reserved.
//

#import <UIKit/UIKit.h>


@class RTDurationPicker;


@protocol RTDurationPickerDelegate <NSObject>

- (void) durationPicker:(RTDurationPicker *)durationPicker didSelectDuration:(float)durationValue;

@end



@interface RTDurationPicker : UIPickerView <UIPickerViewDataSource, UIPickerViewDelegate, UIPickerViewAccessibilityDelegate>

@property (strong, nonatomic) NSString *durationTime;
@property (assign, nonatomic) float durationValue;
@property (assign, nonatomic) id<RTDurationPickerDelegate> durationDelegate;
@property (readonly) NSDictionary *durationComponents;

@end