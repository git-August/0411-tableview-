//
//  cellShow.m
//  0411-tableview单组展示
//
//  Created by Ibokan on 15/4/11.
//  Copyright (c) 2015年 focus. All rights reserved.
//

#import "cellShow.h"

@implementation cellShow
+(id)cellWithtitle:(NSString *)title andSubtitle:(NSString *)subtitle andIcon:(NSString *)icon{
    cellShow * cellShowContent = [[cellShow alloc] init];
    cellShowContent.title = title;
    cellShowContent.subtitle = subtitle;
    cellShowContent.icon = icon;
    return cellShowContent;
}
@end
