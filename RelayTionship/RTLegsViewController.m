//
//  RTLegsViewController.m
//  RelayTionship
//
//  Created by Dru Kepple on 8/21/12.
//  Copyright (c) 2012 Dru Kepple. All rights reserved.
//

#import "RTLegsViewController.h"
#import "Leg.h"
#import "LegTime.h"
#import "RTLegDetailsViewController.h"
#import "RTLegTableCell.h"

@interface RTLegsViewController () {
	NSNumberFormatter *distanceFormatter;
}

@end

@implementation RTLegsViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	distanceFormatter = [[NSNumberFormatter alloc] init];
	distanceFormatter.numberStyle = NSNumberFormatterDecimalStyle;
	distanceFormatter.maximumFractionDigits = 2;
	distanceFormatter.minimumFractionDigits = 1;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) viewWillAppear:(BOOL)animated {
//	NSLog(@"viewWillAppear");
	[super viewWillAppear:animated];
	[self reloadTableData];
}


#pragma mark - Data
- (void)reloadTableData {
	self.legs = self.localStore.allLegs;
	[super reloadTableData];
}


#pragma mark - Table view data source
- (NSInteger) numberOfRunnersPerVan {
	return [self.localStore allRunners].count / [self.localStore allVans].count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//	int runnersPerVan = [self.localStore allRunners].count / [self.localStore allVans].count;
    return self.legs.count / [self numberOfRunnersPerVan];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	int van = section % [self.localStore allVans].count + 1;
	//# (Van num-1 % vans.count) + 1
	return [NSString stringWithFormat:@"Van %d", van];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.legs.count;
//	return [self.localStore allRunners].count / [self.localStore allVans].count;
	return [self numberOfRunnersPerVan];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"legCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    RTLegTableCell *legCell = (RTLegTableCell *)cell;
	
    // Configure the cell...
	Leg *l = [self.localStore legByIndex:indexPath.row + (indexPath.section * [self numberOfRunnersPerVan])];
	NSString *distanceLabel =  [distanceFormatter stringFromNumber:l.distance];
    //cell.textLabel.text = [NSString stringWithFormat:@"Leg %d - %@m", l.numberValue, distanceLabel];
	//cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %.02f", l.runner.name, l.projectedPaceValue];
	
	// Text
	legCell.legLabel.text      = [NSString stringWithFormat:@"Leg %d", l.numberValue];
	legCell.distanceLabel.text = [NSString stringWithFormat:@"%@m", distanceLabel];
	legCell.runnerLabel.text   = l.runner.name;
	legCell.paceLabel.text     = [LegTime formatSecondsToString:l.projectedPaceValue * 60];//[NSString stringWithFormat:@"%.02f", l.projectedPaceValue];
	
	// Position Distance Label to Leg Label
	[legCell.legLabel sizeToFit];
	CGRect legRect = legCell.legLabel.frame;
	CGRect distRect = legCell.distanceLabel.frame;
	distRect.origin.x = legRect.origin.x + legRect.size.width + 6;
	legCell.distanceLabel.frame = distRect;

	// Position Runner Label to Pace Label
	[legCell.paceLabel sizeToFit];
	[legCell.runnerLabel sizeToFit];
	
	CGRect paceRect = legCell.paceLabel.frame;
	CGRect runnerRect = legCell.runnerLabel.frame;
	paceRect.origin.x = 291 - paceRect.size.width;
	runnerRect.origin.x = paceRect.origin.x - runnerRect.size.width - 6;
	legCell.paceLabel.frame = paceRect;
	legCell.runnerLabel.frame = runnerRect;
	
    return legCell;
}

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

#pragma mark - Segue
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	NSString *segId = segue.identifier;
	if ([segId isEqualToString:@"legDetails"]) {
		RTLegDetailsViewController * vc = (RTLegDetailsViewController *)segue.destinationViewController;
//		NSLog(@"vc: %@", vc);
		NSUInteger rowIndex = self.tableView.indexPathForSelectedRow.row;
		NSUInteger sectionIndex = self.tableView.indexPathForSelectedRow.section;
		NSUInteger legIndex = rowIndex + (sectionIndex * [self numberOfRunnersPerVan]);
		NSLog(@"rowIndex:     %d", rowIndex);
		NSLog(@"sectionIndex: %d", sectionIndex);
		vc.leg = [self.localStore legByIndex:legIndex];
		vc.localStore = self.localStore;
	}
}

@end
