/********* CordovaGigya.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import <GigyaSDK/Gigya.h>
#import <UIKit/UIKit.h>

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
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(applicationDidBecomeActive:)
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

    [Gigya showLoginProvidersDialogOver:super.viewController
        providers:@[@"facebook", @"twitter", @"googleplus"]
        parameters:nil
        completionHandler:^(GSUser *user, NSError *error) {
            CDVPluginResult* pluginResult = nil;

            if (!error) {
                NSString* userString = [user JSONString];

                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:userString];
            }
            else {
                // Handle error
                NSLog(@"Login error: %@", error);
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
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

- (void)getUserInfo:(CDVInvokedUrlCommand*)command
{
    GSRequest *request = [GSRequest requestForMethod:@"socialize.getUserInfo"];
    [request sendWithResponseHandler:^(GSResponse *response, NSError *error) {
        CDVPluginResult* pluginResult = nil;

        if (!error) {
            NSString* responseString = [response JSONString];

            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:responseString];
        }
        else {
            // Handle error
            NSLog(@"Request error: %@", error);
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        }
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

- (void)logout:(CDVInvokedUrlCommand*)command
{
    [Gigya logoutWithCompletionHandler:^(GSResponse *response, NSError *error) {
        CDVPluginResult* pluginResult = nil;

        if (!error) {
            NSString* responseString = [response JSONString];

            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:responseString];
        }
        else {
            NSLog(@"Logout error: %@", error);
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        }
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

@end
