@import Specta;
@import Expecta;
#import "AFNetworking.h"
#import "AFHTTPClient+Synchronous.h"

@interface Helpers : NSObject
@end
@implementation Helpers
+ (NSURL *) baseURL {
    NSDictionary *environment = [[NSProcessInfo processInfo] environment];
    return [NSURL URLWithString:environment[@"HTTPBIN_BASE_URL"] ?: @"https://httpbin.org"];
}

+ (AFHTTPClient *) client {
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:self.baseURL];
    [client registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [client setDefaultHeader:@"Accept" value:@"application/json; version=1.0;"];
    return client;
}
@end

SpecBegin(AFNetworking1x)

describe(@"AFHTTPClient+Synchronous", ^{
    
    __block NSError *error;
    __block AFHTTPClient *client;
    beforeEach(^{
        client = [Helpers client];
        error = nil;
    });
    
    describe(@"For a successful request", ^{
        
        it(@"can GET", ^{
            // Execute.
            id result = [client synchronouslyGetPath:@"get"
                                          parameters:nil
                                           operation:NULL
                                               error:&error];
            // Confidence check.
            expect(error).to.beNil();
            
            // Test.
            expect(result).notTo.beNil();
        });
        
        it(@"passes parameters to the request", ^{
            // Setup.
            NSDictionary *params = @{@"foo": @"bar", @"baz": @"123"};
            
            // Execute.
            id result = [client synchronouslyGetPath:@"get"
                                          parameters:params
                                           operation:NULL
                                               error:&error];
            // Confidence check.
            expect(error).to.beNil();
            expect(result).notTo.beNil();
            
            // Test.
            expect(result[@"args"]).to.equal(params);
        });

        it(@"sets the operation pointer", ^{
            // Setup.
            AFHTTPRequestOperation *operation = nil;

            // Execute.
            id result = [client synchronouslyGetPath:@"get"
                                          parameters:nil
                                           operation:&operation
                                               error:&error];
            // Confidence check.
            expect(result).notTo.beNil();
            
            // Test.
            expect(operation).to.beInstanceOf([AFJSONRequestOperation class]);
        });
    });
    
    describe(@"For a failed request", ^{
        
        it(@"returns nil and sets the error pointer", ^{
            // Execute.
            id result = [client synchronouslyGetPath:@"status/503"
                                          parameters:nil
                                           operation:NULL
                                               error:&error];
            // Test.
            expect(result).to.beNil();
            expect(error).to.beInstanceOf([NSError class]);
            expect(error.localizedDescription).to.
                equal(@"Expected status code in (200-299), got 503");
        });
        
    });
    
});

SpecEnd
