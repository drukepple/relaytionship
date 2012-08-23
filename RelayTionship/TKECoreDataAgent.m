//
//	SPCoreDataUtils.m
//	Sync Service Scrutinzer
//
//	Created by Dru Kepple on 3/26/11.
//	Copyright 2011 __MyCompanyName__. All rights reserved.
//

/*
 * It's recommended that you actually subclass this class, so that you can add your own convenience methods specific to a 
 * given project.  The direction below outline how to integrate this class into a project.  However, it's easier to go ahead
 * and subclass TKECoreDataAgent, and even if you don't add any extra functionality until later, having it in place per
 * the directions below makes adding custom methods much easier.
 * 
 * When integrating to existing CoreData application, do this:
 * 1: In The AppDelegate.h, remove these lines:
 *		@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
 *		@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
 *		@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
 *		- (void)saveContext;
 *		- (NSURL *)applicationDocumentsDirectory;
 * 
 * 2: Replace them with this:
 *		@property (nonatomic, readonly) TKECoreDataAgent *localStore;
 * 
 * 3: In the AppDelegate.m, remove these lines:
 *		@synthesize managedObjectContext = __managedObjectContext;
 *		@synthesize managedObjectModel = __managedObjectModel;
 *		@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;
 * 
 * 4: Replace them with this:
 *		@synthesize localStore = _localStore;
 *
 * 5: Still in AppDelegate.m, delete the methods from `saveContext` to `applicationDocumentsDirectory`.
 *		It should also include these methods: `persistentStoreCoordinator`,
 *		`managedObjectModel`, and `managedObjectContext`
 *	  These methods are now contined in TKECoreDataAgent, if you need them.
 * 
 * 5: In AppDelegate.m, method `application:didFinishLaunchingWithOptions:`, change this line:
 *		controller.managedObjectContext = self.managedObjectContext;
 *    To something like this:
 *		_localStore = [[TKECoreDataAgent alloc] initWithStoreName:@"AppModel"];
 *    Make sure the store name is the name of your Core Data xcdatamodeld file (without the extension).
 *    Then pass this object around instead of the manageObjectContext as before.  So you might fully
 *    replace the template code with this as the next line
 *		homeViewController.localStore = self.localStore;
 *
 * 6: In AppDelegate.m, method `applicationWillTerminate:`, change this line:
 *		[self saveContext];
 *    to:
 *		[self.localStore saveContext];
 *
 * 7: In [MainViewController].h, change this:
 *		@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
 *    to
 *		@property (strong, nonatomic) TKECoreDataAgent *localStore;
 *
 * 8: In [MainViewController].m, change this:
 *		@synthesize managedObjectContext = _managedObjectContext;
 *    to
 *		@synthesize localStore = _localStore;
 * 
 */

#import "TKECoreDataAgent.h"



@implementation TKECoreDataAgent


@synthesize managedObjectContext=__managedObjectContext;
@synthesize managedObjectModel=__managedObjectModel;
@synthesize persistentStoreCoordinator=__persistentStoreCoordinator;


- (id) init {
	return [self initWithStoreName:@"DataModel"];
}

- (id) initWithStoreName:(NSString *)storeName {
	if ((self = [super init])) {
		_storeName = storeName;
	}
	return self;
}

- (void) dealloc {
}


- (void)saveContext {
	//NSLog(@"Trying to save.");
	NSError *error = nil;
	NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
//	NSLog(@"Do we have an MOC? %@", managedObjectContext);
	if (managedObjectContext != nil) {
//		NSLog(@"Yup...");
		if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
			/*
			 Replace this implementation with code to handle the error appropriately.
			 
			 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be usefdul during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
			 */
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
		} 
//		NSLog(@"=====================================================\n=== SAVED ====\n====================================================================");
	} else {
//		NSLog(@"Nope.");
	}
}

- (NSURL *)storePathURL {
	NSString *storeName = [[NSString alloc] initWithFormat:@"%@.sqlite", _storeName];
	NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:storeName];
	return storeURL;
}

- (void) deleteLocalStore {
	// Delete the sqlite file.
	NSFileManager *fileMan = [NSFileManager defaultManager];
	NSError *error = nil;
	NSURL *storeURL = [self storePathURL];
	BOOL removeSuccess = [fileMan removeItemAtURL:storeURL error:&error];
	if (removeSuccess) {
		NSLog(@"File removed: %@", [storeURL path]);
	} else {
		NSLog(@"File not removed: %@", [storeURL path]);
	}
	if (error) {
		removeSuccess = NO;
		NSLog(@"Error removing asset at path: %@\n\t%@", [storeURL path], [error localizedDescription]);
	}
	
	
	// Reset ivars to nil.
	if (removeSuccess) {
		__managedObjectContext = nil;
		__managedObjectModel = nil;
		if (__persistentStoreCoordinator != nil) __persistentStoreCoordinator = nil;
	}
}



