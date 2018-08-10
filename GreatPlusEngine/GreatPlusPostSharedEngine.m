/*
 ******************************************************************************
 Copyright (c) 2016, Sheela Foam Pvt Ltd All rights reserved.
 * Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 *
 *****************************************************************************/

#import "GreatPlusPostSharedEngine.h"
#import "UserDefaultStorage.h"
#import <UIKit/UIKit.h>
#import "Utility.h"

@implementation GreatPlusPostSharedEngine

@synthesize delegate;
@synthesize connection, tagName;


-(void)postDataUrl:(NSString *)urlString :(NSDictionary *)dicValue {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSError *error1;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dicValue options:NSJSONWritingPrettyPrinted error:&error1];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSString *bodyData=[NSString stringWithFormat:@"%@",jsonString];
    bodyData = [bodyData stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //    bodyData =  [bodyData stringByReplacingOccurrencesOfString:@" " withString:@""];
    bodyData = [bodyData stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSURL *url=[NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
//    [request setTimeoutInterval:15];
//    [self setTimerForResponseHandling];
    // Set the request's content type to application/x-www-form-urlencoded
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request addValue:@"aa97805dd5ff7027ac9e21d88049b787" forHTTPHeaderField:@"ApiKey"];
    //passing key as a http header request
    [request addValue:[Utility getUDIDofDevice] forHTTPHeaderField:@"DeviceId"];
    NSLog(@"[Utility getUDIDofDevice] = %@",[Utility getUDIDofDevice]);
    [request addValue:[Utility getIPAddress] forHTTPHeaderField:@"IpAddress"];
    NSLog(@"[Utility getIPAddress] = %@",[Utility getIPAddress]);
    if ([UserDefaultStorage getUserToken]) {
         [request addValue:[UserDefaultStorage getUserToken] forHTTPHeaderField:@"AccessToken"];
    }
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[NSData dataWithBytes:[bodyData UTF8String] length:[bodyData length]]];
    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
    if(self.connection) {
        webData = [[NSMutableData alloc]init];
    }
}


#pragma mark - NSURLConnectionDelegate methods

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [webData setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [webData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    if (webData) {
//        [self timerInvalidate];
        [self.delegate gettingData:webData WithTagName:[self getTagName]];
    }
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    webData = nil;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    if ([error code] == kCFURLErrorNotConnectedToInternet) {
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"No Connection Error" forKey:NSLocalizedDescriptionKey];
        NSError *noConnectionError = [NSError errorWithDomain:NSCocoaErrorDomain code:kCFURLErrorNotConnectedToInternet userInfo:userInfo];
        [self handleError:noConnectionError];
    } else {
        [self handleError:error];
    }
    self.connection = nil;
    [self.delegate errorInConnection];
}

- (void)handleError:(NSError *)error {

}

-(void)setTagNameWithName:(NSString *)tagname {
    self.tagName = tagname;
    
}

-(NSString *)getTagName{
    if (!self.tagName) {
        self.tagName = @"No Tag";
    }
    return self.tagName;
}

//-(void)setTimerForResponseHandling {
//    
//    [timerForResponse invalidate];
//    timerForResponse            = nil;
//    timeLeftInfo                = 1;
//    timerForResponse     = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateProgressBar:) userInfo:self repeats:YES];
//}
//
//- (void)updateProgressBar:(NSNotification *)notif {
//    timeLeftInfo = timeLeftInfo + 1;
//    NSLog(@"%lld", timeLeftInfo);
//    if (timeLeftInfo == 15) {
//        [connection cancel];
//        [self timerInvalidate];
//        [self.delegate timeErrorHandlingInSharedEngine:15];
//    }
//}
//
//-(void)timerInvalidate {
//    [timerForResponse invalidate];
//    timerForResponse            = nil;
//}


@end
