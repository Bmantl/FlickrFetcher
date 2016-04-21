// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Boris Talesnik.

NS_ASSUME_NONNULL_BEGIN

/// Object that parses info for a flickr photo data structure
@interface FLFlickrPhoto : NSObject

/// Returns aFlickrPhoto object for a give \c rawData dictionary
/// The \c rawData should be a JSON to NSDictionary serialization
- (instancetype)initWithRawData:(NSDictionary *)rawData;

- (NSString *)title;
- (NSString *)description;
- (NSString *)photoId;
- (NSString *)owner;
- (NSDate *)date;
- (NSString *)placeId;
- (NSString *)farm;
- (NSString *)server;
- (NSString *)secret;
- (NSString *)originalSecret;
- (NSString *)originalFormat;

/// Creates an array of photos from \c rawData.
/// The expected \c rawData is the raw object that's given by calling the flickr API calls
+ (NSArray *)flickrPhotosFromRawData:(NSData *)rawData;

@end

NS_ASSUME_NONNULL_END
