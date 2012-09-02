//
//  RTLegDetailsViewController.m
//  RelayTionship
//
//  Created by Dru Kepple on 8/21/12.
//  Copyright (c) 2012 Dru Kepple. All rights reserved.
//

#import "RTLegDetailsViewController.h"
#import "RTUtil.h"



@interface RTLegDetailsViewController () {
	RTPacePicker *pacePicker;
	RTDurationPicker *durationPicker;
	NSNumberFormatter *distanceFormatter;
}
- (void) textFieldDidEndEditing:(UITextField *)textField;
- (void) calculateLegTimes:(id)source;
@end



@implementation RTLegDetailsViewController

@synthesize leg = _leg;
@synthesize distanceField = _distanceField;
@synthesize paceField = _paceField;
@synthesize durationField = _durationField;
@synthesize startTimeLabel = _startTimeLabel;
@synthesize endTimeLabel = _endTimeLabel;



- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.distanceField.keyboardType = UIKeyboardTypeDecimalPad;
	self.distanceField.delegate = self;
	self.paceField.keyboardType = UIKeyboardTypeDecimalPad;
	self.paceField.delegate = self;
	
	distanceFormatter = [[NSNumberFormatter alloc] init];
	distanceFormatter.numberStyle = NSNumberFormatterDecimalStyle;
	distanceFormatter.maximumFractionDigits = 2;
	distanceFormatter.minimumFractionDigits = 1;
	
	self.paceField.delegate = self;
	pacePicker = [[RTPacePicker alloc] init];
	pacePicker.paceDelegate = self;
	self.paceField.inputView = pacePicker;
	
	self.durationField.delegate = self;
	durationPicker = [[RTDurationPicker alloc] init];
	durationPicker.durationDelegate = self;
	self.durationField.inputView = durationPicker;
}

- (void)viewDidUnload {
	[self setDistanceField:nil];
    [self setPaceField:nil];
	[self setDurationField:nil];
	[self setStartTimeLabel:nil];
	[self setEndTimeLabel:nil];
    [super viewDidUnload];
}

- (void) viewWillAppear:(BOOL)animated {
	self.distanceField.text = [distanceFormatter stringFromNumber:self.leg.distance];
	//self.paceField.text     = [distanceFormatter stringFromNumber:self.leg.projectedPace];
	self.paceField.text     = [LegTime formatSecondsToString:self.leg.projectedPaceValue * 60.0];
	[self calculateLegTimes:self.paceField];
	self.title = [NSString stringWithFormat:@"Leg %d: %@", self.leg.numberValue, self.leg.runner.name];
}
- (void) viewWillDisappear:(BOOL)animated {
	[self textFieldDidEndEditing:self.distanceField];
	//[self textFieldDidEndEditing:self.paceField];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

/*- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
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
	[self.view endEditing:YES];
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

#pragma mark - Text Field Delegate
- (void) textFieldDidBeginEditing:(UITextField *)textField {
	if (textField == self.paceField) {
		pacePicker.paceValue = self.leg.projectedPaceValue;
//		int mins = floor(self.leg.projectedPaceValue);
//		int secs = round((self.leg.projectedPaceValue - mins) * 60);
//		[pacePicker selectRow:mins inComponent:0 animated:NO];
//		[pacePicker selectRow:secs inComponent:2 animated:NO];
	}
	else if (textField == self.durationField) {
//		NSDictionary *comps = durationPicker.durationComponents;
//		float hrs  = ((NSNumber *)[comps objectForKey:@"h"]).floatValue;
//		float mins = ((NSNumber *)[comps objectForKey:@"m"]).floatValue;
//		float secs = ((NSNumber *)[comps objectForKey:@"s"]).floatValue;
//
//		[durationPicker selectRow:hrs  inComponent:0 animated:NO];
//		[durationPicker selectRow:mins inComponent:2 animated:NO];
//		[durationPicker selectRow:secs inComponent:4 animated:NO];
		durationPicker.durationTime = self.durationField.text;
	}
}

- (void) textFieldDidEndEditing:(UITextField *)textField {
	if (textField == self.distanceField) {
		self.leg.distanceValue = self.distanceField.text.doubleValue;
	} else if (textField == self.paceField) {
		//self.leg.projectedPaceValue = self.paceField.text.floatValue;
		//[self pickerView:pacePicker didSelectRow:0 inComponent:0];
		[self pacePicker:pacePicker didSelectPace:pacePicker.paceValue];
	}
	[self.localStore saveContext];
}

# pragma mark - Picker Delegates

- (void) pacePicker:(RTPacePicker *)picker didSelectPace:(float)paceValue {
	self.paceField.text = pacePicker.paceTime;
	self.leg.projectedPaceValue = paceValue;
	[self calculateLegTimes:self.paceField];
}

- (void) durationPicker:(RTDurationPicker *)picker didSelectDuration:(float)durationValue {
	self.durationField.text = durationPicker.durationTime;
	[self calculateLegTimes:self.durationField];
}

#pragma mark - Calculated Fields
- (void) calculateLegTimes:(id)source {
	if (source == self.paceField) {
		float duration = self.leg.distanceValue * self.leg.projectedPaceValue;
		self.durationField.text = [LegTime formatSecondsToString:duration * 60.0];
	}
	else if (source == self.durationField) {
		float duration = durationPicker.durationValue;
		self.leg.projectedPaceValue = duration / self.leg.distanceValue;
		self.paceField.text = [LegTime formatSecondsToString:self.leg.projectedPaceValue * 60.0];
	}
	
	NSDate *legStart  = [self.localStore calculateTimeToFinishOfLeg:self.leg.numberValue-1 projected:YES];
	NSDate *legFinish = [self.localStore calculateTimeToFinishOfLeg:self.leg.numberValue projected:YES];
	if (legStart) {
		NSDateFormatter *clockFormat = [RTUtil clockFormatter];
		self.startTimeLabel.text = [clockFormat stringFromDate:legStart];
		self.endTimeLabel.text   = [clockFormat stringFromDate:legFinish];
		self.startTimeLabel.textColor = [UIColor darkTextColor];
		self.endTimeLabel.textColor   = [UIColor darkTextColor];
	} else {
		self.startTimeLabel.text = @"Race Start Time Not Set";
		self.endTimeLabel.text   = @"Race Start Time Not Set";
		self.startTimeLabel.textColor = [UIColor groupTableViewBackgroundColor];
		self.endTimeLabel.textColor   = [UIColor groupTableViewBackgroundColor];
	}
}

@end
