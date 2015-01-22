#import <Foundation/Foundation.h>
#import "GSResponse.h"
#import "GSSession.h"

typedef void(^GSResponseHandler)(GSResponse *response, NSError *error);

/** This class can be used to send requests to the [Gigya REST API](http://developers.gigya.com/037_API_reference).
 
 Example:
 
    GSRequest *request = [GSRequest requestForMethod:@"socialize.getSessionInfo"];
    [request.parameters setObject:@"facebook" forKey:@"provider"];
    [request sendWithResponseHandler:^(GSResponse *response, NSError *error) {
        if (!error) {
            // Success! Use the response object.
        }
        else {
            // Check the error code according to the GSErrorCode enum, and handle it.
        }
    }];
 
 */
@interface GSRequest : NSObject <NSURLConnectionDelegate>

/** @name Creating a Request */

/*!
 Creates a `GSRequest` object for a given method.
 
 @param method The API method.
 @returns A new `GSRequest` object for the method.
 */
+ (GSRequest *)requestForMethod:(NSString *)method;

/*!
 Creates a `GSRequest` object for a given method and parameters.
 
 @param method The API method.
 @param parameters A dictionary of parameters to pass to the method.
 @returns A new `GSRequest` object for the method and parameters.
 */
+ (GSRequest *)requestForMethod:(NSString *)method parameters:(NSDictionary*)parameters;

/*!
 The API method name.
 */
@property (nonatomic, copy) NSString *method;

/*!
 The paremeters for the API method.
 */
@property (nonatomic, retain) NSMutableDictionary* parameters;

/*!
 Indicates whether HTTPS should be used. The default is `YES`. Overrides the global setting in [Gigya].
 */
@property (nonatomic) BOOL useHTTPS;
/*!
 Indicates the time in seconds before a request times out. Overrides the global setting in [Gigya].
 */
@property (nonatomic) NSTimeInterval requestTimeout;


/** @name Sending a Request */

/*!
 Sends the request asynchronously and calls the handler with the response.
 
 @param handler A response handler that will be invoked when the response arrives. The handler should have the signature `(GSResponse *response, NSError *error)`. If the request was successful, the `error` parameter will be `nil`. Otherwise you can check its value (see `GSErrorCode` enum for error codes) or `response` to learn why it failed.
 */
- (void)sendWithResponseHandler:(GSResponseHandler)handler;

/*!
 Sends the request synchronously and returns the response. 
 
 @warning Calling this method on the main queue will block the UI and therefore is not recommended.
 @param error An error that will be set if the request failed, otherwise unchanged.
 @returns The response for the request.
 */
- (GSResponse *)sendSynchronouslyWithError:(NSError **)error;

/*!
 Cancels the request. The provided handler will not be invoked.
 */
- (void)cancel;

@property (nonatomic, retain) GSSession *session;
@property (nonatomic, readonly) NSString *requestID;
@property (nonatomic)         BOOL includeAuthInfo;
@property (nonatomic, copy) NSString *source;

@end
