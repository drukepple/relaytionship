//
//  RTRaceTableViewController.m
//  RelayTionship
//
//  Created by Dru Kepple on 8/24/12.
//  Copyright (c) 2012 Dru Kepple. All rights reserved.
//

#import "RTRaceTableViewController.h"
#import <MessageUI/MessageUI.h>
#import "RTUtil.h"

@interface RTRaceTableViewController ()

- (NSDate *)calculateScheduledFinishTime;
- (NSDate *)calculateProjectedFinishTime;
- (void) updateProjectedFinishTime;

@end


//static NSDateFormatter *timeFormat = nil;


@implementation RTRaceTableViewController
@synthesize scheduledFinishClockLabel;
@synthesize scheduledFinishTimeLabel;
@synthesize projectedFinishClockLabel;
@synthesize projectedFinishTimeLabel;
@synthesize actualFinishClockLabel;
@synthesize actualFinishTimeLabel;

@synthesize startTimePicker;


- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
}

- (void)viewDidUnload {
    [self setStartTimePicker:nil];
	[self setScheduledFinishClockLabel:nil];
	[self setScheduledFinishTimeLabel:nil];
	[self setProjectedFinishClockLabel:nil];
	[self setProjectedFinishTimeLabel:nil];
	[self setActualFinishClockLabel:nil];
	[self setActualFinishTimeLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	//NSLog(@"data: %@", self.localStore);
	if (self.localStore.race.startTime) {
		self.startTimePicker.date = self.localStore.race.startTime;
	} else {
		self.startTimePicker.date = [NSDate date];
	}
	[self updateProjectedFinishTime];

}
- (void) viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}



# pragma mark - Calculations
- (NSDate *)calculateFinishTime:(BOOL)projected {
	NSArray *legs = [self.localStore allLegs];
	NSDate *finish = [self.localStore.race.startTime copy];
	for (Leg *l in legs) {
		if (projected && l.legTime.endTime) {
			finish = [finish dateByAddingTimeInterval:[l.legTime.endTime timeIntervalSinceDate:l.legTime.startTime]];
		} else {
			float secsPerMile = l.projectedPaceValue * 60;
			NSTimeInterval projectedDuration = secsPerMile * l.distanceValue;
			finish = [finish dateByAddingTimeInterval:projectedDuration];
		}
	}
	return finish;
}

- (NSDate *)calculateScheduledFinishTime {
	//return [self calculateFinishTime:NO];
	return [self.localStore calculateFinishTime:NO];
}

- (NSDate *)calculateProjectedFinishTime {
	//return [self calculateFinishTime:YES];
	return [self.localStore calculateFinishTime:YES];
}

- (void) updateProjectedFinishTime {
//	if (timeFormat == nil) {
//		timeFormat = [[NSDateFormatter alloc] init];
//		timeFormat.dateFormat = @"h:mm a";
//	}
	
	NSDateFormatter *timeFormat = [RTUtil timeFormatter];
	
	// Convenience/performance variables.
	NSDate *startTime = self.localStore.race.startTime;
	NSDate *scheduledFinishTime  = [self calculateScheduledFinishTime];
	NSString *scheduledClockTime = [timeFormat stringFromDate:scheduledFinishTime];
	NSString *scheduledDuration  = [LegTime formatSecondsToString:[scheduledFinishTime timeIntervalSinceDate:startTime]];
	NSDate *projectedFinishTime  = [self calculateProjectedFinishTime];
	NSString *projectedClockTime = [timeFormat stringFromDate:projectedFinishTime];
	NSString *projectedDuration  = [LegTime formatSecondsToString:[projectedFinishTime timeIntervalSinceDate:startTime]];
	
	// Projected finsh times (live-updating times, based on combination of actual times and scheduled times).
	self.scheduledFinishClockLabel.text = scheduledClockTime;
	self.scheduledFinishTimeLabel.text  = scheduledDuration;
	// Projected (live-updating times) or actual times, depending if all legs have been logged or not.
	self.projectedFinishClockLabel.text = projectedClockTime;
	self.projectedFinishTimeLabel.text  = projectedDuration;
	
	// Actual finish times (only displays value if actually finished)
	if (self.localStore.raceIsFinished) {
	} else {
	}

}


#pragma mark - Table view data source
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    
    return cell;
}
*/
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog(@"selected %@", indexPath);
	if (indexPath.section == 5 && indexPath.row == 2) {
		NSLog(@"yes");
		[tableView deselectRowAtIndexPath:indexPath animated:YES];
		
		// Get the SQLite file.
		NSURL *sqliteURL = self.localStore.storePathURL;
		NSData *sqliteData = [NSData dataWithContentsOfURL:sqliteURL];
		
		// Message UI Stuff.
		if ([MFMailComposeViewController canSendMail]) {
			// Show the composer
		} else {
			// Handle the error
		}
		MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
		controller.mailComposeDelegate = self;
		[controller setSubject:@"RelayTionship Stats for you."];
		[controller setMessageBody:@"Attached is the RelayTionship stats data file from my phone." isHTML:NO];
		[controller addAttachmentData:sqliteData mimeType:@"application/octet-stream" fileName:@"RelayTionship.sqlite"];
		// mime type: maybe application/x-sqlite3 or application/x-myiphone-app to make it specific to this app?
		if (controller) [self presentModalViewController:controller animated:YES];
	} else {
		[tableView deselectRowAtIndexPath:indexPath animated:NO];
	}
}

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error {
	if (result == MFMailComposeResultSent) {
		NSLog(@"It's away!");
	}
	[self dismissModalViewControllerAnimated:YES];
}


#pragma mark - IBActions

- (IBAction)startTimePickerChanged:(id)sender {
	NSLog(@"%@", self.startTimePicker.date);
	self.localStore.race.startTime = self.startTimePicker.date;
	[self.localStore saveContext];
	[self updateProjectedFinishTime];
}

@end
