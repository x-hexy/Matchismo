//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by x-hexy on 2014/03/07.
//  Copyright (c) 2014年 ZJU. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; // of Card

@end

@implementation CardMatchingGame

- (NSMutableArray *) cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        for (int i=0; i<count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            }else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void) chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
            self.matchingResult =@"";
        } else {
            switch (self.gameMode) {
                case 0:
                    [self twoCardMatch:card];
                    break;
                case 1:
                    [self threeCardMatch:card];
                    break;
                    
                default:
                    break;
            }
        }
    }
}

- (void) twoCardMatch:(Card *)card
{
    //match against another card
    for (Card *otherCard in self.cards) {
        if (otherCard.isChosen && !otherCard.isMatched){
            int matchScore = [card match:@[otherCard]];
            if (matchScore) {
                self.score += matchScore * MATCH_BONUS;
                card.matched = YES;
                otherCard.matched = YES;
                self.matchingResult = [NSString stringWithFormat:@"Matched %@ %@ for %d points.", otherCard.contents, card.contents, matchScore * MATCH_BONUS];
            } else {
                self.score -= MISMATCH_PENALTY;
                otherCard.chosen = NO;
                self.matchingResult = [NSString stringWithFormat:@"%@ %@ don't match! %d point penalty!", otherCard.contents, card.contents, MISMATCH_PENALTY];
            }
            break;
        }
        self.matchingResult = card.contents;
    }
    self.score -= COST_TO_CHOOSE;
    card.chosen = YES;
}

- (void) threeCardMatch:(Card *)card
{
    int matchScore = 0;
    
    // find chosen but not matched cards
    NSMutableArray *comparingCards = [[NSMutableArray alloc] init];
    for (Card *comparingCard in self.cards) {
        if (comparingCard.isChosen && !comparingCard.isMatched) {
            [comparingCards addObject:comparingCard];
        }
    }
    
    if ([comparingCards count] == 1) {
        Card *comparingCard = [comparingCards firstObject];
        matchScore = [card match:@[comparingCard]];
        if (matchScore) {
//            self.score += matchScore * MATCH_BONUS;
//            self.matchingResult = [NSString stringWithFormat:@"Matched %@ %@ for %d points.", comparingCard.contents, card.contents, matchScore * MATCH_BONUS];
            self.matchingResult = [NSString stringWithFormat:@"%@ %@ matched.", comparingCard.contents, card.contents];
        } else {
            self.matchingResult = [NSString stringWithFormat:@"%@ and %@, no match yet.", comparingCard.contents, card.contents];
        }
        
//        self.matchingResult = card.contents;
        
    } else if ([comparingCards count] == 2) {
        matchScore = [card match:comparingCards];
        if (matchScore) {
            self.score += matchScore * MATCH_BONUS;
            card.matched = YES;
            for (Card* comparedCard in comparingCards)
                comparedCard.matched = YES;
            self.matchingResult = [NSString stringWithFormat:@"Matched! %d points added.", matchScore * MATCH_BONUS];
            
        } else {
            self.score -= MISMATCH_PENALTY;
            self.matchingResult = @"";
            for (Card *comparedCard in comparingCards) {
                comparedCard.chosen = NO;
                self.matchingResult = [self.matchingResult stringByAppendingFormat:@"%@ ", comparedCard.contents];
            }
            
            self.matchingResult = [self.matchingResult stringByAppendingFormat:@"%@ not matched! %d point penalty!", card.contents, MISMATCH_PENALTY];
            
        }
        
    } else if ([comparingCards count] == 0) {
        self.matchingResult = card.contents;
    }
    
    self.score -= COST_TO_CHOOSE;
    card.chosen = YES;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? [self.cards objectAtIndex:index] : nil;
}


@end
