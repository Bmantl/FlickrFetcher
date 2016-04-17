// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Boris Talesnik.

#import <Foundation/Foundation.h>

//! Project version number for FlickrFetcher.
FOUNDATION_EXPORT double FlickrFetcherVersionNumber;

//! Project version string for FlickrFetcher.
FOUNDATION_EXPORT const unsigned char FlickrFetcherVersionString[];

NS_ASSUME_NONNULL_BEGIN

/// Object that parses info for a flickr place data structure
@interface FlickrPlace : NSObject

/// Creates an array of flickr places from \c rawData.
/// The expected \c rawData is the raw object that's given by calling the flickr API calls
+ (NSArray *)flickrPlacesFromRawData:(NSData *)rawData;

/// Returns a FlickrPlace object for a give \c rawData dictionary
/// The \c rawData should be a JSON to NSDictionary serialization
- (instancetype)initWithRawData:(NSDictionary *)rawData;

- (NSString *) placeId;
- (NSString *) name;

@end

NS_ASSUME_NONNULL_END
