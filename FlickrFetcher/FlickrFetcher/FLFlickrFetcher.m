// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Boris Talesnik.

#import "FLFlickrFetcher.h"

NS_ASSUME_NONNULL_BEGIN

@interface FLFlickrFetcher()

// Object used for making request URLs
@property (nonatomic, strong) FLFlickrURLMaker * URLMaker;

@end

@implementation FLFlickrFetcher

#pragma mark -
#pragma mark Constants
#pragma mark -

static const NSUInteger kSessionTimeout = 10;

#pragma mark -
#pragma mark Initialization
#pragma mark -

- (instancetype)initWithURLMaker:(FLFlickrURLMaker *)URLMaker {
  self = [super init];
  
  if (self) {
    self.URLMaker = URLMaker;
  }
  
  return self;
}

#pragma mark -
#pragma mark Method Implementation
#pragma mark -

- (void)fetchTopPlacesWithCompletion:(void (^)(NSArray * topPlaces))completionBlock {
  NSURL *urlForTopPlaces = [self.URLMaker URLForTopPlaces];
  dispatch_queue_t fetchQ = dispatch_queue_create("topPlaces", NULL);
  dispatch_async(fetchQ, ^{
    NSData * placesResults = [NSData dataWithContentsOfURL:urlForTopPlaces];
    completionBlock([FLFlickrPlace flickrPlacesFromRawData:placesResults]);
  });
}

- (void)fetchPhotosForPlace:(FLFlickrPlace *)flickrPlace
                 maxResults:(NSUInteger)maxResults
             withCompletion:(void (^)(NSArray * photos))completionBlock {
  dispatch_queue_t fetchQ = dispatch_queue_create("photos", NULL);
  dispatch_async(fetchQ, ^{
    NSURL *photosURL = [self.URLMaker URLForPhotosInPlace:flickrPlace
                                               maxResults:maxResults];
    NSData * photoResults = [NSData dataWithContentsOfURL:photosURL];
    
    completionBlock([FLFlickrPhoto flickrPhotosFromRawData:photoResults]);
  });
}

- (void)fetchFileForPhoto:(FLFlickrPhoto *)flickrPhoto
           withCompletion:(void (^)(UIImage * _Nullable, NSError * _Nullable))completionBlock {
  NSURLSessionConfiguration *configuration =
  [NSURLSessionConfiguration ephemeralSessionConfiguration];
  configuration.timeoutIntervalForResource = kSessionTimeout;
  NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration ];
  NSURLRequest *request =
      [NSURLRequest requestWithURL:[self.URLMaker URLForPhoto:flickrPhoto
                                                   format:FlickrPhotoFormatLarge]];
  NSURLSessionDownloadTask *task =
  [session downloadTaskWithRequest:request
     completionHandler:^(NSURL * _Nullable localFile,
         NSURLResponse * _Nullable __unused response,
         NSError * _Nullable error) {
       if (error) {
         completionBlock(nil, error);
         return;
       }
       UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:localFile]];
       completionBlock(image, error);
     }];
  
  [task resume];
}

@end

NS_ASSUME_NONNULL_END
