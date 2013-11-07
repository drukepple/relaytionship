//
//  RTRunnerViewController.m
//  RelayTionship
//
//  Created by Dru Kepple on 8/21/12.
//  Copyright (c) 2012 Dru Kepple. All rights reserved.
//

#import "RTRunnerViewController.h"
#import "RTPacePicker.h"
#import "RTTeamInputCell.h"
#import "RTRunnerButtonCell.h"
#import "RTTeamValueCell.h"
#import "RTRunnerLegCell.h"
#import "RTLegDetailsViewController.h"

@interface RTRunnerViewController ()

@end


@interface RTRunnerViewController () {
	RTPacePicker *pacePicker;
	UITextField *paceInput;
	NSString *paceBeforeEditing;
}
@end




@implementation RTRunnerViewController

@synthesize totalMilesLabel = _totalMilesLabel;
@synthesize runner = _runner;
@synthesize legs = _legs;



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
//	NSLog(@"viewDidLoad.  runner? %@", self.runner);
	self.nameField.text = self.runner.name;
	self.nameField.delegate = self;
	
	pacePicker = [[RTPacePicker alloc] init];
	pacePicker.paceDelegate = self;

}

- (void)viewDidUnload {
    [self setTotalMilesLabel:nil];
	[self setNameField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewWillAppear:(BOOL)animated {
	NSLog(@"View will appear");
	[super viewWillAppear:animated];
	self.title = [NSString stringWithFormat:@"Runner %d", self.runner.numberValue];
//	self.title = self.runner.name;
	[self.tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
//	NSLog(@"runner detail will disappear");
	[self textFieldDidEndEditing:self.nameField];
}


#pragma mark - Local Store
//- (void) reloadTableData {
//	self.runner = (Runner *)[self.localStore fetchFirstEntityOfName:@"Runner" withPredicate:@"number = %d", 1];
//	[super reloadTableData];
//}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	switch (section) {
		case 0:
			return 2;
		case 1:
			return 5;
		default:
			return 0;
	}
}


// Main Table Setup right Here
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *InputCellIdentifier  = @"teamCellInput";
    static NSString *LabelCellIdentifier  = @"teamCellValue";
    static NSString *LegCellIdentifier    = @"teamCellLeg";
    static NSString *ButtonCellIdentifier = @"teamCellButton";
	
	
	NSString *cellId;
    UITableViewCell *cell;
	
	switch (indexPath.section) {
		case 0:
			switch (indexPath.row) {
				case 0: {
					cellId = InputCellIdentifier;
					RTTeamInputCell *inpCell = (RTTeamInputCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
					inpCell.label.text = @"Name:";
					inpCell.input.text = self.runner.name;
					inpCell.input.delegate = self;
					inpCell.input.tag = 1;
					inpCell.input.returnKeyType = UIReturnKeyDone;
					cell = inpCell;
					break;
				}
				case 1: {
					cellId = ButtonCellIdentifier;
					RTRunnerButtonCell *btnCell = (RTRunnerButtonCell*)[tableView dequeueReusableCellWithIdentifier:cellId];
					btnCell.label.text = @"Import From Contacts";
					cell = btnCell;
					break;
				}
			}
			break;
		case 1:
			switch (indexPath.row) {
				case 0: {
					cellId = LabelCellIdentifier;
					RTTeamValueCell *valCell = (RTTeamValueCell*)[tableView dequeueReusableCellWithIdentifier:cellId];
					valCell.label.text = @"Total Miles:";
					float totalMiles = 0.0;
					for (Leg *l in self.legs) {
						totalMiles += l.distanceValue;
					}
					valCell.value.text = [NSString stringWithFormat:@"%.02f mi", totalMiles];
					cell = valCell;
					break;
				}
				case 1: {
					cellId = InputCellIdentifier;
					RTTeamInputCell *inpCell = (RTTeamInputCell*)[tableView dequeueReusableCellWithIdentifier:cellId];
					cell = inpCell;
					inpCell.label.text = @"Default Pace:";
					inpCell.input.delegate = self;
					inpCell.input.tag = 2;
					inpCell.input.text = [LegTime formatSecondsToString: self.runner.defaultPaceValue * 60.0];
					inpCell.input.inputView = pacePicker;
					inpCell.labelWidth = 100;
					inpCell.input.clearButtonMode = UITextFieldViewModeNever;
					inpCell.input.hidesCursor = YES;
					paceInput = inpCell.input;
					
					UIToolbar* pacePickerToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
					pacePickerToolbar.barStyle = UIBarStyleBlackTranslucent;
					pacePickerToolbar.items = [NSArray arrayWithObjects:
										   [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelPacePicker)],
										   [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
										   [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithPacePicker)],
										   nil];
					[pacePickerToolbar sizeToFit];
					paceInput.inputAccessoryView = pacePickerToolbar;
					
					

					
					break;
				}
				case 2:
				case 3:
				case 4: {
					cellId = LegCellIdentifier;
					RTRunnerLegCell *legCell = (RTRunnerLegCell*)[tableView dequeueReusableCellWithIdentifier:cellId];
					Leg *l = [self.legs objectAtIndex:indexPath.row-2];
					[legCell populateLegNumber:l.numberValue distance:l.distanceValue pace:[LegTime formatSecondsToString:l.projectedPaceValue * 60]];
					cell = legCell;
					break;
				}
				default:
					break;
			}
			break;
		default:
			break;
			
	}
    
    return cell;
}


- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	switch (section) {
		case 0:
			return @"Runner Info";
		case 1:
			return @"Legs";
		default:
			return nil;
	}
}

