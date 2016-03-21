//
//  Place.h
//  第19章Core Location和 Map Kit
//
//  Created by 李懿哲 on 3/21/16.
//  Copyright © 2016 李懿哲. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Place : NSObject<MKAnnotation>
@property (copy, nonatomic) NSString *titile;
@property (copy, nonatomic) NSString *subtitle;
@property (assign, nonatomic) CLLocationCoordinate2D coordinate;
@end
