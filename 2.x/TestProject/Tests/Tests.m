@import Specta;
@import Expecta;
#import "AFNetworking.h"
#import "AFHTTPRequestOperationManager+Synchronous.h"

@interface Helpers : NSObject
@end
@implementation Helpers
+ (NSURL *) baseURL {
    NSDictionary *environment = [[NSProcessInfo processInfo] environment];
    return [NSURL URLWithString:environment[@"HTTPBIN_BASE_URL"] ?: @"https://httpbin.org"];
}

+ (AFHTTPRequestOperationManager *) manager {
    AFHTTPRequestOperationManager *manager =
    [[AFHTTPRequestOperationManager alloc] initWithBaseURL:self.baseURL];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    return manager;
}
@end

SpecBegin(AFNetworking1x)

describe(@"AFHTTPClient+Synchronous", ^{
    
    __block NSError *error;
    __block AFHTTPRequestOperationManager *manager;
    beforeEach(^{
        manager = [Helpers manager];
        error = nil;
    });
    
    describe(@"For a successful request", ^{
        
        it(@"can GET", ^{
            // Execute.
            id result = [manager syncGET:@"get"
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
            id result = [manager syncGET:@"get"
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
            id result = [manager syncGET:@"get"
                              parameters:nil
                               operation:&operation
                                   error:&error];
            // Confidence check.
            expect(result).notTo.beNil();
            
            // Test.
            expect(operation).to.beInstanceOf([AFHTTPRequestOperation class]);
        });
    });
    
    describe(@"For a failed request", ^{
        
        it(@"returns nil and sets the error pointer", ^{
            // Execute.
            id result = [manager syncGET:@"status/503"
                              parameters:nil
                               operation:NULL
                                   error:&error];
            // Test.
            expect(result).to.beNil();
            expect(error).to.beInstanceOf([NSError class]);
            expect(error.localizedDescription).to.
                equal(@"Request failed: service unavailable (503)");
        });
        
    });
    
});

SpecEnd
