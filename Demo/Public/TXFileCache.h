//
//  TXFileCache.h
//  
//
//  Created by chenxiaojie on 2020/3/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TXFileCache : NSObject

+ (nonnull instancetype)globalCache;

- (void)writeNetworkDict:(NSDictionary* __nonnull)dict forUrlKey:(NSString* __nonnull)urlKey;
- (NSDictionary* __nullable)readNetworkDictForKey:(NSString* __nonnull)urlKey;

//- (void)writeData:(NSData* __nonnull)data path:(NSString *)path;

@end

NS_ASSUME_NONNULL_END
