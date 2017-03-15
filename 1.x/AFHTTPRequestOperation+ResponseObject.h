#import "AFNetworking.h"

#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED)
#import <UIKit/UIKit.h>
#elif defined(__MAC_OS_X_VERSION_MIN_REQUIRED)
#import <Cocoa/Cocoa.h>
#endif

/**
 Category definining a method on `AFHTTPRequestOperation` which subclasses
 should use to return response data.

 **This category is for AFNetworking 1.x.**
 */
@interface AFHTTPRequestOperation (ResponseObject)

/**
 Return an object derived from the response data.

 Subclasses must override this method, and may redeclare it to indicate its
 type.

 If a custom subclass does asynchronous processing in its completion blocks,
 you may need to use the using-completion-blocks branch.
 */
- (id) responseObject;

@end

/**
 Implementation of the `ResponseObject` categor for `AFXMLRequestOperation`.

 **This category is for AFNetworking 1.x.**
 */
@interface AFXMLRequestOperation (ResponseObject)

/**
 An `NSXMLParser` object constructed from the response data.
 */
- (NSXMLParser *) responseObject;

@end

/**
 Implementation of the `ResponseObject` categor for `AFImageRequestOperation`.

 **This category is for AFNetworking 1.x.**

 If you're using the `processingBlock`, which contains essential processing in
 the completion handler, or your subclass performs other asynchronous
 processing in the completion handler, use the version in the
 using-completion-blocks branch.
 */
@interface AFImageRequestOperation (ResponseObject)

/**
 An image constructed from the response data.
 */
#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED)
- (UIImage *) responseObject;
#elif defined(__MAC_OS_X_VERSION_MIN_REQUIRED)
- (NSImage *) responseObject;
#endif

@end
