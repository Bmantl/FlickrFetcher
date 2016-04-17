// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Boris Talesnik.

#import "FlickrPhoto.h"

NS_ASSUME_NONNULL_BEGIN

@interface FlickrPhoto()

@property (nonatomic, strong) NSDictionary *rawData;

@end

@implementation FlickrPhoto

#pragma mark - Constant Values

static const NSString *kPhotoTitleKeyPath = @"title";
static const NSString *kPhotoDescriptionKeyPath = @"description._content";
static const NSString *kPhotoIdKeyPath = @"id";
static const NSString *kPhotoOwnerKeyPath = @"ownername";
static const NSString *kPhotoUploadDateKeyPath = @"dateupload";
static const NSString *kPhotoPlaceIdKeyPath = @"place_id";
static const NSString *kPhotosResultsKeyPath = @"photos.photo";
static const NSString *kPhotoFarmKeyPath = @"farm";
static const NSString *kPhotoServerKeyPath = @"server";
static const NSString *kPhotoSecretDateKeyPath = @"secret";
static const NSString *kPhotoOriginalFormatKeyPath = @"originalformat";
static const NSString *kPhotoOriginalSecretKeyPath = @"originalsecret";


#pragma mark - FlickrPhoto mass production

+ (NSArray *)flickrPhotosFromRawData:(NSData *)rawData {
  NSDictionary *convertedData = [NSJSONSerialization JSONObjectWithData:rawData
                                                                options:NSJSONReadingMutableLeaves
                                                                  error:NULL];
  NSArray *rawPhotos = [convertedData valueForKeyPath:[kPhotosResultsKeyPath copy]] ;
  NSMutableArray *photos = [[NSMutableArray alloc] init];
  for (NSDictionary * rawPlace in rawPhotos) {
    [photos addObject:[[FlickrPhoto alloc] initWithRawData:rawPlace]];
  }
  
  return [photos copy];
}

#pragma mark - initialization

- (instancetype)initWithRawData:(NSDictionary *)rawData {
  self = [super init];
  
  if (self) {
    self.rawData = rawData;
  }
  
  return self;
}

#pragma mark - parsing methods

- (NSString *)title {
  return [self.rawData valueForKeyPath:[kPhotoTitleKeyPath copy]];
}

- (NSString *)description {
  return [self.rawData valueForKeyPath:[kPhotoDescriptionKeyPath copy]];
}

- (NSString *)photoId {
  return [self.rawData valueForKeyPath:[kPhotoIdKeyPath copy]];
}

- (NSString *)owner {
  return [self.rawData valueForKeyPath:[kPhotoOwnerKeyPath copy]];
}

- (NSDate *)date {
  return [NSDate dateWithTimeIntervalSince1970:
          (NSUInteger)[self.rawData valueForKeyPath:[kPhotoUploadDateKeyPath copy]]];
}

- (NSString *)placeId {
  return [self.rawData valueForKeyPath:[kPhotoPlaceIdKeyPath copy]];
}

- (NSString *)farm {
  return [self.rawData objectForKey:[kPhotoFarmKeyPath copy]];
}

- (NSString *)server {
  return [self.rawData objectForKey:[kPhotoServerKeyPath copy]];
}

- (NSString *)secret {
  return [self.rawData objectForKey:[kPhotoSecretDateKeyPath copy]];
}

- (NSString *)originalFormat {
  return [self.rawData objectForKey:[kPhotoOriginalFormatKeyPath copy]];
}

- (NSString *)originalSecret {
  return [self.rawData objectForKey:[kPhotoOriginalSecretKeyPath copy]];
}

@end

NS_ASSUME_NONNULL_END
