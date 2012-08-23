// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Runner.h instead.

#import <CoreData/CoreData.h>


extern const struct RunnerAttributes {
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *number;
} RunnerAttributes;

extern const struct RunnerRelationships {
	__unsafe_unretained NSString *legs;
	__unsafe_unretained NSString *van;
} RunnerRelationships;

extern const struct RunnerFetchedProperties {
} RunnerFetchedProperties;

@class Leg;
@class Van;




@interface RunnerID : NSManagedObjectID {}
@end

@interface _Runner : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (RunnerID*)objectID;




@property (nonatomic, strong) NSString* name;


//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* number;


@property int16_t numberValue;
- (int16_t)numberValue;
- (void)setNumberValue:(int16_t)value_;

//- (BOOL)validateNumber:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet* legs;

- (NSMutableSet*)legsSet;




@property (nonatomic, strong) Van* van;

//- (BOOL)validateVan:(id*)value_ error:(NSError**)error_;





@end

@interface _Runner (CoreDataGeneratedAccessors)

- (void)addLegs:(NSSet*)value_;
- (void)removeLegs:(NSSet*)value_;
- (void)addLegsObject:(Leg*)value_;
- (void)removeLegsObject:(Leg*)value_;

@end

@interface _Runner (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSNumber*)primitiveNumber;
- (void)setPrimitiveNumber:(NSNumber*)value;

- (int16_t)primitiveNumberValue;
- (void)setPrimitiveNumberValue:(int16_t)value_;





- (NSMutableSet*)primitiveLegs;
- (void)setPrimitiveLegs:(NSMutableSet*)value;



- (Van*)primitiveVan;
- (void)setPrimitiveVan:(Van*)value;


@end
