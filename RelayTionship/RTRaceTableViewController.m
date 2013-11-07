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
//- (NSDate *)calculateFinishTime:(BOOL)projected {
//	NSArray *legs = [self.localStore allLegs];
//	NSDate *finish = [self.localStore.race.startTime copy];
//	for (Leg *l in legs) {
//		if (projected && l.legTime.endTime) {
//			finish = [finish dateByAddingTimeInterval:[l.legTime.endTime timeIntervalSinceDate:l.legTime.startTime]];
//		} else {
//			float secsPerMile = l.projectedPaceValue * 60;
//			NSTimeInterval projectedDuration = secsPerMile * l.distanceValue;
//			finish = [finish dateByAddingTimeInterval:projectedDuration];
//		}
//	}
//	return finish;
//}

- (NSDate *)calculateScheduledFinishTime {
	//return [self calculateFinishTime:NO];
	return [self.localStore calculateFinishTime:NO];
}

- (NSDate *)calculateProjectedFinishTime {
	//return [self calculateFinishTime:YES];
	return [self.localStore calculateFinishTime:YES];
}

- (NSDate *) calculateProjectedVanExchangeTime {
	// Find out which van is currently running.
	Leg *currentLeg = [self.localStore currentLeg];
	if (currentLeg == nil) {
		currentLeg = [[self.localStore allLegs] firstObject];
	}
	Van *currentVan = currentLeg.runner.van;//((Runner*)[self.localStore currentRunner]).van;
	// How many legs in that van?  First get the runners in the van.
	NSSet *vanRunners = currentVan.runners;
	// Then count the number of legs for each runner.
	// TODO: We need a legs-per-van data model...There's no way to tell if, say, an ultra team is doubling legs, so is running
	// 6 legs per van but with 3 runners.  Of course, the current implementation will work they just need to time each leg
	// even though the runner will run through 1 exchange.  Maybe the real problem is the assumption that there are 6 runners
	// per van, elsewhere in the model. (initializeDefaultData in RTCoreDataAgent)
	double numLegsInVan = [vanRunners count];
	double currentLegIndex = [currentLeg.number intValue];
	
	int exchangeLeg = ceil(currentLegIndex / numLegsInVan) * numLegsInVan;
	
	return [self.localStore calculateTimeToFinishOfLeg:exchangeLeg projected:YES];
}

- (void) updateProjectedFinishTime {
//	if (timeFormat == nil) {
//		timeFormat = [[NSDateFormatter alloc] init];
//		timeFormat.dateFormat = @"h:mm a";
//	}
	NSLog(@"updateProjectedFinishTime");
//	NSDateFormatter *timeFormat = [RTUtil timeFormatter];
	NSDateFormatter *clockFormat = [RTUtil clockFormatter];
	
	// Convenience/performance variables.
	NSDate *startTime = self.localStore.race.startTime;
	NSLog(@"startTiem: %@", startTime);
	if (!startTime) {
		startTime = [NSDate date];
		self.localStore.race.startTime = startTime;
	}
	if (startTime) {
		NSDate *scheduledFinishTime  = [self calculateScheduledFinishTime];
		NSString *scheduledClockTime = [clockFormat stringFromDate:scheduledFinishTime];
		NSString *scheduledDuration  = [LegTime formatSecondsToString:[scheduledFinishTime timeIntervalSinceDate:startTime]];
		NSDate *projectedFinishTime  = [self calculateProjectedFinishTime];
		NSString *projectedClockTime = [clockFormat stringFromDate:projectedFinishTime];
		NSString *projectedDuration  = [LegTime formatSecondsToString:[projectedFinishTime timeIntervalSinceDate:startTime]];
		
		NSDate *projectedVanExchangeTime = [self calculateProjectedVanExchangeTime];
		NSString *projectedVanExchangeClockTime;
		NSString *projectedVanExchangeDuration;
		if (projectedVanExchangeTime) {
			projectedVanExchangeClockTime = [clockFormat stringFromDate:projectedVanExchangeTime];
			projectedVanExchangeDuration  = [LegTime formatSecondsToString:[projectedVanExchangeTime timeIntervalSinceDate:startTime]];
		} else {
			projectedVanExchangeClockTime = @"--:--";
			projectedVanExchangeDuration  = @"--:--";
		}
		
		// Finish time based purely on initial projections.
		self.scheduledFinishClockLabel.text = scheduledClockTime;
		self.scheduledFinishTimeLabel.text  = scheduledDuration;
		// Projected (live-updating times) or actual times, depending if all legs have been logged or not.
		self.projectedFinishClockLabel.text = projectedClockTime;
		self.projectedFinishTimeLabel.text  = projectedDuration;
		self.nextVanExchangeClockLabel.text = projectedVanExchangeClockTime;
		self.nextVanExchangeTimeLabel.text  = projectedVanExchangeDuration;
		
		self.scheduledFinishClockLabel.textColor =
		self.scheduledFinishTimeLabel.textColor =
		self.projectedFinishClockLabel.textColor =
		self.projectedFinishTimeLabel.textColor =
		self.nextVanExchangeClockLabel.textColor =
		self.nextVanExchangeTimeLabel.textColor =
			[UIColor darkTextColor];
	} else {
		NSString *startNotSet = @"Start time not set";
		self.scheduledFinishClockLabel.text = 
		self.scheduledFinishTimeLabel.text  = 
		self.projectedFinishClockLabel.text =
		self.projectedFinishTimeLabel.text  =
			startNotSet;
		self.scheduledFinishClockLabel.textColor =
		self.scheduledFinishTimeLabel.textColor =
		self.projectedFinishClockLabel.textColor =
		self.projectedFinishTimeLabel.textColor =
			[UIColor groupTableViewBackgroundColor];
	}
	
	// Actual finish times (only displays value if actually finished)
	if (self.localStore.raceIsFinished) {
	} else {
	}
	[self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	switch (section) {
		case 0:
			return @"Start Time";
		case 1:
			return @"Scheduled Finish";
		case 2:
//			NSLog(@"Race is finished: %@", self.localStore.raceIsFinished?@"YES": @"NO");
			return self.localStore.raceIsFinished ? @"Actual Finish" : @"Projected Finish";
		case 3:
			return @"Next Van Exchange";
		case 4:
			return @"Actions";
			
		default:
			break;
	}
	return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//	NSLog(@"number of rows for section %d", section);
	switch (section) {
		case 0:
			return 1;
		case 1:
			return 2;
		case 2:
//			return 2;
			return self.localStore.raceIsFinished ? 2 : 3;
		case 3:
			return 2;
		case 4:
			return 2;
			
		default:
			break;
	}
	return 0;
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    
    return cell;
}
*/
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

 // Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

 // Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}

 // Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//	NSLog(@"selected %@", indexPath);
	int BUTTON_SECTION = 4;
	int s = indexPath.section;
	int r = indexPath.row;
	// EMAIL BUTTON
	if (s == BUTTON_SECTION && r == 0) {
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
	}
	// RESET BUTTON
	else if (s == BUTTON_SECTION && r == 1) {
		[tableView deselectRowAtIndexPath:indexPath animated:YES];
		[self.localStore reset];
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
