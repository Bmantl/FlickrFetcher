// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Boris Talesnik.

#import "FLFlickrPhoto.h"
#import "FLFlickrPlace.h"

NS_ASSUME_NONNULL_BEGIN

/// Object for creating Flickr URLs according to the Flickr API
@interface FLFlickrURLMaker : NSObject

#pragma mark -
#pragma mark Photo formats
#pragma mark -

typedef enum {
  FlickrPhotoFormatSquare = 1,    // thumbnail
  FlickrPhotoFormatLarge = 2,     // normal size
  FlickrPhotoFormatOriginal = 64  // high resolution
} FlickrPhotoFormat;

/// Returns a FlickrURLMaker with a given \c APIKey
- (instancetype)initWithAPIKey: (NSString *)APIKey;

/// Returns a URL for the Top Places
- (NSURL *)URLForTopPlaces;

/// Retruns a URL for the photos of a given \c flickrPlace
/// And \c maxResults
- (NSURL *)URLForPhotosInPlace:(FLFlickrPlace *)flickrPlace maxResults:(NSUInteger)maxResults;

/// Retruns a URL for a photo for a given \c flickrPhoto according to a \c format
- (NSURL *)URLForPhoto:(FLFlickrPhoto *)flickrPhoto format:(FlickrPhotoFormat)format;

@end

NS_ASSUME_NONNULL_END
