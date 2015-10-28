//
//  PlayScene.swift
//  ChineseMonster
//
//  Created by mackbook on 15/6/7.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

import Foundation
class PlayScene : CCNode, CCPhysicsCollisionDelegate
{
    var _launchButton1: CCButton!
    var _launchButton2: CCButton!
    var _launchButton3: CCButton!
    var _physicsNodes: CCPhysicsNode!
    var _monsters: [BlueMonster] = []
    var _orangeMonsters: [OrangeMonster] = []
    var _iceMonsters: [IceMonster] = []
    var _enemyMonsters: [CCNode] = []
    
    var _enemyPoints: NSInteger = 30
    var _homePoints: NSInteger = 30
    var _enemyLife: CCLabelTTF!
    var _homeLife: CCLabelTTF!
    var _homeMonster: CCNode!
    var _enemyMonster: CCNode!
    
    var burnFlag = false
    var freezeFlag = false
    var freezeTimes = 30
    func didLoadFromCCB() {
        _physicsNodes.collisionDelegate = self
        userInteractionEnabled = true
        
    }
    func launchMonster()
    {
        // create and add a new monster
        let monster = CCBReader.load("BlueMonster") as! BlueMonster
        monster.position = ccp(_launchButton1.position.x, _launchButton1.position.y + 25)
        _homeMonster.addChild(monster)
        _monsters.append(monster)
        
    }
    func launchOrange()
    {
        // create and add a new monster
        let monster = CCBReader.load("Orange") as! OrangeMonster
        monster.position = ccp(_launchButton2.position.x, _launchButton2.position.y + 25)
        _homeMonster.addChild(monster)
        _orangeMonsters.append(monster)
        
    }
    func launchIce()
    {
        // create and add a new monster
        let monster = CCBReader.load("IceMonster") as! IceMonster
        monster.position = ccp(_launchButton3.position.x, _launchButton3.position.y + 25)
        _homeMonster.addChild(monster)
        _iceMonsters.append(monster)
        
    }
    
    
    override func update(delta: CCTime) {
        if(arc4random_uniform(100) < 2){
            spawnEnemyMonster()
        }
        for monster in _monsters{
            if(monster.releaseFlag){
                monster.position.y += 1
            }
        }
        for monster in _orangeMonsters{
            if(monster.releaseFlag){
                monster.position.y += 1
            }
        }
        
        
        
        for monster in _iceMonsters{
            if(monster.releaseFlag){
                monster.position.y += 1
                //随机概率冰冻敌人
                if(arc4random_uniform(100) < 2 && freezeFlag == false){
                       freezeFlag = true
                }
            }
        }
        if(freezeFlag == true){
            freezeTimes--
            for monster in _enemyMonsters{
                monster.color = CCColor.blueColor()
            }
            
        }else{
                for monster in _enemyMonsters{
                    monster.color = CCColor.whiteColor()
                    monster.position.y -= 1
                }
        }
        if(freezeTimes == 0){
            freezeFlag = false
            freezeTimes = 30
        }
    }
    
    func spawnEnemyMonster()
    {
        let monster = CCBReader.load("SnowMonster")
        let x = arc4random_uniform(300)
        monster.position = ccp(CGFloat(x),500)
        _enemyMonster.addChild(monster)
        _enemyMonsters.append(monster)
    }
    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, enemyHome: CCNode!, blue: CCNode!) -> Bool {
        
        _enemyPoints--
        _enemyLife.string = String(_enemyPoints)
        return true
    }
    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, myHome: CCNode!, enemy: CCNode!) -> Bool {
        
        _homePoints--
        _homeLife.string = String(_homePoints)
        return true
    }
    
    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, enemy: CCNode!, blue: CCNode!) -> Bool {
        
        blue.removeFromParent()
        var blueMonstersT: [CCNode] = _monsters
        _monsters.removeAtIndex(find(blueMonstersT, blue)!)
        enemy.removeFromParent()
        _enemyMonsters.removeAtIndex(find(_enemyMonsters, enemy)!)
       
        return true
    }
    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, enemy: CCNode!, orange: OrangeMonster!) -> Bool {
        orange.times--
        if(orange.times == 0)
        {
        orange.removeFromParent()
        var orangeMonstersT: [CCNode] = _orangeMonsters
        _orangeMonsters.removeAtIndex(find(orangeMonstersT, orange)!)
        }
        enemy.removeFromParent()
        _enemyMonsters.removeAtIndex(find(_enemyMonsters, enemy)!)
        
        return true
    }
    
    
    func cure()
    {
        if(_homePoints + 5 < 30){
            _homePoints += 5
        }else{
            _homePoints = 30
        }
        _homeLife.string = String(_homePoints)
    }
    
    func kill()
    {
        var move = CCActionEaseBounceOut(action: CCActionMoveBy(duration: 0.3, position: ccp(0, 4)))
        var moveBack = CCActionEaseBounceOut(action: move.reverse())
        var shakeSequence = CCActionSequence(array: [move, moveBack,move,moveBack])
        self.runAction(shakeSequence)
        
        for monster in _enemyMonsters{
            monster.removeFromParent()
            _enemyMonsters.removeAtIndex(find(_enemyMonsters, monster)!)
        }
    }
    
    func burn()
    {
        NSLog("burn")
        burnFlag = true;
    }
    override func touchBegan(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        
            if(burnFlag){
            let touchpostion = touch.locationInWorld()
            let fire = CCBReader.load("fire")
            fire.position = touchpostion
            self.addChild(fire)
            var wait = CCActionDelay(duration: 1)
            var remove = CCActionRemove()
            var sequence = CCActionSequence(array: [wait,remove])
            fire.runAction(sequence)
             NSLog("touchBurn")
            for monster in _enemyMonsters{
                if(monster.position.y > touchpostion.y - 20 && monster.position.y < touchpostion.y + 20){
                    monster.removeFromParent()
                    _enemyMonsters.removeAtIndex(find(_enemyMonsters, monster)!)
                }
            }
        }
        burnFlag = false
    }
    
    
}