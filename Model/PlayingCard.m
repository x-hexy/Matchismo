//
//  PlayingCard.m
//  Matchismo
//
//  Created by x-hexy on 2014/02/25.
//  Copyright (c) 2014年 ZJU. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    if ([otherCards count] == 1) {
        PlayingCard *otherCard = [otherCards firstObject];
        if ([self.suit isEqualToString:otherCard.suit]) {
            score = 1;
        } else if (self.rank == otherCard.rank){
            score = 4;
        }
    }
    
    if ([otherCards count] == 2) {
        
        // compare already chosen two cards first
        PlayingCard *firstCard = [otherCards firstObject];
        PlayingCard *secondCard = [otherCards objectAtIndex:1];
        if ([firstCard.suit isEqualToString:secondCard.suit]) {
            score = 1;
        } else if (firstCard.rank == secondCard.rank) {
            score = 2;
        }
        
        // compare currently chosen card with already chosen cards
        for (PlayingCard *otherCard in otherCards) {
            if ([self.suit isEqualToString:otherCard.suit]) {
                score += 1;
            } else if (self.rank == otherCard.rank) {
                score += 2;
            }
        }
    }
    
    return score;
}

- (NSString *) contents
{
//    return [NSString stringWithFormat:@"%d%@", self.rank, self.suit];
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit; // because we provide setter AND getter


+ (NSArray *)validSuits
{
    return @[@"♥︎", @"♦︎", @"♠︎", @"♣︎"];
}

- (void) setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank
{
    return [[self rankStrings] count]-1;
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

@end
