// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Race.h instead.

#import <CoreData/CoreData.h>


extern const struct RaceAttributes {
	__unsafe_unretained NSString *isFinished;
	__unsafe_unretained NSString *startTime;
} RaceAttributes;

extern const struct RaceRelationships {
} RaceRelationships;

extern const struct RaceFetchedProperties {
} RaceFetchedProperties;





@interface RaceID : NSManagedObjectID {}
@end

@interface _Race : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (RaceID*)objectID;




@property (nonatomic, strong) NSNumber* isFinished;


@property BOOL isFinishedValue;
- (BOOL)isFinishedValue;
- (void)setIsFinishedValue:(BOOL)value_;

//- (BOOL)validateIsFinished:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDate* startTime;


//- (BOOL)validateStartTime:(id*)value_ error:(NSError**)error_;






@end

@interface _Race (CoreDataGeneratedAccessors)

@end

@interface _Race (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveIsFinished;
- (void)setPrimitiveIsFinished:(NSNumber*)value;

- (BOOL)primitiveIsFinishedValue;
- (void)setPrimitiveIsFinishedValue:(BOOL)value_;




- (NSDate*)primitiveStartTime;
- (void)setPrimitiveStartTime:(NSDate*)value;




@end
