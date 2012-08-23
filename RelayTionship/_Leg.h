// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Leg.h instead.

#import <CoreData/CoreData.h>


extern const struct LegAttributes {
	__unsafe_unretained NSString *distance;
	__unsafe_unretained NSString *number;
} LegAttributes;

extern const struct LegRelationships {
	__unsafe_unretained NSString *legTime;
	__unsafe_unretained NSString *runner;
} LegRelationships;

extern const struct LegFetchedProperties {
} LegFetchedProperties;

@class LegTime;
@class Runner;




@interface LegID : NSManagedObjectID {}
@end

@interface _Leg : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (LegID*)objectID;




@property (nonatomic, strong) NSNumber* distance;


@property float distanceValue;
- (float)distanceValue;
- (void)setDistanceValue:(float)value_;

//- (BOOL)validateDistance:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* number;


@property int16_t numberValue;
- (int16_t)numberValue;
- (void)setNumberValue:(int16_t)value_;

//- (BOOL)validateNumber:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) LegTime* legTime;

//- (BOOL)validateLegTime:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) Runner* runner;

//- (BOOL)validateRunner:(id*)value_ error:(NSError**)error_;





@end

@interface _Leg (CoreDataGeneratedAccessors)

@end

@interface _Leg (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveDistance;
- (void)setPrimitiveDistance:(NSNumber*)value;

- (float)primitiveDistanceValue;
- (void)setPrimitiveDistanceValue:(float)value_;




- (NSNumber*)primitiveNumber;
- (void)setPrimitiveNumber:(NSNumber*)value;

- (int16_t)primitiveNumberValue;
- (void)setPrimitiveNumberValue:(int16_t)value_;





- (LegTime*)primitiveLegTime;
- (void)setPrimitiveLegTime:(LegTime*)value;



- (Runner*)primitiveRunner;
- (void)setPrimitiveRunner:(Runner*)value;


@end
