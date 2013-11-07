//
//  RTRunnerPassedViewController.m
//  RelayTionship
//
//  Created by Dru Kepple on 8/23/12.
//  Copyright (c) 2012 Dru Kepple. All rights reserved.
//

#import "RTRunnerPassedViewController.h"

@interface RTRunnerPassedViewController ()

@end

@implementation RTRunnerPassedViewController
@synthesize milesElapsed;
@synthesize doneButton;
@synthesize leg;
@synthesize delegate = _delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	self.milesElapsed.keyboardType = UIKeyboardTypeDecimalPad;
	CGRect fieldBounds = self.milesElapsed.bounds;
	fieldBounds.size.height = 60.0;
	self.milesElapsed.bounds = fieldBounds;
	// CAN WE GET THE TEXTFIELD TO AUTO FOCUS?
	[self.milesElapsed becomeFirstResponder];
}

- (void)viewDidUnload {
	[self setMilesElapsed:nil];
	[self setDoneButton:nil];
	[self setLeg:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (float) mileage {
	return [self.milesElapsed.text floatValue];
}

- (IBAction)doneTap:(id)sender {
	[self.delegate runnerPassedViewControllerDidSave:self withMileage:self.mileage];
}

- (IBAction)cancelTap:(id)sender {
	[self.delegate runnerPassedViewControllerDidCancel:self];
}

- (IBAction)mileageEditChange:(id)sender {
	float legDistance = self.leg.distanceValue;
	NSLog(@"legDistance: %f", legDistance);
	if (self.mileage > legDistance) {
		self.milesElapsed.text = [NSString stringWithFormat:@"%.2f", legDistance];
	}
}


@end
