//
//  FileShareManage.h
//  FileShare
//
//  Created by 帝青的Mac on 2018/11/5.
//  Copyright © 2018年 帝青的Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileShareManage : NSObject

+ (instancetype)sharedInstance;

- (NSArray *)getAllFile;

@end
