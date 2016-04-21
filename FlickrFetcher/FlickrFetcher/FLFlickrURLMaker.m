// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Boris Talesnik.

#import "FLFlickrURLMaker.h"

NS_ASSUME_NONNULL_BEGIN

@interface FLFlickrURLMaker()

// Flickr API key - used for generatin user specific Flickr requests
@property (nonatomic, strong) NSString *APIKey;

@end

@implementation FLFlickrURLMaker

#pragma mark -
#pragma mark Initialization
#pragma mark -

- (instancetype)initWithAPIKey: (NSString *)APIKey {
  self = [super init];
  
  if (self) {
    self.APIKey = APIKey;
  }
  return self;
}

#pragma mark -
#pragma mark Method implementations
#pragma mark -

- (NSURL *)URLForTopPlaces
{
  return [self URLForQuery:@"https://api.flickr.com/services/rest/"
          "?method=flickr.places.getTopPlacesList&place_type_id=7"];
}

- (NSURL *)URLForPhotosInPlace:(FLFlickrPlace *)flickPlace maxResults:(NSUInteger)maxResults {
  return [self URLForQuery:[NSString stringWithFormat:@"https://api.flickr.com/services/rest/"
                              "?method=flickr.photos.search&place_id=%@&per_page=%ld&extras="
                              "original_format,tags,description,geo"
                              ",date_upload,owner_name,place_url",
                            [flickPlace placeId], maxResults]];
}

- (NSURL *)URLForPhoto:(FLFlickrPhoto *)flickrPhoto format:(FlickrPhotoFormat)format
{
  return [NSURL URLWithString:[FLFlickrURLMaker urlStringForPhoto:flickrPhoto format:format]];
}

#pragma mark -
#pragma mark Helper methods
#pragma mark -

- (NSURL *)URLForQuery:(NSString *)query
{
  query = [NSString stringWithFormat:@"%@&format=json&nojsoncallback=1&api_key=%@",
      query, self.APIKey];
  query = [query stringByAddingPercentEncodingWithAllowedCharacters:
      [NSCharacterSet URLFragmentAllowedCharacterSet]];
  return [NSURL URLWithString:query];
}

+ (NSString *)urlStringForPhoto:(FLFlickrPhoto *)flickrPhoto format:(FlickrPhotoFormat)format
{
  id farm = [flickrPhoto farm];
  id server = [flickrPhoto server];
  id photo_id = [flickrPhoto photoId];
  id secret = [flickrPhoto secret];
  if (format == FlickrPhotoFormatOriginal) secret = [flickrPhoto originalSecret];
  
  NSString *fileType = @"jpg";
  if (format == FlickrPhotoFormatOriginal) fileType = [flickrPhoto originalFormat];
  
  if (!farm || !server || !photo_id || !secret) return nil;
  
  NSString *formatString = @"s";
  switch (format) {
    case FlickrPhotoFormatSquare:
      formatString = @"s";
      break;
    case FlickrPhotoFormatLarge:
      formatString = @"b";
      break;
    case FlickrPhotoFormatOriginal:
      formatString = @"o";
      break;
  }
  
  return [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_%@.%@",
      farm, server, photo_id, secret, formatString, fileType];
}

@end

NS_ASSUME_NONNULL_END
