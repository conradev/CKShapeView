//
//  CKAppDelegate.m
//  Demo
//
//  Created by Conrad Kramer on 1/20/14.
//  Copyright (c) 2014 Conrad Kramer. All rights reserved.
//

#import "CKAppDelegate.h"
#import "CKViewController.h"

@implementation CKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[CKViewController alloc] init];
    [self.window makeKeyAndVisible];

    return YES;
}


@end
