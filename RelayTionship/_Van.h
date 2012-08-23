// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Van.h instead.

#import <CoreData/CoreData.h>


extern const struct VanAttributes {
	__unsafe_unretained NSString *number;
} VanAttributes;

extern const struct VanRelationships {
	__unsafe_unretained NSString *runners;
} VanRelationships;

extern const struct VanFetchedProperties {
} VanFetchedProperties;

@class Runner;



@interface VanID : NSManagedObjectID {}
@end

@interface _Van : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (VanID*)objectID;




@property (nonatomic, strong) NSNumber* number;


@property int16_t numberValue;
- (int16_t)numberValue;
- (void)setNumberValue:(int16_t)value_;

//- (BOOL)validateNumber:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet* runners;

- (NSMutableSet*)runnersSet;





@end

@interface _Van (CoreDataGeneratedAccessors)

- (void)addRunners:(NSSet*)value_;
- (void)removeRunners:(NSSet*)value_;
- (void)addRunnersObject:(Runner*)value_;
- (void)removeRunnersObject:(Runner*)value_;

@end

@interface _Van (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveNumber;
- (void)setPrimitiveNumber:(NSNumber*)value;

- (int16_t)primitiveNumberValue;
- (void)setPrimitiveNumberValue:(int16_t)value_;





- (NSMutableSet*)primitiveRunners;
- (void)setPrimitiveRunners:(NSMutableSet*)value;


@end
