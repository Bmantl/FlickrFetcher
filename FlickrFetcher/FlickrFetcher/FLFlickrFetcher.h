// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Boris Talesnik.

#import "FLFlickrURLMaker.h"

NS_ASSUME_NONNULL_BEGIN

/// Object that fetches flickr data
@interface FLFlickrFetcher : NSObject

- (instancetype)initWithURLMaker:(FLFlickrURLMaker *)URLMaker;

/// Fetch an array of the top places
/// Pass the array to a given \ccompletion
- (void)fetchTopPlacesWithCompletion:(void (^)(NSArray * topPlaces))completionBlock;

/// Fetch an array of the photos according to a \c flickrPlace and \c maxResults
/// Pass the array to a given \c completion
- (void)fetchPhotosForPlace:(FLFlickrPlace *)flickrPlace
                 maxResults:(NSUInteger)maxResults
                 withCompletion:(void (^)(NSArray * photos))completionBlock;

/// Fetch an image according to a given \c flickrPhoto
/// Pass the image as UIImage to a given \c completion
- (void)fetchFileForPhoto:(FLFlickrPhoto *)flickrPhoto
               withCompletion:(void (^)(UIImage * _Nullable, NSError * _Nullable))completionBlock;

@end

NS_ASSUME_NONNULL_END
