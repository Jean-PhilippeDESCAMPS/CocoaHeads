//
//  CocoaHeadsViewController.h
//  CocoaHeads
//
//  Created by Jean-Philippe DESCAMPS on 11/10/11.
//  Copyright 2011 Jean-Philippe DESCAMPS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface CocoaHeadsViewController : UIViewController <CLLocationManagerDelegate>
{
    IBOutlet UILabel *latitudeValue;
    IBOutlet UILabel *longitudeValue;
    IBOutlet UILabel *altitudeValue;
    IBOutlet UILabel *precisionValue;
    IBOutlet UILabel *capLabel;
    IBOutlet UILabel *capValue;
    IBOutlet UILabel *regionLabel;
    IBOutlet UIActivityIndicatorView *activityIndicator;
    
    CLLocationManager *mLocationManager;
    CLRegion *mRegion;
    BOOL isStarted;
}

- (IBAction)startStopButton:(id)sender;
- (IBAction)info:(id)sender;

@end
