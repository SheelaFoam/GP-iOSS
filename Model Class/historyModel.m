//
//  historyModel.m
//  Patient
//
//  Created by Alok Singh on 5/20/16.
//  Copyright © 2016 mithun ravi. All rights reserved.
//

#import "historyModel.h"

@implementation historyModel

static historyModel* _sharedhistoryModel = nil;

+(historyModel*)sharedhistoryModel
{
    @synchronized([historyModel class])
    {
        if (!_sharedhistoryModel)
            _sharedhistoryModel = [[self alloc] init];
        
        return _sharedhistoryModel;
    }
    
    return nil;
}

-(id)initWithCoder:(NSCoder *)decoder{
    self = [super init];
    if(self){
        self.clientUrl = [decoder decodeObjectForKey:@"clientUrl"];
        self.homeArray = [decoder decodeObjectForKey:@"homeArray"];
        self.homeDataDic = [decoder decodeObjectForKey:@"homeDataDic"];
        self.homeDataDicStep2 = [decoder decodeObjectForKey:@"homeDataDicStep2"];
        self.webStr = [decoder decodeObjectForKey:@"webStr"];
        self.userEmail = [decoder decodeObjectForKey:@"userEmail"];
        self.uID = [decoder decodeObjectForKey:@"uID"];
        self.menuTitle = [decoder decodeObjectForKey:@"menuTitle"];
        self.uid = [decoder decodeObjectForKey:@"uid"];
        self.token = [decoder decodeObjectForKey:@"token"];
        self.authType = [decoder decodeObjectForKey:@"authType"];
        self.displayname = [decoder decodeObjectForKey:@"displayname"];
        self.opRoleName = [decoder decodeObjectForKey:@"opRoleName"];
        self.opUserType = [decoder decodeObjectForKey:@"opUserType"];
        self.opUserEmpGroupCode = [decoder decodeObjectForKey:@"opUserEmpGroupCode"];
        self.opGreatplususerId = [decoder decodeObjectForKey:@"opGreatplususerId"];
        self.opUserzone = [decoder decodeObjectForKey:@"opUserzone"];
        self.menuLink = [decoder decodeObjectForKey:@"menuLink"];
        self.poolTable = [decoder decodeObjectForKey:@"poolTable"];
        self.poolstr = [decoder decodeObjectForKey:@"poolstr"];
        self.opuserRoleName = [decoder decodeObjectForKey:@"opuserRoleName"];
        self.area = [decoder decodeObjectForKey:@"area"];
        self.hight = (int)[decoder decodeIntegerForKey:@"hight"];
        self.userName = [decoder decodeObjectForKey:@"userName"];
        self.opuseremailid = [decoder decodeObjectForKey:@"opuseremailid"];
        self.mobileNo = [decoder decodeObjectForKey:@"mobileNo"];
        self.imageUrl = [decoder decodeObjectForKey:@"imageUrl"];
        self.checkHomeORMenu = [decoder decodeObjectForKey:@"checkHomeORMenu"];
        self.latitudeStr = [decoder decodeObjectForKey:@"latitudeStr"];
        self.longitudeStr = [decoder decodeObjectForKey:@"longitudeStr"];
        self.deviceOS = [decoder decodeObjectForKey:@"deviceOS"];
        self.deviceID = [decoder decodeObjectForKey:@"deviceID"];
        self.deviceName = [decoder decodeObjectForKey:@"deviceName"];
        self.stateAndCityArray = [decoder decodeObjectForKey:@"stateAndCityArray"];
        
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.clientUrl forKey:@"clientUrl"];
    [encoder encodeObject:self.homeArray forKey:@"homeArray"];
    [encoder encodeObject:self.homeDataDic forKey:@"homeDataDic"];
    [encoder encodeObject:self.homeDataDicStep2 forKey:@"homeDataDicStep2"];
    [encoder encodeObject:self.webStr forKey:@"webStr"];
    [encoder encodeObject:self.userEmail forKey:@"userEmail"];
    [encoder encodeObject:self.uID forKey:@"uID"];
    [encoder encodeObject:self.menuTitle forKey:@"menuTitle"];
    [encoder encodeObject:self.uid forKey:@"uid"];
    [encoder encodeObject:self.token forKey:@"token"];
    [encoder encodeObject:self.authType forKey:@"authType"];
    [encoder encodeObject:self.displayname forKey:@"displayname"];
    [encoder encodeObject:self.opRoleName forKey:@"opRoleName"];
    [encoder encodeObject:self.opUserType forKey:@"opUserType"];
    [encoder encodeObject:self.opUserEmpGroupCode forKey:@"opUserEmpGroupCode"];
    [encoder encodeObject:self.opGreatplususerId forKey:@"opGreatplususerId"];
    [encoder encodeObject:self.opUserzone forKey:@"opUserzone"];
    [encoder encodeObject:self.menuLink forKey:@"menuLink"];
    [encoder encodeObject:self.poolTable forKey:@"poolTable"];
    [encoder encodeObject:self.poolstr forKey:@"poolstr"];
    [encoder encodeObject:self.opuserRoleName forKey:@"opuserRoleName"];
    [encoder encodeObject:self.area forKey:@"area"];
    [encoder encodeInt:self.hight forKey:@"hight"];
    [encoder encodeObject:self.userName forKey:@"userName"];
    [encoder encodeObject:self.opuseremailid forKey:@"opuseremailid"];
    [encoder encodeObject:self.mobileNo forKey:@"mobileNo"];
    [encoder encodeObject:self.imageUrl forKey:@"imageUrl"];
    [encoder encodeObject:self.checkHomeORMenu forKey:@"checkHomeORMenu"];
    [encoder encodeObject:self.latitudeStr forKey:@"latitudeStr"];
    [encoder encodeObject:self.longitudeStr forKey:@"longitudeStr"];
    [encoder encodeObject:self.deviceOS forKey:@"deviceOS"];
    [encoder encodeObject:self.deviceID forKey:@"deviceID"];
    [encoder encodeObject:self.deviceName forKey:@"deviceName"];
    [encoder encodeObject:self.stateAndCityArray forKey:@"stateAndCityArray"];
}



//-(instancetype)initWithObj:(NSObject *)obj{
//{
//    self = [super init];
//    self = obj;
//    return self;
//}
-(void)initWithObj:(NSObject *)obj{
    _sharedhistoryModel = (historyModel *)obj;
   // return  self;
}


-(void)setHomeDataDicStep2:(NSDictionary *)homeDataDicStep2{
    _homeDataDicStep2 = homeDataDicStep2;
}

@end
