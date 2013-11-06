//
//  AFHTTPRequestOperation+ResponseObject.m
//  EQDocs
//
//  Created by Paul Melnikow on 5/17/13.
//
//

#import "AFHTTPRequestOperation+ResponseObject.h"

@implementation AFHTTPRequestOperation (ResponseObject)

- (id) responseObject { return [self responseData]; }

@end

@implementation AFJSONRequestOperation (ResponseObject)

- (id) responseObject { return [self responseJSON]; }

@end

@implementation AFXMLRequestOperation (ResponseObject)

- (NSXMLParser *) responseObject { return [self responseXMLParser]; }

@end

@implementation AFImageRequestOperation (ResponseObject)

- (id) responseObject { return [self responseImage]; }

@end
