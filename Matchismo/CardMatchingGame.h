//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by x-hexy on 2014/03/07.
//  Copyright (c) 2014年 ZJU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck: (Deck *)deck;

- (void)chooseCareAtIndex:(NSUInteger) index;

- (Card *)cardAtIndex:(NSUInteger) index;

@property (nonatomic, readonly) NSInteger score;

@end