#pragma mark - Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext {
	if (__managedObjectContext != nil) {
		return __managedObjectContext;
	}
	
	NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
	if (coordinator != nil) {
		__managedObjectContext = [[NSManagedObjectContext alloc] init];
		[__managedObjectContext setPersistentStoreCoordinator:coordinator];
	}
	
	//NSLog(@"MOC staleness:%f", [__managedObjectContext stalenessInterval]);
	[__managedObjectContext setStalenessInterval:0.0];
	//NSLog(@"MOC staleness:%f", [__managedObjectContext stalenessInterval]);
	
	return __managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel {
	if (__managedObjectModel != nil) {
		return __managedObjectModel;
	}
	NSURL *modelURL = [[NSBundle mainBundle] URLForResource:_storeName withExtension:@"momd"];
	if (!modelURL) {
		modelURL = [[NSBundle mainBundle] URLForResource:_storeName withExtension:@"mom"];
	}
	//NSLog(@"modelURL: %@", modelURL);
	__managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
	//NSLog(@"__managedObjectModel: %@", __managedObjectModel);
	return __managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 
 No versioning check right now.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
	if (__persistentStoreCoordinator != nil) {
		return __persistentStoreCoordinator;
	}
	
//	NSString *storeName = [[NSString alloc] initWithFormat:@"%@.sqlite", _storeName];
//	NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:storeName];
//	[storeName release];
	NSURL *storeURL = [self storePathURL];
	
	NSError *error = nil;
	__persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
	if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 
		 Typical reasons for an error here include:
		 * The persistent store is not accessible;
		 * The schema for the persistent store is incompatible with current managed object model.
		 Check the error message to determine what the actual problem was.
		 
		 
		 If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
		 
		 If you encounter schema incompatibility errors during development, you can reduce their frequency by:
		 * Simply deleting the existing store:
		 [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
		 
		 * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
		 [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
		 
		 Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
		 
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}	 
	
	return __persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory {
	return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}




#pragma mark - Creating Entities
/**
 * Creates and returns a given Entity for the default managed object context.
 */
- (NSManagedObject *) insertEntityWithName:(NSString *)name {
	return [NSEntityDescription insertNewObjectForEntityForName:name inManagedObjectContext:self.managedObjectContext];
}

/**
 * Creates and returns a given Entity that is NOT associated with any context.
 */
- (NSManagedObject *) createEntityWithName:(NSString *)name {
	//return [NSEntityDescription insertNewObjectForEntityForName:name inManagedObjectContext:nil];
	NSEntityDescription *ent = [NSEntityDescription entityForName:name inManagedObjectContext:self.managedObjectContext];
	NSManagedObject *mo = [[NSManagedObject alloc] initWithEntity:ent insertIntoManagedObjectContext:nil];
	return mo;
}




- (void) deleteEntity: (NSManagedObject *)entity {
	[self.managedObjectContext deleteObject:entity];
}



#pragma mark - Fetch Requests
- (NSFetchRequest *) fetchRequestWithEntityName:(NSString *)name {
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:[NSEntityDescription entityForName:name inManagedObjectContext:self.managedObjectContext]];
	return request;
}

- (NSArray *) fetchAllEntitiesOfName:(NSString *)name {
	NSFetchRequest *r = [self fetchRequestWithEntityName:name];
	NSError *error = nil;
	NSArray * result = [self.managedObjectContext executeFetchRequest:r error:&error];
	if (error) {
		NSLog(@"Error executing fetch request: %@", [error localizedDescription]);
		return nil;
	}
	return result;
	
}

- (NSArray *) fetchAllEntitiesOfName:(NSString *)name sortedBy:(NSSortDescriptor *)sort {
	NSFetchRequest *r = [self fetchRequestWithEntityName:name];
	NSError *error = nil;
	[r setSortDescriptors:[NSArray arrayWithObject:sort]];
	NSArray *result = [self.managedObjectContext executeFetchRequest:r error:&error];
	if (error) {
		NSLog(@"Error executing fetch request: %@", [error localizedDescription]);
		return nil;
	}
	return result;
}

- (NSArray *) fetchAllEntitiesOfName:(NSString *)name sortedOn:(NSString *)sortKey ascending:(BOOL)ascending {
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sortKey ascending:ascending];
	return [self fetchAllEntitiesOfName:name sortedBy:sortDescriptor];
//	[request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
//	return [self fetchAllEntitiesOfName:name sortedBy:[NSSortDescriptor sortDescriptorWithKey:sortKey ascending:ascending]];
}

- (NSArray *) fetchEntitiesOfName:(NSString *)name withPredicate:(NSString *)formatString, ... {
	NSFetchRequest *r = [self fetchRequestWithEntityName:name];
	
	va_list args;
	va_start(args, formatString);
	NSPredicate *pred = [NSPredicate predicateWithFormat:formatString arguments:args];
	va_end(args);
	
	[r setPredicate:pred];
	
	NSError *error = nil;
	NSArray * result = [self.managedObjectContext executeFetchRequest:r error:&error];
	if (error) {
		NSLog(@"Error executing fetch request: %@", [error localizedDescription]);
		return nil;
	}
	return result;
}


- (NSManagedObject *)fetchFirstEntityOfName:(NSString *)name withPredicate:(NSString *)formatString, ... {
	NSFetchRequest *r = [self fetchRequestWithEntityName:name];
	
	va_list args;
	va_start(args, formatString);
	NSPredicate *pred = [NSPredicate predicateWithFormat:formatString arguments:args];
	va_end(args);
	
	[r setPredicate:pred];
	
	NSError *error = nil;
	NSArray * result = [self.managedObjectContext executeFetchRequest:r error:&error];
	if (error) {
		NSLog(@"Error executing fetch request: %@", [error localizedDescription]);
		return nil;
	}
	if ([result count] > 0) {
		return [result objectAtIndex:0];
	} else {
		return nil;
	}
}






@end
