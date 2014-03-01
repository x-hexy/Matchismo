//
//  Card.m
//  Matchismo
//
//  Created by x-hexy on 2014/02/25.
//  Copyright (c) 2014年 ZJU. All rights reserved.
//

#import "Card.h"

@interface Card()
// Private declarations can go here.

@end

@implementation Card






- (int)match:(NSArray*)otherCards
{
    int score = 0;
    
    for (Card* card in otherCards){
        if([card.contents isEqualToString:self.contents]){
            score = 1;
        }
    }
    
    
    return score;
}

@end
