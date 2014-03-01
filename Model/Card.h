//
//  Card.h
//  Matchismo
//
//  Created by x-hexy on 2014/02/25.
//  Copyright (c) 2014年 ZJU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter = isChosen) BOOL chosen;
@property (nonatomic, getter = isMatched) BOOL matched;

- (int)match:(NSArray*)otherCards;




@end
