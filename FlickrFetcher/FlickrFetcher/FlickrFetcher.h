// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Boris Talesnik.

#import <UIKit/UIKit.h>

#import "FlickrURLMaker.h"

//! Project version number for FlickrFetcher.
FOUNDATION_EXPORT double FlickrFetcherVersionNumber;

//! Project version string for FlickrFetcher.
FOUNDATION_EXPORT const unsigned char FlickrFetcherVersionString[];

NS_ASSUME_NONNULL_BEGIN

/// Object that fetches flickr data
@interface FlickrFetcher : NSObject

- (instancetype)initWithURLMaker:(FlickrURLMaker *)URLMaker;

/// Fetch an array of the top places
/// Pass the array to a given \ccompletion
- (void)fetchTopPlaces:(void (^)(NSArray * topPlaces))completion;

/// Fetch an array of the photos according to a \c flickrPlace and \c maxResults
/// Pass the array to a given \c completion
- (void)fetchPhotosForPlace:(FlickrPlace *)flickrPlace
                 maxResults:(NSUInteger)maxResults
                 completion:(void (^)(NSArray * photos))completion;

/// Fetch an image according to a given \c flickrPhoto
/// Pass the image as UIImage to a given \c completion
- (void)fetchFileForPhoto:(FlickrPhoto *)flickrPhoto
               completion:(void (^)(UIImage *))completion;

@end

NS_ASSUME_NONNULL_END
