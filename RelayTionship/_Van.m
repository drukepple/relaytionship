// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Van.m instead.

#import "_Van.h"

const struct VanAttributes VanAttributes = {
	.number = @"number",
};

const struct VanRelationships VanRelationships = {
	.runners = @"runners",
};

const struct VanFetchedProperties VanFetchedProperties = {
};

@implementation VanID
@end

@implementation _Van

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Van" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Van";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Van" inManagedObjectContext:moc_];
}

- (VanID*)objectID {
	return (VanID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"numberValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"number"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic number;



- (int16_t)numberValue {
	NSNumber *result = [self number];
	return [result shortValue];
}

- (void)setNumberValue:(int16_t)value_ {
	[self setNumber:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveNumberValue {
	NSNumber *result = [self primitiveNumber];
	return [result shortValue];
}

- (void)setPrimitiveNumberValue:(int16_t)value_ {
	[self setPrimitiveNumber:[NSNumber numberWithShort:value_]];
}





@dynamic runners;

	
- (NSMutableSet*)runnersSet {
	[self willAccessValueForKey:@"runners"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"runners"];
  
	[self didAccessValueForKey:@"runners"];
	return result;
}
	






@end
