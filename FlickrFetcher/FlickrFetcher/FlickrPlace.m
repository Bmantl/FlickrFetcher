// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Boris Talesnik.

#import "FlickrPlace.h"

NS_ASSUME_NONNULL_BEGIN

@interface FlickrPlace()

@property (nonatomic, strong) NSDictionary * rawData;

@end

@implementation FlickrPlace

#pragma mark - Constants

static const NSString * kPlacesResultsKeyPath = @"places.place";
static const NSString * kPlaceNameKeyPath = @"_content";
static const NSString * kPlacesIdKeyPath = @"place_id";

#pragma mark - FlickrPlace mass production

+ (NSArray *)flickrPlacesFromRawData:(NSData *)rawData {
  NSDictionary *convertedData = [NSJSONSerialization JSONObjectWithData:rawData
                                                                options:NSJSONReadingMutableLeaves
                                                                  error:NULL];
  NSArray *rawPlaces = [convertedData valueForKeyPath:[kPlacesResultsKeyPath copy]] ;
  NSMutableArray *places = [[NSMutableArray alloc] init];
  for (NSDictionary * rawPlace in rawPlaces) {
    [places addObject:[[FlickrPlace alloc] initWithRawData:rawPlace]];
  }
  
  return [places copy];
}

#pragma mark - initialization

- (instancetype)initWithRawData:(NSDictionary *)rawData {
  self = [super init];
  
  if (self) {
    self.rawData = rawData;
  }
  
  return self;
}

#pragma mark - Parsing Methods

- (NSString *)placeId {
  return [self.rawData valueForKeyPath:[kPlacesIdKeyPath copy]];
}

- (NSString *)name {
  return [self.rawData valueForKeyPath:[kPlaceNameKeyPath copy]];
}

@end

NS_ASSUME_NONNULL_END
