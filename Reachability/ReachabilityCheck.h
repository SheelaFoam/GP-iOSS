/*
 ******************************************************************************
 Copyright (c) 2016, Sheela Foam Pvt Ltd All rights reserved.
 * Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 *
 *****************************************************************************/

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SystemConfiguration/SystemConfiguration.h>
@interface ReachabilityCheck : NSObject{

@private
	BOOL _networkStatusNotificationsEnabled;
	
	NSString *_hostName;
	NSString *_address;
    
	NSMutableDictionary *reachabilityQueries;
    
}
/*
 An enumeration that defines the return values of the network state
 of the device.
 */
typedef enum
{
	NotReachable1 = 0,
	ReachableViaCarrierDataNetwork,
	ReachableViaWiFiNetwork
} NetworkStatus1;

#define kReachabilityChangedNotification @"kNetworkReachabilityChangedNotification"
extern NSString *kLinkLocalAddressKey;
extern NSString *kDefaultRouteKey;

// Set to YES to register for changes in network status. Otherwise reachability queries
// will be handled synchronously.
@property BOOL networkStatusNotificationsEnabled;
// The remote host whose reachability will be queried.
// Either this or 'addressName' must be set.
@property (nonatomic, retain) NSString *hostName;
// The IP address of the remote host whose reachability will be queried.
// Either this or 'hostName' must be set.
@property (nonatomic, retain) NSString *address;
// A cache of ReachabilityQuery objects, which encapsulate a SCNetworkReachabilityRef, a host or address, and a run loop. The keys are host names or addresses.
@property (nonatomic, strong) NSMutableDictionary *reachabilityQueries;

// This class is intended to be used as a singleton.
+ (ReachabilityCheck *)sharedReachability;

// Is self.hostName is not nil, determines its reachability.
// If self.hostName is nil and self.address is not nil, determines the reachability of self.address.
- (NetworkStatus1)remoteHostStatus;
// Is the device able to communicate with Internet hosts? If so, through which network interface?
- (NetworkStatus1)internetConnectionStatus;
// Is the device able to communicate with hosts on the local WiFi network? (Typically these are Bonjour hosts).
- (NetworkStatus1)localWiFiConnectionStatus;

/*
 When reachability change notifications are posted, the callback method 'ReachabilityCallback' is called
 and posts a notification that the client application can observe to learn about changes.
 */

// Hide by Charle
//static void ReachabilityCallback(SCNetworkReachabilityRef target, SCNetworkReachabilityFlags flags, void *info);

@end

@interface ReachabilityQuery : NSObject
{
@private
	SCNetworkReachabilityRef _reachabilityRef;
	CFMutableArrayRef _runLoops;
	NSString *_hostNameOrAddress;
}
// Keep around each network reachability query object so that we can
// register for updates from those objects.
@property (nonatomic) SCNetworkReachabilityRef reachabilityRef;
@property (nonatomic, retain) NSString *hostNameOrAddress;
@property (nonatomic) CFMutableArrayRef runLoops;

- (void)scheduleOnRunLoop:(NSRunLoop *)inRunLoop;

@end
