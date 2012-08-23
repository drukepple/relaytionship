//
//  TKECoreDataAgent.h
//  Sync Service Scrutinzer
//
//  Created by Dru Kepple on 3/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

/**
 * @ingroup utility
 * A convenience wrapper around Core Data.
 * Provides some boilerplate code to get the NSManagedObjectContext, the NSManagedModel, and the
 * NSPersistentStoreCoordinator, as well as the application's document directory.
 * 
 * Also provides convenience methods for some basic fetching and entity management, as well as saving.
 */
@interface TKECoreDataAgent : NSObject {
	NSManagedObjectContext *__managedObjectContext;
	NSString *_storeName;
}

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (id) initWithStoreName:(NSString *)storeName;

- (void)saveContext;
- (void) deleteLocalStore;
- (NSURL *)applicationDocumentsDirectory;

- (NSManagedObject *) insertEntityWithName:(NSString *)name;
- (NSManagedObject *) createEntityWithName:(NSString *)name;

- (void) deleteEntity: (NSManagedObject *)entity;

- (NSFetchRequest *) fetchRequestWithEntityName:(NSString *)name;
- (NSArray *) fetchAllEntitiesOfName:(NSString *)name;
- (NSArray *) fetchAllEntitiesOfName:(NSString *)name sortedBy:(NSSortDescriptor *)sort;
- (NSArray *) fetchAllEntitiesOfName:(NSString *)name sortedOn:(NSString *)sortKey ascending:(BOOL)ascending;
- (NSArray *) fetchEntitiesOfName:(NSString *)name withPredicate:(NSString *)predicateString, ...;
- (NSManagedObject *)fetchFirstEntityOfName:(NSString *)name withPredicate:(NSString *)formatString, ...;

@end
