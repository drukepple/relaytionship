//
//  RTTimerViewController.m
//  RelayTionship
//
//  Created by Dru Kepple on 8/22/12.
//  Copyright (c) 2012 Dru Kepple. All rights reserved.
//

#import "RTTimerViewController.h"

@interface RTTimerViewController ()
- (void) reloadTableData;
- (NSString *) formatTimeFromSeconds:(NSTimeInterval)secs;
- (void) recordLegTime;
- (void) scrollToBottom;
- (void) updateLegButtonText;
- (void) updateProjectedTimeText;
- (void) startStopwatch;
- (void) stopStopwatch;
@end

static NSString *legButtonStartText = @"Start";
static NSString *legButtonLegText   = @"New Leg";
static NSString *legButtonStopText  = @"Stop";

@implementation RTTimerViewController
@synthesize legTimeLabel;
@synthesize projectedTimeLabel;
@synthesize tableView;
@synthesize legButton;

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
	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	self.legButton.titleLabel.textAlignment = UITextAlignmentCenter;
	
	[self updateLegButtonText];
	
	timeFormatter = [[NSDateFormatter alloc] init];
	timeFormatter.timeStyle = NSDateFormatterMediumStyle;
	timeFormatter.dateStyle = NSDateFormatterNoStyle;
	
//	stopwatchTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateStopwatch) userInfo:nil repeats:YES];
	stopwatchTimer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(updateStopwatch) userInfo:nil repeats:YES];
}

- (void)viewDidUnload {
    [self setLegTimeLabel:nil];
    [self setProjectedTimeLabel:nil];
    [self setTableView:nil];
	[self setLegButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewWillAppear:(BOOL)animated {
	[self reloadTableData];
//	if (self.localStore.isTiming) {
//		NSLog(@"is timing");
////		self..text = @"New Leg";
//	} else {
//		NSLog(@"not timing");
//		self.legTimeLabel.text = @"Start";
//	}
	NSLog(@"viewWillAppear");
	if (self.localStore.isTiming) {
		NSLog(@"    isTiming");
		[self startStopwatch];
	}
}


#pragma mark - Stopwatch
- (void) updateStopwatch {
//	NSLog(@"stopwatch");
	LegTime *currentTime = [legTimes lastObject];
	NSTimeInterval soFar = [currentTime.startTime timeIntervalSinceNow];
	soFar = -soFar;
//	NSLog(@"%f", soFar);
	NSString *timeString = [self formatTimeFromSeconds:soFar];
	self.legTimeLabel.text = timeString;
	
	[self updateProjectedTimeText];
}
- (void) startStopwatch {
	[[NSRunLoop mainRunLoop] addTimer:stopwatchTimer forMode:NSRunLoopCommonModes];
}
-(void) stopStopwatch {
	[stopwatchTimer invalidate];
}



#pragma mark - Table View Datasource
- (void) reloadTableData {
	legTimes = [self.localStore allLegTimes];
	[self.tableView reloadData];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return legTimes.count;
}

- (UITableViewCell*) tableView:(UITableView *)table cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *cellId = @"legTimeCell";
	UITableViewCell *cell = [table dequeueReusableCellWithIdentifier:cellId];
	
	LegTime *l = [legTimes objectAtIndex:indexPath.row];
	cell.textLabel.text = [NSString stringWithFormat:@"Leg %d", l.leg.numberValue];
	if (l.endTime != nil) {
		cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [self formatTimeFromSeconds:l.elapsedTime]];
		cell.detailTextLabel.textColor = [UIColor darkTextColor];
	} else {
		cell.detailTextLabel.text = @"In Progress";
		cell.detailTextLabel.textColor = [UIColor lightGrayColor];
	}
	return cell;
}

- (NSString *) formatTimeFromSeconds:(NSTimeInterval)timeInterval {
	int secs = round(timeInterval);
	NSString *timeString;
	if (secs < 60) {
		timeString = [NSString stringWithFormat:@"0:%02d", secs];
	} else if (secs < 60 * 60) {
		int mins = floor((float)secs/60.0);
		secs -= mins * 60;
		timeString = [NSString stringWithFormat:@"%d:%02d", mins, secs];
	} else {
		int hrs = floor((float)secs/(60.0*60.0));
		secs -= hrs * 60 * 60;
		int mins = floor((float)secs/60.0);
		secs -= mins * 60;
		timeString = [NSString stringWithFormat:@"%d:%02d:%02d", hrs, mins, secs];
	}
	return timeString;
}

#pragma mark - Table View Delegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
}



