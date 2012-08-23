//
//  RTViewController.h
//  RelayTionship
//
//  Created by Dru Kepple on 8/20/12.
//  Copyright (c) 2012 Dru Kepple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTCoreDataAgent.h"


@protocol RTViewControllerLocalStore <NSObject>

@property (strong, nonatomic) RTCoreDataAgent *localStore;

@end


@interface RTViewController : UIViewController <RTViewControllerLocalStore>

@property (strong, nonatomic) RTCoreDataAgent *localStore;

@end
