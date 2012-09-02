//
//  RTLegTimeDetailViewController.m
//  RelayTionship
//
//  Created by Dru Kepple on 8/23/12.
//  Copyright (c) 2012 Dru Kepple. All rights reserved.
//

#import "RTLegTimeDetailViewController.h"
#import "LegTime.h"

@interface RTLegTimeDetailViewController ()

@end


@implementation RTLegTimeDetailViewController

@synthesize leg = _leg;



- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	keys = [NSArray arrayWithObjects:@"Leg", @"Runner", @"Distance", @"Time", @"Pace", nil];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return keys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"legTimeDetailsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
	NSString *key = [keys objectAtIndex:indexPath.row];
	NSString *value;
	NSTimeInterval secs;
	Leg *leg = self.leg;
	LegTime *time = leg.legTime;
	//NSLog(@"Leg: %@", leg);
	
    switch (indexPath.row) {
		case 0:
			//key = @"Leg";
			value = [leg.number stringValue];
			break;
			
		case 1:
			//key = @"Runner";
			value = leg.runner.name;
			break;
		
		case 2:
			//key = @"Distance";
			value = [NSString stringWithFormat:@"%.01f miles", leg.distanceValue];
			break;
			
		case 3:
			//key = @"Time";
			secs = [time.endTime timeIntervalSinceDate:time.startTime];
			value = [LegTime formatSecondsToString:secs];
			break;
			
		case 4:
			//key = @"Pace";
			secs = [time.endTime timeIntervalSinceDate:time.startTime];
			value = [LegTime formatSecondsToString:secs / leg.distanceValue];
			break;
			
		default:
			break;
	}
	
	cell.textLabel.text = key;
	cell.detailTextLabel.text = value;
    
    return cell;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}



#pragma mark - Setters / Getters
- (void) setLeg:(Leg *)leg {
	_leg = leg;
	[self.tableView reloadData];
}


@end
