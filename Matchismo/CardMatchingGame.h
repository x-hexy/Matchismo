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

// designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck: (Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger) index;
- (Card *)cardAtIndex:(NSUInteger) index;

// matchingResult for later presenting
@property (nonatomic) NSString *matchingResult;

// play mode: 2-card-match mode (0) or 3-card-match mode (1)
@property (nonatomic) NSUInteger gameMode;

@property (nonatomic, readonly) NSInteger score;

@end
