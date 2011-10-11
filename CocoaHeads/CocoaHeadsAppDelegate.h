//
//  CocoaHeadsAppDelegate.h
//  CocoaHeads
//
//  Created by Olivier on 11/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CocoaHeadsViewController;

@interface CocoaHeadsAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet CocoaHeadsViewController *viewController;

@end
