// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Boris Talesnik.

#import "FlickrFetcher.h"

NS_ASSUME_NONNULL_BEGIN

@interface FlickrFetcher()

@property (nonatomic, strong) FlickrURLMaker * URLMaker;

@end

@implementation FlickrFetcher

#pragma mark - Initialization

- (instancetype)initWithURLMaker:(FlickrURLMaker *)URLMaker {
  self = [super init];
  
  if (self) {
    self.URLMaker = URLMaker;
  }
  
  return self;
}

#pragma mark - Method Implementation

- (void)fetchTopPlaces:(void (^)(NSArray * topPlaces))completion {
  NSURL *urlForTopPlaces = [self.URLMaker URLForTopPlaces];
  dispatch_queue_t fetchQ = dispatch_queue_create("topPlaces", NULL);
  dispatch_async(fetchQ, ^{
    NSData * placesResults = [NSData dataWithContentsOfURL:urlForTopPlaces];
    
    completion([FlickrPlace flickrPlacesFromRawData:placesResults]);
  });
}

- (void)fetchPhotosForPlace:(FlickrPlace *)flickrPlace
                 maxResults:(NSUInteger)maxResults
                 completion:(void (^)(NSArray * photos))completion {
  dispatch_queue_t fetchQ = dispatch_queue_create("photos", NULL);
  dispatch_async(fetchQ, ^{
    NSURL *photosURL = [self.URLMaker URLForPhotosInPlace:flickrPlace
                                               maxResults:maxResults];
    NSData * photoResults = [NSData dataWithContentsOfURL:photosURL];
    
    completion([FlickrPhoto flickrPhotosFromRawData:photoResults]);
  });
}

- (void)fetchFileForPhoto:(FlickrPhoto *)flickrPhoto
               completion:(void (^)(UIImage *))completion {
  NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
  configuration.timeoutIntervalForResource = 10;
  NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration ];
  NSURLRequest *req = [NSURLRequest requestWithURL:[self.URLMaker URLForPhoto:flickrPhoto
                                                                       format:FlickrPhotoFormatLarge]];
  NSURLSessionDownloadTask *task =
  [session downloadTaskWithRequest:req
                 completionHandler:^(NSURL * _Nullable localFile, NSURLResponse * _Nullable __unused response, NSError * _Nullable error) {
                   if (error) {
                     NSLog(@"%@", error);
                     return;
                   }
                   UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:localFile]];
                   completion(image);
                 }];
  [task resume];
}

@end

NS_ASSUME_NONNULL_END
