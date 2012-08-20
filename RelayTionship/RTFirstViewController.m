//
//  RTFirstViewController.m
//  RelayTionship
//
//  Created by Dru Kepple on 8/20/12.
//  Copyright (c) 2012 Dru Kepple. All rights reserved.
//

#import "RTFirstViewController.h"

@interface RTFirstViewController ()

@end

@implementation RTFirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
	    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
	} else {
	    return YES;
	}
}

@end
