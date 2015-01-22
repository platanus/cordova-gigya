#import <Foundation/Foundation.h>

/**
 This class represents a Gigya session. It is created in the login process and persists between app launches, until cleared by `[Gigya logout]`.
 
 Usually there is no need to create a `GSSession` instance manually. If you choose to do so, call `[Gigya setSession:]` in order to make it the active session.
 */
@interface GSSession : NSObject <NSCoding>

/** @name Accessing Session Information */

/*!
 Indicates whether the Gigya session is valid.
 */
- (BOOL)isValid;

/*!
 The session authentication token.
 */
@property (nonatomic, copy) NSString *token;

/*!
 The session secret, used to [sign requests](http://developers.gigya.com/010_Developer_Guide/85_REST/OAuth1#SigningRequests).
 */
@property (nonatomic, copy) NSString *secret;

/*!
 The session expiration date.
 */
@property (nonatomic, copy) NSDate *expiration;

/*!
 The provider used to login.
 */
@property (nonatomic, copy) NSString *lastLoginProvider;

/** @name Manually Creating a Session */

/*!
 Initializes a new `GSSession` instance with the given token and secret.
 
 @param token The session authentication token.
 @param secret The session secret.
 
 @returns A new session instance.
 */
- (GSSession *)initWithSessionToken:(NSString *)token
                             secret:(NSString *)secret;

/*!
 Initializes a new `GSSession` instance with the given token and secret.
 
 @param token The session authentication token.
 @param secret The session secret.
 @param expiration The session expiration date.
 @returns A new session instance.
 */
- (GSSession *)initWithSessionToken:(NSString *)token
                             secret:(NSString *)secret
                         expiration:(NSDate *)expiration;

@end
