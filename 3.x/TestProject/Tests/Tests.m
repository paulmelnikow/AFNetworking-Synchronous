@import Specta;
@import Expecta;
#import "AFNetworking.h"
#import "AFHTTPSessionManager+Synchronous.h"

@interface Helpers : NSObject
@end
@implementation Helpers
+ (NSURL *) baseURL {
    NSDictionary *environment = [[NSProcessInfo processInfo] environment];
    return [NSURL URLWithString:environment[@"HTTPBIN_BASE_URL"] ?: @"https://httpbin.org"];
}

+ (AFHTTPSessionManager *) manager {
    AFHTTPSessionManager *manager =
    [[AFHTTPSessionManager alloc] initWithBaseURL:self.baseURL];
    manager.completionQueue = dispatch_queue_create("AFNetworking+Synchronous", NULL);
    return manager;
}
@end

SpecBegin(AFNetworking1x)

describe(@"AFHTTPClient+Synchronous", ^{
    
    __block NSError *error;
    __block AFHTTPSessionManager *manager;
    beforeEach(^{
        manager = [Helpers manager];
        error = nil;
    });
    
    describe(@"For a successful request", ^{
        
        it(@"can GET", ^{
            // Execute.
            id result = [manager syncGET:@"get"
                              parameters:nil
                                    task:NULL
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
                                    task:NULL
                                   error:&error];
            // Confidence check.
            expect(error).to.beNil();
            expect(result).notTo.beNil();
            
            // Test.
            expect(result[@"args"]).to.equal(params);
        });

        it(@"sets the task pointer", ^{
            // Setup.
            NSURLSessionDataTask *task = nil;

            // Execute.
            id result = [manager syncGET:@"get"
                              parameters:nil
                                    task:&task
                                   error:&error];
            // Confidence check.
            expect(result).notTo.beNil();
            
            // Test.
            expect(task).to.beKindOf([NSURLSessionDataTask class]);
        });
    });
    
    describe(@"For a failed request", ^{
        
        it(@"returns nil and sets the error pointer", ^{
            // Execute.
            id result = [manager syncGET:@"status/503"
                              parameters:nil
                                    task:NULL
                                   error:&error];
            // Test.
            expect(result).to.beNil();
            expect(error).to.beInstanceOf([NSError class]);
            expect(error.localizedDescription).to.
                equal(@"Request failed: service unavailable (503)");
        });
        
    });
    
    describe(@"When running on the main thread", ^{
        
        it(@"throws an exception when the completion queue is the main queue", ^{
            // Setup.
            manager.completionQueue = dispatch_get_main_queue();
            
            // Test.
            expect(^{
                [manager syncGET:@"get" parameters:nil task:NULL error:&error];
            }).to.raise(NSInvalidArgumentException);
        });
        
        it(@"throws an exception when the completion queue is the default", ^{
            // Setup.
            manager.completionQueue = nil;
            
            // Test.
            expect(^{
                [manager syncGET:@"get" parameters:nil task:NULL error:&error];
            }).to.raise(NSInvalidArgumentException);
        });
        
    });
    
});

SpecEnd
