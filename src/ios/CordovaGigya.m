/********* CordovaGigya.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import <GigyaSDK/Gigya.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface CordovaGigya : CDVPlugin {
// Member variables go here.
}

- (void)initialize:(CDVInvokedUrlCommand*)command;
@end

@implementation CordovaGigya

- (void)pluginInitialize;
{
    NSLog(@"Cordova Gigya Plugin Initialize");
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifiedOpenUrl:) name:@"CDVPluginHandleOpenURLNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive:)
        name:UIApplicationDidBecomeActiveNotification object:nil];

    [super pluginInitialize];
}

// selectors
- (void)notifiedOpenUrl:(NSNotification *)notification
{
    NSLog(@"Url handled");
    NSURL* url = (NSURL*)notification.object;
    [Gigya handleOpenURL:url sourceApplication:nil annotation:nil];
}

-(void)applicationDidBecomeActive:(UIApplication *)application
{
    [Gigya handleDidBecomeActive];
}

// CDV Plugin commands
- (void)initialize:(CDVInvokedUrlCommand*)command
{
    NSString* apiKey = [command.arguments objectAtIndex:0];
    [Gigya initWithAPIKey:apiKey];

}

- (void)showLoginUI:(CDVInvokedUrlCommand*)command
{
    NSArray* providers;

    if([command.arguments objectAtIndex:0] != [NSNull null]){
        providers = [command.arguments objectAtIndex:0];
    }
    else {
        providers = @[];
    }

    NSDictionary* loginParams = nil;

    if([command.arguments objectAtIndex:1] != [NSNull null]){
        loginParams = [command.arguments objectAtIndex:1];
    }

    [Gigya showLoginProvidersDialogOver:super.viewController
        providers:providers
        parameters:loginParams
        completionHandler:^(GSUser *user, NSError *error) {
            CDVPluginResult* pluginResult = nil;

            NSString* userString = [user JSONString];
            NSData* userData = [userString dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary* userDictionary = [NSJSONSerialization JSONObjectWithData:userData options:kNilOptions error:&error];

            if (!error) {
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:userDictionary];
            }
            else {
                // Handle error
                NSLog(@"Login error: %@", error);

                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:userDictionary];
            }
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

        }];


}

- (void)login:(CDVInvokedUrlCommand*)command
{
    NSString* provider = [command.arguments objectAtIndex:0];

    NSDictionary* loginParams = nil;

    if([command.arguments objectAtIndex:1] != [NSNull null]){
        loginParams = [command.arguments objectAtIndex:1];
    }

    [Gigya loginToProvider:provider
                parameters:loginParams
                      over:super.viewController
         completionHandler:^(GSUser *user, NSError *error) {
            CDVPluginResult* pluginResult = nil;

            NSString* userString = [user JSONString];
            NSData* userData = [userString dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary* userDictionary = [NSJSONSerialization JSONObjectWithData:userData options:kNilOptions error:&error];
            if (!error) {
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:userDictionary];
            }
            else {
                // Handle error
                NSLog(@"Login error: %@", error);

                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:userDictionary];
            }
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

         }];
}

- (void)getSession:(CDVInvokedUrlCommand*)command
{

    GSSession* session = [Gigya session];
    CDVPluginResult* pluginResult = nil;

    BOOL isValid = [session isValid];
    if(isValid){
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:session.token];
    }
    else{
        NSLog(@"Session error: no valid session");
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

}

- (void)sendRequest:(CDVInvokedUrlCommand*)command
{
    NSString* requestMethod = [command.arguments objectAtIndex:0];

    GSRequest* request;

    if([command.arguments objectAtIndex:1] != [NSNull null]){
        NSDictionary* requestParams = [command.arguments objectAtIndex:1];
        request = [GSRequest requestForMethod:requestMethod parameters:requestParams];
    }
    else{
        request = [GSRequest requestForMethod:requestMethod];
    }

    [request sendWithResponseHandler:^(GSResponse *response, NSError *error) {
        CDVPluginResult* pluginResult = nil;

        NSString* responseString = [response JSONString];
        NSData* responseData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary* responseDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];

        if (!error) {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:responseDictionary];
        }
        else {
            // Handle error
            NSLog(@"Request error: %@", error);
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:responseDictionary];
        }
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

- (void)logout:(CDVInvokedUrlCommand*)command
{
    [Gigya logoutWithCompletionHandler:^(GSResponse *response, NSError *error) {
        CDVPluginResult* pluginResult = nil;

        NSString* responseString = [response JSONString];
        NSData* responseData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary* responseDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];

        if (!error) {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:responseDictionary];
        }
        else {
            NSLog(@"Logout error: %@", error);

            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:responseDictionary];
        }
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

@end