#pragma mark - Button Taps
- (void) updateLegButtonText {
	if (self.localStore.isTiming) {
		if (self.localStore.allLegs.count-1 == self.localStore.allLegTimes.count) {
			[self.legButton setTitle:legButtonStopText forState:UIControlStateNormal];
		} else {
			[self.legButton setTitle:legButtonLegText forState:UIControlStateNormal];
		}
	} else {
		[self.legButton setTitle:legButtonStartText forState:UIControlStateNormal];
	}
}

- (void) updateProjectedTimeText {
	LegTime *currentTime = [legTimes lastObject];
	if (currentTime.mileageForProjectionValue > 0) {
		NSDate *projectedEnd = currentTime.projectedEndTime;
		NSTimeInterval projectedTime = [projectedEnd timeIntervalSinceNow];
		self.projectedTimeLabel.text = [self formatTimeFromSeconds:projectedTime];
	} else {
		self.projectedTimeLabel.text = @"--:--";
		
		// @TODO add projected time to legTime model
		
	}
}

- (void) doStart {
	[self.legButton setTitle:legButtonLegText forState:UIControlStateNormal];
	self.localStore.isTiming = YES;
	[self startStopwatch];
	/*LegTime *l = */[self.localStore makeLegTime];
	[self reloadTableData];
}
- (void) recordLegTime {
	LegTime *lastLegTime = [legTimes lastObject];
	lastLegTime.endTime = [NSDate date];
	[self.localStore saveContext];
}
- (void) scrollToBottom {
	NSIndexPath* indexPath = [NSIndexPath indexPathForRow:self.localStore.allLegTimes.count-1 inSection:0];
	[self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}
- (void) doLeg {
	if (self.localStore.allLegs.count-1 == self.localStore.allLegTimes.count) {
		[self.legButton setTitle:legButtonStopText forState:UIControlStateNormal];
	}
	[self recordLegTime];
//	NSLog(@"+++++++++++++++++++++++++++++++\nlastLegTime: %@", lastLegTime);
	/*LegTime *l = */[self.localStore makeLegTime];
	[self reloadTableData];
	[self updateProjectedTimeText];
	[self scrollToBottom];
}

- (void) doStop {
	self.localStore.isTiming = NO;
	[self recordLegTime];
	[self reloadTableData];
	[self updateProjectedTimeText];
	[self scrollToBottom];
}

- (IBAction)newLegTap:(id)sender {
	NSString *btnText = self.legButton.titleLabel.text;
	if ([btnText isEqualToString:legButtonStartText]) {
		[self doStart];
	} else if ([btnText isEqualToString:legButtonLegText]) {
		[self doLeg];
	} else if ([btnText isEqualToString:legButtonStopText]) {
		[self doStop];
	} else {
		NSLog(@"Couldn't match text");
	}
}

- (IBAction)runnerPassTap:(id)sender {
//	[self updateProjectedTimeText];
}



#pragma mark - Runner Passed VC Delegate

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	NSString *segId = segue.identifier;
	if ([segId isEqualToString:@"runnerPassedModal"]) {
		RTRunnerPassedViewController *vc = (RTRunnerPassedViewController *)segue.destinationViewController;
		vc.delegate = self;
	}
}

- (void)runnerPassedViewControllerDidCancel:(RTRunnerPassedViewController *)viewController {
	[self dismissModalViewControllerAnimated:YES];
	viewController.delegate = nil;
}

- (void)runnerPassedViewControllerDidSave:(RTRunnerPassedViewController *)viewController withMileage:(float)mileage {
//	[self dismissModalViewControllerAnimated:YES];
//	viewController.delegate = nil;
	// This just dismisses the modal and cleans up...DRY.
	[self runnerPassedViewControllerDidCancel:viewController];
	NSLog(@"mileage: %f", mileage);
	
	// Store the mileage
	LegTime *currentTime = [legTimes lastObject];
	currentTime.mileageForProjectionValue = mileage;
	// Store the projected time
	NSTimeInterval elapsedSoFar = -[currentTime.startTime timeIntervalSinceNow];
	float distance      = currentTime.leg.distanceValue;
	float progress      = currentTime.mileageForProjectionValue;
	float secsPerMile   = elapsedSoFar / progress;
	float projectedTime = secsPerMile * distance;
	currentTime.secondsForProjectionValue = projectedTime;
	// Store the project time as a date.
	NSDate *projectedEndTime = [[NSDate date] dateByAddingTimeInterval:projectedTime];
	currentTime.projectedEndTime = projectedEndTime;
	
	[self.localStore saveContext];
	
	NSLog(@"elapsedSoFar:  %f", elapsedSoFar);
	NSLog(@"distance:      %f", distance);
	NSLog(@"pregress:      %f", progress);
	NSLog(@"secsPerMile:   %f", secsPerMile);
	NSLog(@"projectedTime: %f", projectedTime);

	
	[self updateProjectedTimeText];
}

@end
