//
//  RTTabBarController.h
//  RelayTionship
//
//  Created by Dru Kepple on 8/18/12.
//  Copyright (c) 2012 Dru Kepple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTCoreDataAgent.h"

@interface RTTabBarController : UITabBarController <UITabBarControllerDelegate>

@property (strong, nonatomic) RTCoreDataAgent *localStore;

@end
