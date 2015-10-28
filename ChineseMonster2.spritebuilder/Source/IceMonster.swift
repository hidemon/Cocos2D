//
//  IceMonster.swift
//  ChineseMonster
//
//  Created by mackbook on 15/6/16.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

import Foundation
class IceMonster: CCSprite
{
    var releaseFlag = false
    var freezeFlag = false
    var time = 6
    
    func didLoadFromCCB() {
        userInteractionEnabled = true
        multipleTouchEnabled = true // required for tracking multiple touches
      
       
    
      
    }
    
    override func touchBegan(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        self.position = touch.locationInWorld()
       
    }
    override func touchMoved(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        self.position = touch.locationInWorld()
    }
    override func touchEnded(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        releaseFlag = true;
    }
   
    
}
