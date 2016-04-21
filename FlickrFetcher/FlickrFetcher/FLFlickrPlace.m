// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Boris Talesnik.

#import "FLFlickrPlace.h"

NS_ASSUME_NONNULL_BEGIN

@interface FLFlickrPlace()

// Object with Serialized Data from the Flickr API
@property (nonatomic, strong) NSDictionary * rawData;

@end

@implementation FLFlickrPlace

#pragma mark -
#pragma mark Constants
#pragma mark -

static NSString * const kPlacesResultsKeyPath = @"places.place";
static NSString * const kPlaceNameKeyPath = @"_content";
static NSString * const kPlacesIdKeyPath = @"place_id";

#pragma mark -
#pragma mark FlickrPlace mass production
#pragma mark -

+ (NSArray *)flickrPlacesFromRawData:(NSData *)rawData {
  NSDictionary *convertedData = [NSJSONSerialization JSONObjectWithData:rawData
                                                                options:NSJSONReadingMutableLeaves
                                                                  error:NULL];
  NSArray *rawPlaces = [convertedData valueForKeyPath:kPlacesResultsKeyPath] ;
  NSMutableArray *places = [[NSMutableArray alloc] init];
  for (NSDictionary * rawPlace in rawPlaces) {
    [places addObject:[[FLFlickrPlace alloc] initWithRawData:rawPlace]];
  }
  
  return [places copy];
}

#pragma mark -
#pragma mark Initialization
#pragma mark -

- (instancetype)initWithRawData:(NSDictionary *)rawData {
  self = [super init];
  
  if (self) {
    self.rawData = rawData;
  }
  
  return self;
}

#pragma mark -
#pragma mark Parsing Methods
#pragma mark -

- (NSString *)placeId {
  return [self.rawData valueForKeyPath:kPlacesIdKeyPath];
}

- (NSString *)name {
  return [self.rawData valueForKeyPath:kPlaceNameKeyPath];
}

@end

NS_ASSUME_NONNULL_END
