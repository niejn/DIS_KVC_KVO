//
//  DSKeyValueMutableOrderedSet.m
//  DIS_KVC_KVO
//
//  Created by renjinkui on 2017/2/28.
//  Copyright © 2017年 JK. All rights reserved.
//

#import "DSKeyValueMutableOrderedSet.h"
#import "DSKeyValueGetter.h"

@implementation DSKeyValueMutableOrderedSet
- (id)_proxyInitWithContainer:(id)container getter:(DSKeyValueGetter *)getter {
    if(self = [super init]) {
        _container =  [container retain];
        _key = getter.key.copy;
    }
    return self;
}

+ (NSHashTable *)_proxyShare {
    static NSHashTable * proxyShare = nil;
    if(!proxyShare) {
        proxyShare = [_DSKeyValueProxyShareCreate() retain];
    }
    return proxyShare;
}

- (DSKeyValueProxyLocator)_proxyLocator {
    return (DSKeyValueProxyLocator){_container,_key};
}

- (void)_proxyNonGCFinalize {
    [_key release];
    _key = nil;
    
    [_container release];
    _container = nil;
}

+ (DSKeyValueProxyNonGCPoolPointer *)_proxyNonGCPoolPointer {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (void)dealloc {
    if(_DSKeyValueProxyDeallocate(self)) {
        [super dealloc];
    }
}
@end
