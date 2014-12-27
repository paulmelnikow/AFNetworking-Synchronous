//
//  AFHTTPRequestOperation+ResponseObject.h
//  EQDocs
//
//  Created by Paul Melnikow on 5/17/13.
//
//

#import "AFNetworking.h"

#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED)
#import <UIKit/UIKit.h>
#elif defined(__MAC_OS_X_VERSION_MIN_REQUIRED)
#import <Cocoa/Cocoa.h>
#endif

@interface AFHTTPRequestOperation (ResponseObject)

/**
 Category defines an abstract method on AFHTTPRequestOperation which subclasses should use to return response data.
 
 If you use custom operation subclasses, be sure to define this method in your subclass. Note that if your subclass does asynchronous processing in its completion blocks, you may need to use the using-completion-blocks branch instead. See AFHTTPClient+Synchronous.h for more information.
 
 Subclasses must override this method, and may redeclare it to indicate its type.
 */
- (id) responseObject;

@end

@interface AFXMLRequestOperation (ResponseObject)

- (NSXMLParser *) responseObject;

@end

@interface AFImageRequestOperation (ResponseObject)

#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED)
- (UIImage *) responseObject;
#elif defined(__MAC_OS_X_VERSION_MIN_REQUIRED)
- (NSImage *) responseObject;
#endif

@end