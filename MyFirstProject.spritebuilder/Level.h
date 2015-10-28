//
//  Level.h
//  MyFirstProject
//
//  Created by mackbook on 15/5/30.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#ifndef MyFirstProject_Level_h
#define MyFirstProject_Level_h
#import "CCNode.h"

@interface Level : CCNode
{
    CCNode * _physicsNode;
    CCNode * _launcher;
}

@end

#endif
