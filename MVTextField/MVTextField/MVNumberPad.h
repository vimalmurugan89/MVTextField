//
//  MVNumberPad.h
//  MVTextField
//
//  Created by admin on 13/02/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <UIKit/UIKit.h>


#define iPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)


@class MVTextField;
@interface MVNumberPad : UIView
-(void)setMVTextField:(MVTextField*)field;
+(id)numberPad;
@end
