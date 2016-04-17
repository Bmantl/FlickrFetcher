// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Boris Talesnik.

#import "FlickrPhoto.h"
#import "FlickrPlace.h"

//! Project version number for FlickrFetcher.
FOUNDATION_EXPORT double FlickrFetcherVersionNumber;

//! Project version string for FlickrFetcher.
FOUNDATION_EXPORT const unsigned char FlickrFetcherVersionString[];

NS_ASSUME_NONNULL_BEGIN

/// Object for creating Flickr URLs according to the Flickr API
@interface FlickrURLMaker : NSObject

#pragma mark - photo formats

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
- (NSURL *)URLForPhotosInPlace:(FlickrPlace *)flickrPlace maxResults:(NSUInteger)maxResults;

/// Retruns a URL for a photo for a given \c flickrPhoto according to a \c format
- (NSURL *)URLForPhoto:(FlickrPhoto *)flickrPhoto format:(FlickrPhotoFormat)format;

@end

NS_ASSUME_NONNULL_END
