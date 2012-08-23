// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LegTime.h instead.

#import <CoreData/CoreData.h>


extern const struct LegTimeAttributes {
	__unsafe_unretained NSString *endTime;
	__unsafe_unretained NSString *mileageForProjection;
	__unsafe_unretained NSString *projectedEndTime;
	__unsafe_unretained NSString *secondsForProjection;
	__unsafe_unretained NSString *startTime;
} LegTimeAttributes;

extern const struct LegTimeRelationships {
	__unsafe_unretained NSString *leg;
} LegTimeRelationships;

extern const struct LegTimeFetchedProperties {
} LegTimeFetchedProperties;

@class Leg;







@interface LegTimeID : NSManagedObjectID {}
@end

@interface _LegTime : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (LegTimeID*)objectID;




@property (nonatomic, strong) NSDate* endTime;


//- (BOOL)validateEndTime:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* mileageForProjection;


@property float mileageForProjectionValue;
- (float)mileageForProjectionValue;
- (void)setMileageForProjectionValue:(float)value_;

//- (BOOL)validateMileageForProjection:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDate* projectedEndTime;


//- (BOOL)validateProjectedEndTime:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* secondsForProjection;


@property float secondsForProjectionValue;
- (float)secondsForProjectionValue;
- (void)setSecondsForProjectionValue:(float)value_;

//- (BOOL)validateSecondsForProjection:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDate* startTime;


//- (BOOL)validateStartTime:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) Leg* leg;

//- (BOOL)validateLeg:(id*)value_ error:(NSError**)error_;





@end

@interface _LegTime (CoreDataGeneratedAccessors)

@end

@interface _LegTime (CoreDataGeneratedPrimitiveAccessors)


- (NSDate*)primitiveEndTime;
- (void)setPrimitiveEndTime:(NSDate*)value;




- (NSNumber*)primitiveMileageForProjection;
- (void)setPrimitiveMileageForProjection:(NSNumber*)value;

- (float)primitiveMileageForProjectionValue;
- (void)setPrimitiveMileageForProjectionValue:(float)value_;




- (NSDate*)primitiveProjectedEndTime;
- (void)setPrimitiveProjectedEndTime:(NSDate*)value;




- (NSNumber*)primitiveSecondsForProjection;
- (void)setPrimitiveSecondsForProjection:(NSNumber*)value;

- (float)primitiveSecondsForProjectionValue;
- (void)setPrimitiveSecondsForProjectionValue:(float)value_;




- (NSDate*)primitiveStartTime;
- (void)setPrimitiveStartTime:(NSDate*)value;





- (Leg*)primitiveLeg;
- (void)setPrimitiveLeg:(Leg*)value;


@end
