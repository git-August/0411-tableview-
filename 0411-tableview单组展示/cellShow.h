//
//  cellShow.h
//  0411-tableview单组展示
//
//  Created by Ibokan on 15/4/11.
//  Copyright (c) 2015年 focus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface cellShow : NSObject
@property (nonatomic,copy) NSString * title;
@property (nonatomic,copy) NSString * subtitle;
@property (nonatomic,copy) NSString * icon;

+(id) cellWithtitle:(NSString *)title andSubtitle:(NSString *)subtitle andIcon:(NSString *)icon;
@end
