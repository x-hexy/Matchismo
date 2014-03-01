//
//  Deck.h
//  Matchismo
//
//  Created by x-hexy on 2014/02/25.
//  Copyright (c) 2014年 ZJU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject


- (void)addCard:(Card*)card atTop:(BOOL)atTop;
- (void)addCard:(Card*)card;


- (Card *)drawRandomCard;


@end
