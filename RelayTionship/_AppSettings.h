// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AppSettings.h instead.

#import <CoreData/CoreData.h>


extern const struct AppSettingsAttributes {
	__unsafe_unretained NSString *isTiming;
	__unsafe_unretained NSString *selectedTab;
} AppSettingsAttributes;

extern const struct AppSettingsRelationships {
} AppSettingsRelationships;

extern const struct AppSettingsFetchedProperties {
} AppSettingsFetchedProperties;





@interface AppSettingsID : NSManagedObjectID {}
@end

@interface _AppSettings : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (AppSettingsID*)objectID;




@property (nonatomic, strong) NSNumber* isTiming;


@property BOOL isTimingValue;
- (BOOL)isTimingValue;
- (void)setIsTimingValue:(BOOL)value_;

//- (BOOL)validateIsTiming:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* selectedTab;


@property int16_t selectedTabValue;
- (int16_t)selectedTabValue;
- (void)setSelectedTabValue:(int16_t)value_;

//- (BOOL)validateSelectedTab:(id*)value_ error:(NSError**)error_;






@end

@interface _AppSettings (CoreDataGeneratedAccessors)

@end

@interface _AppSettings (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveIsTiming;
- (void)setPrimitiveIsTiming:(NSNumber*)value;

- (BOOL)primitiveIsTimingValue;
- (void)setPrimitiveIsTimingValue:(BOOL)value_;




- (NSNumber*)primitiveSelectedTab;
- (void)setPrimitiveSelectedTab:(NSNumber*)value;

- (int16_t)primitiveSelectedTabValue;
- (void)setPrimitiveSelectedTabValue:(int16_t)value_;




@end
