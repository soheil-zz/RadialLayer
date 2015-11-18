//
//  Extensions.m
//  RadialLayer
//
//  Created by Soheil Yasrebi on 11/15/15.
//  Copyright © 2015 Soheil Yasrebi. All rights reserved.
//

#import "Extensions.h"

@implementation UITableViewCell (Animation)
- (void)didMoveToSuperview {
    if ([Configs isActive: @"UITableViewCell"]) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [UIViewAnimation initWithView: self];
    }
}
@end

@implementation UIButton (Animation)
- (void)didMoveToSuperview {
    if ([Configs isActive:  @"UIButton"])
        [UIViewAnimation initWithView: self];
}
@end

@implementation UIImageView (Animation)
- (void)didMoveToSuperview {
    if ([Configs isActive:  @"UIImageView"])
        [UIViewAnimation initWithView: self];
}
@end
