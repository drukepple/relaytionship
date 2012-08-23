//
//  RTNavController.h
//  RelayTionship
//
//  Created by Dru Kepple on 8/21/12.
//  Copyright (c) 2012 Dru Kepple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTViewController.h"


@interface RTNavController : UINavigationController <RTViewControllerLocalStore>

@property (strong, nonatomic) RTCoreDataAgent * localStore;

@end
