//
//  CocoaHeadsViewController.m
//  CocoaHeads
//
//  Created by Jean-Philippe DESCAMPS on 11/10/11.
//  Copyright 2011 Jean-Philippe DESCAMPS. All rights reserved.
//

#import "CocoaHeadsViewController.h"

@implementation CocoaHeadsViewController

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    mLocationManager = [[CLLocationManager alloc] init];
    [mLocationManager setDelegate:self];
    [mLocationManager setDistanceFilter:1.0];
    
    mRegion = [[CLRegion alloc] initCircularRegionWithCenter:CLLocationCoordinate2DMake(50.634515,3.101625) radius:1.0 identifier:@"les locaux de Sophia"];
    
    if (![CLLocationManager headingAvailable]) {
        [capLabel setHidden:YES];
        [capValue setHidden:YES];
    }
    
    [mLocationManager setPurpose:@"L'application CocoaHeads a besoin de la Puce GPS pour fonctionner."];
    
    [activityIndicator setHidden:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    latitudeValue = nil;
    longitudeValue = nil;
    altitudeValue = nil;
    precisionValue = nil;
    capLabel = nil;
    capValue = nil;
    regionLabel = nil;
    activityIndicator = nil;
    mLocationManager = nil;
    mRegion = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

- (IBAction)startStopButton:(id)sender {
    if (isStarted) {
        isStarted = NO;
        [activityIndicator setHidden:YES];
        [mLocationManager stopUpdatingLocation];
        if ([CLLocationManager headingAvailable]) {
            [mLocationManager stopUpdatingHeading];
        }
    } else {
        isStarted = YES;
        [activityIndicator setHidden:NO];
        [mLocationManager startUpdatingLocation];
        [mLocationManager startMonitoringForRegion:mRegion desiredAccuracy:1.0];
        if ([CLLocationManager headingAvailable]) {
            [mLocationManager startUpdatingHeading];
        }
    }
}

- (IBAction)info:(id)sender {
    [[[[UIAlertView alloc] initWithTitle:@"About" message:@"Application réalisée par\nJean-Philippe DESCAMPS\nCocoaHeads - 11 oct. 2011\nTwitter: @jeanphilipp\njeanphilippe.descamps@gmail.com\nhttp://jeanphilippedescamps.fr" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease] show];
}

#pragma mark - LocationMangerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    [[[[UIAlertView alloc] initWithTitle:@"Erreur" message:[error description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease] show];
}

- (BOOL)locationManagerShouldDisplayHeadingCalibration:(CLLocationManager *)manager {
    return YES;
}

#pragma mark CLLocation

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    [latitudeValue setText:[NSString stringWithFormat:@"%2.f°", newLocation.coordinate.latitude]];
    [longitudeValue setText:[NSString stringWithFormat:@"%2.f°", newLocation.coordinate.longitude]];
    [altitudeValue setText:[NSString stringWithFormat:@"%2.f m", newLocation.altitude]];
    [precisionValue setText:[NSString stringWithFormat:@"%2.f m", newLocation.verticalAccuracy]];
}

#pragma mark CLHeading

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
    [capValue setText:[NSString stringWithFormat:@"%2.f°", newHeading.trueHeading]];
}

#pragma mark CLRegion

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    [regionLabel setText:[NSString stringWithFormat:@"Vous êtes dans %@", region.identifier]];
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    [regionLabel setText:[NSString stringWithFormat:@"Vous n'êtes plus dans %@", region.identifier]];
}

- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error {
    [[[[UIAlertView alloc] initWithTitle:@"Erreur" message:[error description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease] show];
}

- (void)dealloc {
    [latitudeValue release];
    [longitudeValue release];
    [altitudeValue release];
    [precisionValue release];
    [capLabel release];
    [capValue release];
    [activityIndicator release];
    [mLocationManager release];
    [mRegion release];
    [regionLabel release];
    [super dealloc];
}

@end
