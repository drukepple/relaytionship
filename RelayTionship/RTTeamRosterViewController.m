//
//  RTTeamRosterViewController.m
//  RelayTionship
//
//  Created by Dru Kepple on 8/18/12.
//  Copyright (c) 2012 Dru Kepple. All rights reserved.
//

#import "RTTeamRosterViewController.h"
#import "Runner.h"
#import "RTRunnerViewController.h"

@interface RTTeamRosterViewController ()

@end


@implementation RTTeamRosterViewController

@synthesize runners = _runners;




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
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewWillAppear:(BOOL)animated {
//	NSLog(@"roster view will appear");
	[super viewWillAppear:animated];
	[self reloadTableData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.localStore fetchAllEntitiesOfName:@"Van"].count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSString *predicate = [NSString stringWithFormat:@"van.number = %d", section + 1];
	return [self.localStore fetchEntitiesOfName:@"Runner" withPredicate:predicate].count;
//	return self.runners.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return [NSString stringWithFormat:@"Van %d", section + 1];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"RunnerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
//	NSString *predicate = [NSString stringWithFormat:@"number = %d", indexPath.row];
//	NSLog(@"Predicate sim: number = %d AND van.number = %d", indexPath.row+1, indexPath.section+1);
//	Runner *r = (Runner *)[self.localStore fetchFirstEntityOfName:@"Runner" withPredicate:@"number = %d AND van.number = %d", indexPath.row+1 + (indexPath.section * 6), indexPath.section+1];
//	Runner *r = (Runner *)[self.runners objectAtIndex:indexPath.row];
	Runner *r = [self.localStore runnerByIndexPath:indexPath];
    cell.textLabel.text = r.name;
    
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

#pragma mark - LocalStore
//- (void) setLocalStore:(RTCoreDataAgent *)localStore {
//	[super setLocalStore:localStore];
//	NSLog(@"TEAM ROSTER setLocalStore");
//	[self reloadTableData];
//}

- (void) reloadTableData {
	self.runners = [self.localStore fetchAllEntitiesOfName:@"Runner" sortedOn:@"number" ascending:YES];
	[super reloadTableData];
}

#pragma mark - Storyboard
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	NSString *segId = segue.identifier;
	if ([segId isEqualToString:@"runnerDetail"]) {
		RTRunnerViewController *vc = (RTRunnerViewController*) segue.destinationViewController;
		vc.runner = [self.localStore runnerByIndexPath:self.tableView.indexPathForSelectedRow];
		vc.localStore = self.localStore;
	}
}


@end
