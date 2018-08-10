/*
 ******************************************************************************
 Copyright (c) 2016, Sheela Foam Pvt Ltd All rights reserved.
 * Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 *
 *****************************************************************************/

#import "GreatPlusGetSharedEngine.h"

@implementation GreatPlusGetSharedEngine
@synthesize delegate, tagName;

#pragma MARK for Passing the URL to Server

-(void)passUrl:(NSString *)urlString {
    NSString *urlStr = urlString;
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setTimeoutInterval:15];
    [request setHTTPMethod:@"POST"];
    connection = [NSURLConnection connectionWithRequest:request delegate:self];
    if(connection) {
        webData = [[NSMutableData alloc]init];
    }
}

#pragma MARK for Recieving the Response from Server

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [webData setLength:0];
}

#pragma MARK for Recieving the Data from Server

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [webData appendData:data];
}

#pragma MARK for Finsh loading from Server

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    if (webData) {
        [self.delegate finishParshingData:webData withTagName:[self getTagName] andTime:0];
    }
}

#pragma MARK for Setting Tag Name

-(void)setTagNameWithName:(NSString *)tagname{
    self.tagName = tagname;
}

#pragma MARK for Getting Tag Name

- (NSString *)getTagName {
    if (!self.tagName) {
        self.tagName = @"No Tag";
    }
    return self.tagName;
}

@end
