//
//  AppDelegate.m
//  PayMyPocket
//
//  Created by eliran efron on 06/02/14.
//  Copyright (c) 2014 Eliran Efron. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
    ViewController *mainView = [mainStoryboard instantiateViewControllerWithIdentifier:@"ActionsTable"];
    UINavigationController *mainNavController = [[UINavigationController alloc] initWithRootViewController:mainView];
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setObject:@"1394288859" forKey:@"facebookId"];
    [def setObject:@"Gil" forKey:@"firstname"];
    [def setObject:@"Maman" forKey:@"lastname"];
    [def setObject:@"52f4af930c340" forKey:@"pocketID"];
    [def synchronize];

    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setRootViewController:mainNavController];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    [self.window makeKeyAndVisible]; // Override point for customization after application launch.
    return YES;
}

// Facebook SDK:

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication withSession:self.session];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBAppEvents activateApp];
    //[FBAppCall handleDidBecomeActiveWithSession:self.session];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [self.session close];
}

@end
