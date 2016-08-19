//
//  CALayer+XibConfiguration.h
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/20.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
@class UIColor;
@interface CALayer (XibConfiguration)
// This assigns a CGColor to borderColor.
@property(nonatomic, assign) UIColor* borderUIColor;
@end