// Override to support conditional editing of the table view.
/*
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

// Override to support editing the table view.
/*
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

// Override to support rearranging the table view.
/*
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

// Override to support conditional rearranging of the table view.
/*
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 0 && indexPath.row == 2) {
		NSLog(@"CONTACTS");
	}
	else if (indexPath.section == 1) {
		if (indexPath.row > 2) {
			NSLog(@"leg:");
		}
	}
}


#pragma mark - Contacts
- (IBAction)importFromContactsTap:(id)sender {
	NSLog(@"import from contacts");
	ABPeoplePickerNavigationController *contacts = [[ABPeoplePickerNavigationController alloc] init];
	contacts.peoplePickerDelegate = self;
	[self presentModalViewController:contacts animated:YES];
}

- (void) peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker {
	[self dismissModalViewControllerAnimated:YES];
}

- (BOOL) peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person {
	NSString *firstName = (__bridge_transfer NSString*)ABRecordCopyValue(person, kABPersonFirstNameProperty);
	NSString *lastName  = (__bridge_transfer NSString*)ABRecordCopyValue(person, kABPersonLastNameProperty);
	NSString *name;
	if (firstName && lastName) {
		name = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
	} else if (firstName) {
		name = firstName;
	} else if (lastName) {
		name = lastName;
	}
	
	NSLog(@"person: %@", name);
	if (name) {
		self.nameField.text = name;
	}
	[self dismissModalViewControllerAnimated:YES];
	return YES;
}

- (BOOL) peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
	[self dismissModalViewControllerAnimated:YES];
	return NO;
}



#pragma mark - Storyboard
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	NSString *segId = segue.identifier;
	if ([segId isEqualToString:@"runnerLeg"]) {
		RTLegDetailsViewController *vc = (RTLegDetailsViewController *)segue.destinationViewController;
		NSIndexPath *i = [self.tableView indexPathForCell:sender];
		vc.leg = [self.legs objectAtIndex:i.row-2];
		vc.localStore = self.localStore;
	}
}



#pragma mark - Setters / Getters
- (void) setRunner:(Runner *)runner {
	if (_runner != runner) {
		_runner = runner;
		// Have to access legs individually to prevent faulting.
		for (Leg *l in self.runner.legs) {
			int num = l.numberValue;
			num++;
		}
		NSSortDescriptor *descriptors = [NSSortDescriptor sortDescriptorWithKey:@"number" ascending:YES];
		self.legs = [self.runner.legs sortedArrayUsingDescriptors:[NSArray arrayWithObject:descriptors]];
	}
}



#pragma mark - Pace Text Field
- (void) textFieldDidBeginEditing:(UITextField *)textField {
//	NSLog(@"textFieldDidBeginEditing");
	switch (textField.tag) {
		case 1:
//			NSLog(@"\tName field");
			break;
		case 2:
//			NSLog(@"\tPace field");
			pacePicker.paceTime = paceBeforeEditing = textField.text;
			break;
			
		default:
			break;
	}
//	if (textField.tag == 2) {
//		pacePicker.paceTime = textField.text;
//	}
}
//- (void) textFieldDidEndEditing:(UITextField *)textField {
//
//}
#pragma mark - UITextFieldDelegate
- (void) textFieldDidEndEditing:(UITextField *)textField {
//	NSLog(@"textFieldDidEndEditing");
	
	// Tried this as a swtich statement but for some reason it caused errors...
	if (textField.tag ==1) {
		NSIndexPath *nameIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
		RTTeamInputCell *nameCell = (RTTeamInputCell *) [self.tableView cellForRowAtIndexPath:nameIndexPath];
		UITextField *nameField = nameCell.input;
//		NSLog(@"nameField: %@", nameField);
		//	if (textField == nameField) {
		self.runner.name = nameField.text;
		//	}
		[nameField resignFirstResponder];
		[self.localStore saveContext];
	} else if (textField.tag == 2) {
		
	} else {
		
	}
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
	if (textField.tag == 1) {
		[textField resignFirstResponder];
		return YES;
	} else {
		return YES;
	}
}



#pragma mark Pace Picker Delegate
- (void) pacePicker:(RTPacePicker *)picker didSelectPace:(float)paceValue {
//	NSLog(@"picker: %@", picker);
	paceInput.text = picker ? picker.paceTime : [pacePicker paceTimeForValue:paceValue];
	float oldDefaultPace = self.runner.defaultPaceValue;
	for (Leg *l in self.runner.legs) {
		if (l.projectedPaceValue == oldDefaultPace) {
			l.projectedPaceValue = paceValue;
		}
	}
	self.runner.defaultPaceValue = paceValue;
	//[self reloadTableData];
	NSArray *legIndices = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:2 inSection:1],
						   [NSIndexPath indexPathForRow:3 inSection:1],
						   [NSIndexPath indexPathForRow:4 inSection:1], nil];
	[self.tableView reloadRowsAtIndexPaths:legIndices withRowAnimation:UITableViewRowAnimationNone];
}




//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//	
//    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
//    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
//    numberToolbar.items = [NSArray arrayWithObjects:
//						   [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
//						   [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
//						   [[UIBarButtonItem alloc]initWithTitle:@"Apply" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
//						   nil];
//    [numberToolbar sizeToFit];
//    numberTextField.inputAccessoryView = numberToolbar;
//}

-(void)cancelPacePicker {
	[self pacePicker:nil didSelectPace:8.0];
    [paceInput resignFirstResponder];
}

-(void)doneWithPacePicker {
    [paceInput resignFirstResponder];
}



@end
