#import "GSResponse.h"

/**
 This class represents Gigya user information, as returned from the [socialize.getUserInfo](http://developers.gigya.com/037_API_reference/010_Socialize/socialize.getUserInfo) method in the [Gigya REST API](http://developers.gigya.com/037_API_reference).
 
 `GSUser` values can be accessed by keys (similiar to NSDictionary) and support subscripting syntax:
 
    // These two statements are equivalent
    NSString *email = [user objectForKey:@"email"];
    NSString *email = user[@"email"];
 
 `GSUser` also providers properties for easy access to the most commonly used values.
 */
@interface GSUser : GSResponse

/** @name Basic User Information */

/*!
 The unique ID of the user.
 */
@property (nonatomic, readonly) NSString *UID;

/*!
 The name of the provider that the user used in order to login.
 */
@property (nonatomic, readonly) NSString *loginProvider;

/*!
 The user's nickname, this may be either the nickname provided by the connected provider or a concatenation of the first and last names.
 */
@property (nonatomic, readonly) NSString *nickname;

/*!
 The user's first name.
 */
@property (nonatomic, readonly) NSString *firstName;

/*!
 The user's last name.
 */
@property (nonatomic, readonly) NSString *lastName;

/*!
 The user's email.
 */
@property (nonatomic, readonly) NSString *email;

/*!
 An array of dictionaries that represent [identity objects](http://developers.gigya.com/020_Client_API/010_Socialize/010_Objects/Identity_object), describing a person's identity on a specific provider.
 */
@property (nonatomic, readonly) NSArray *identities;

/*!
 The URL of person's full size photo.
 */
@property (nonatomic, readonly) NSURL *photoURL;

/*!
 The URL of person's thumbnail photo if available.
 */
@property (nonatomic, readonly) NSURL *thumbnailURL;

/** @name Accessing Keys and Values */

/*!
 Returns an array containing the user dictionary keys.
 
 @returns An array containing the user dictionary keys.
 */
- (NSArray *)allKeys;

/*!
 Returns the value associated with the given key.
 
 @returns The key for which to return the value.
 */
- (id)objectForKey:(NSString *)key;

/*!
 Returns the value associated with the given key.
 
 This method is the same as <objectForKey:>, but is required for subscripting syntax.
 */
- (id)objectForKeyedSubscript:(NSString *)key;

/** @name JSON Encoding */

/*!
 Returns a JSON representation of the `getUserInfo` response.
 */
- (NSString *)JSONString;

@end
