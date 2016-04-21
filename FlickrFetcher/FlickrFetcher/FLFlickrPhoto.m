// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Boris Talesnik.

#import "FLFlickrPhoto.h"

NS_ASSUME_NONNULL_BEGIN

@interface FLFlickrPhoto()

// Object with Serialized Data from the Flickr API
@property (nonatomic, strong) NSDictionary *rawData;

@end

@implementation FLFlickrPhoto

#pragma mark -
#pragma mark Constant Values
#pragma mark -

static NSString * const kPhotoTitleKeyPath = @"title";
static NSString * const kPhotoDescriptionKeyPath = @"description._content";
static NSString * const kPhotoIdKeyPath = @"id";
static NSString * const kPhotoOwnerKeyPath = @"ownername";
static NSString * const kPhotoUploadDateKeyPath = @"dateupload";
static NSString * const kPhotoPlaceIdKeyPath = @"place_id";
static NSString * const kPhotosResultsKeyPath = @"photos.photo";
static NSString * const kPhotoFarmKeyPath = @"farm";
static NSString * const kPhotoServerKeyPath = @"server";
static NSString * const kPhotoSecretDateKeyPath = @"secret";
static NSString * const kPhotoOriginalFormatKeyPath = @"originalformat";
static NSString * const kPhotoOriginalSecretKeyPath = @"originalsecret";

#pragma mark -
#pragma mark FlickrPhoto mass production
#pragma mark -

+ (NSArray *)flickrPhotosFromRawData:(NSData *)rawData {
  NSDictionary *convertedData = [NSJSONSerialization JSONObjectWithData:rawData
                                                                options:NSJSONReadingMutableLeaves
                                                                  error:NULL];
  NSArray *rawPhotos = [convertedData valueForKeyPath:kPhotosResultsKeyPath] ;
  NSMutableArray *photos = [[NSMutableArray alloc] init];
  for (NSDictionary * rawPlace in rawPhotos) {
    [photos addObject:[[FLFlickrPhoto alloc] initWithRawData:rawPlace]];
  }
  
  return [photos copy];
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
#pragma mark Parsing methods
#pragma mark -

- (NSString *)title {
  return [self.rawData valueForKeyPath:kPhotoTitleKeyPath];
}

- (NSString *)description {
  return [self.rawData valueForKeyPath:kPhotoDescriptionKeyPath];
}

- (NSString *)photoId {
  return [self.rawData valueForKeyPath:kPhotoIdKeyPath];
}

- (NSString *)owner {
  return [self.rawData valueForKeyPath:kPhotoOwnerKeyPath];
}

- (NSDate *)date {
  return [NSDate dateWithTimeIntervalSince1970:
          (NSUInteger)[self.rawData valueForKeyPath:kPhotoUploadDateKeyPath]];
}

- (NSString *)placeId {
  return [self.rawData valueForKeyPath:kPhotoPlaceIdKeyPath ];
}

- (NSString *)farm {
  return [self.rawData objectForKey:kPhotoFarmKeyPath];
}

- (NSString *)server {
  return [self.rawData objectForKey:kPhotoServerKeyPath];
}

- (NSString *)secret {
  return [self.rawData objectForKey:kPhotoSecretDateKeyPath];
}

- (NSString *)originalFormat {
  return [self.rawData objectForKey:kPhotoOriginalFormatKeyPath];
}

- (NSString *)originalSecret {
  return [self.rawData objectForKey:kPhotoOriginalSecretKeyPath];
}

@end

NS_ASSUME_NONNULL_END
