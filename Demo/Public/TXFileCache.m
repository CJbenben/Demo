//
//  TXFileCache.m
//  
//
//  Created by chenxiaojie on 2020/3/26.
//

#import "TXFileCache.h"


@interface TXFileCache ()

@property (nonatomic, strong) NSString *sandboxPath;
@property (nonatomic, strong) NSString *networkPlistpath;

@end
@implementation TXFileCache

+ (instancetype)globalCache {
    static id instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        self.sandboxPath = [self sandboxFilePath];
        self.networkPlistpath = [self.sandboxPath stringByAppendingPathComponent:@"networkData.plist"];
    }
    return self;
}

- (NSString *)sandboxFilePath {
//                      NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSArray *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [filePath objectAtIndex:0];
    return documentPath;
}

- (BOOL)isFileExist:(NSString *)fileName {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",[self sandboxFilePath], fileName];
    return [fileManager fileExistsAtPath:filePath];
}

- (NSDictionary *)getNetworkPlistDict {
    NSDictionary *plistDict = [NSDictionary dictionaryWithContentsOfFile:self.networkPlistpath];
    return plistDict;
}

- (void)writeNetworkDict:(NSDictionary* __nonnull)dict forUrlKey:(NSString* __nonnull)urlKey {
    if (dict == nil) {
        return;
    }
    if (urlKey.length == 0) {
        return;
    }
    NSMutableDictionary *plistDict = [[self getNetworkPlistDict] mutableCopy];
    if (plistDict == nil) {
        plistDict = [NSMutableDictionary dictionary];
    }
    [plistDict setObject:dict forKey:urlKey];
    [plistDict writeToFile:self.networkPlistpath atomically:YES];
    NSLog(@"输出消息%@", plistDict);
}

- (NSDictionary* __nullable)readNetworkDictForKey:(NSString* __nonnull)urlKey {
    NSDictionary *plistDict = [self getNetworkPlistDict];
    if (plistDict.allKeys.count) {
        NSDictionary *currNetworkDict = [plistDict objectForKey:urlKey];
        return currNetworkDict;
    }
    return nil;
}

//- (instancetype)init {
//    NSString* cachesDirectory = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
//    NSString* oldCachesDirectory = [[[cachesDirectory stringByAppendingPathComponent:[[NSProcessInfo processInfo] processName]] stringByAppendingPathComponent:@"EGOCache"] copy];
//
//    if([[NSFileManager defaultManager] fileExistsAtPath:oldCachesDirectory]) {
//        [[NSFileManager defaultManager] removeItemAtPath:oldCachesDirectory error:NULL];
//    }
//
//    cachesDirectory = [[[cachesDirectory stringByAppendingPathComponent:[[NSBundle mainBundle] bundleIdentifier]] stringByAppendingPathComponent:@"EGOCache"] copy];
//    return [self initWithCacheDirectory:cachesDirectory];
//}
//
//
//- (instancetype)initWithCacheDirectory:(NSString*)cacheDirectory {
//    if((self = [super init])) {
//        _cacheInfoQueue = dispatch_queue_create("com.enormego.egocache.info", DISPATCH_QUEUE_SERIAL);
//        dispatch_queue_t priority = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
//        dispatch_set_target_queue(priority, _cacheInfoQueue);
//
//        _frozenCacheInfoQueue = dispatch_queue_create("com.enormego.egocache.info.frozen", DISPATCH_QUEUE_SERIAL);
//        priority = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
//        dispatch_set_target_queue(priority, _frozenCacheInfoQueue);
//
//        _diskQueue = dispatch_queue_create("com.enormego.egocache.disk", DISPATCH_QUEUE_CONCURRENT);
//        priority = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
//        dispatch_set_target_queue(priority, _diskQueue);
//
//
//        _directory = cacheDirectory;
//
//        _cacheInfo = [[NSDictionary dictionaryWithContentsOfFile:cachePathForKey(_directory, @"EGOCache.plist")] mutableCopy];
//
//        if(!_cacheInfo) {
//            _cacheInfo = [[NSMutableDictionary alloc] init];
//        }
//
//        [[NSFileManager defaultManager] createDirectoryAtPath:_directory withIntermediateDirectories:YES attributes:nil error:NULL];
//
//        NSTimeInterval now = [[NSDate date] timeIntervalSinceReferenceDate];
//        NSMutableArray* removedKeys = [[NSMutableArray alloc] init];
//
//        for(NSString* key in _cacheInfo) {
//            if([_cacheInfo[key] timeIntervalSinceReferenceDate] <= now) {
//                [[NSFileManager defaultManager] removeItemAtPath:cachePathForKey(_directory, key) error:NULL];
//                [removedKeys addObject:key];
//            }
//        }
//
//        [_cacheInfo removeObjectsForKeys:removedKeys];
//        self.frozenCacheInfo = _cacheInfo;
//        [self setDefaultTimeoutInterval:86400];
//    }
//
//    return self;
//}

@end
