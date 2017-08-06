//
//  BadgeButton.m
//  DTE
//
//  Created by Divya Jain on 5/24/17.
//  Copyright © 2017 Divya Jain. All rights reserved.
//

#import "BadgeButton.h"
#import "CustomBadge.h"
static int i ;
@implementation BadgeButton

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        i=0;
        [self addBadge];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addBadge) name:@"addBadge" object:nil];
    }
    return self;
}


-(void)addBadge
{
    i = i+1;
    NSString *successRemainingStr = [NSString stringWithFormat:@"%d",i];
    CustomBadge *badge = [CustomBadge customBadgeWithString:successRemainingStr];
    CGFloat y;
    
    //    y = badge.frame.origin.y + badge.frame.size.height;
    y= 0;
    CGPoint point = CGPointMake(self.frame.size.width-badge.frame.size.width/2 + 3, y);
    CGSize size = CGSizeMake(15,15);
    CGRect rect = CGRectMake(point.x, point.y, size.width, size.height);
    [badge setFrame:rect];
    
    BadgeStyle *badgeStyle = [BadgeStyle freeStyleWithTextColor:[UIColor greenColor] withInsetColor:[UIColor colorWithRed:17.0/255.0 green:80/255.0 blue:100.0/255.0 alpha:1.0] withFrameColor:nil withFrame:nil withShadow:nil withShining:nil withFontType:BadgeStyleFontTypeHelveticaNeueLight];
    [badge setBadgeStyle:badgeStyle];
    [self addSubview:badge];
    
}

@end
