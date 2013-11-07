//
//  RTRunnerPassedViewController.h
//  RelayTionship
//
//  Created by Dru Kepple on 8/23/12.
//  Copyright (c) 2012 Dru Kepple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Leg.h"


@class RTRunnerPassedViewController;


@protocol RTRunnerPassedViewControllerDelegate <NSObject>

- (void) runnerPassedViewControllerDidCancel:(RTRunnerPassedViewController *) viewController;
- (void) runnerPassedViewControllerDidSave:(RTRunnerPassedViewController *)viewController withMileage:(float)mileage;

@end


@interface RTRunnerPassedViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *milesElapsed;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (strong, nonatomic) id<RTRunnerPassedViewControllerDelegate> delegate;

@property (strong, nonatomic) Leg *leg;

- (float) mileage;
- (IBAction)doneTap:(id)sender;
- (IBAction)cancelTap:(id)sender;
- (IBAction)mileageEditChange:(id)sender;

@end
