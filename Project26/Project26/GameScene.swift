//
//  GameScene.swift
//  Project26
//
//  Created by Jeffrey Eng on 9/8/16.
//  Copyright (c) 2016 Jeffrey Eng. All rights reserved.
//

import SpriteKit

enum CollisionTypes: UInt32 {
    case Player = 1
    case Wall = 2
    case Star = 4
    case Vortex = 8
    case Finish = 16
}

class GameScene: SKScene {
    
    //adding player property so we can reference the player throughout the game
    var player: SKSpriteNode!
    
    // property to help track touch position so we can simulate tilting on iOS simulator
    var lastTouchPosition: CGPoint?
    
    override func didMoveToView(view: SKView) {
        let background = SKSpriteNode(imageNamed: "background.jpg")
        background.blendMode = .Replace
        background.position = CGPoint(x: 512, y: 384)
        background.zPosition = -1
        addChild(background)
        
        // setting the gravity roughly equivalent to Earth
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        loadLevel()
        createPlayer()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // Set the value of the lastTouchPosition property here
        if let touch = touches.first {
            let location = touch.locationInNode(self)
            lastTouchPosition = location
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.locationInNode(self)
            lastTouchPosition = location
        }
    }
   
    override func update(currentTime: CFTimeInterval) {

    }
    
    func loadLevel() {
        // get the file path for the level from NSBundle
        if let levelPath = NSBundle.mainBundle().pathForResource("level1", ofType: "txt") {
            if let levelString = try? String(contentsOfFile: levelPath, usedEncoding: nil) {
                let lines = levelString.componentsSeparatedByString("\n")
                
                //enumerate through each row but in reverse since the level is being built from bottom to top
                for (row, line) in lines.reverse().enumerate() {
                    //enumerate through each letter in line
                    for (column, letter) in line.characters.enumerate() {
                        let position = CGPoint(x: (64 * column) + 32, y: (64 * row) + 32)
                        
                        if letter == "x" {
                            let node = SKSpriteNode(imageNamed: "block")
                            node.position = position
                            
                            node.physicsBody = SKPhysicsBody(rectangleOfSize: node.size)
                            node.physicsBody!.categoryBitMask = CollisionTypes.Wall.rawValue
                            node.physicsBody!.dynamic = false
                            addChild(node)
                        } else if letter == "v" {
                            let node = SKSpriteNode(imageNamed: "vortex")
                            node.name = "vortex"
                            node.position = position
                            node.runAction(SKAction.repeatActionForever(SKAction.rotateByAngle(CGFloat(M_PI), duration: 1)))
                            node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
                            node.physicsBody!.dynamic = false
                            
                            node.physicsBody!.categoryBitMask = CollisionTypes.Vortex.rawValue
                            //setting contactTestBitMask to value of player's category so we get notified when these two touch
                            node.physicsBody!.contactTestBitMask = CollisionTypes.Player.rawValue
                            node.physicsBody!.collisionBitMask = 0
                            addChild(node)
                        } else if letter == "s" {
                            let node = SKSpriteNode(imageNamed: "star")
                            node.name = "star"
                            node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
                            node.physicsBody!.dynamic = false
                            
                            node.physicsBody!.categoryBitMask = CollisionTypes.Star.rawValue
                            node.physicsBody!.contactTestBitMask = CollisionTypes.Player.rawValue
                            node.physicsBody!.collisionBitMask = 0
                            node.position = position
                            addChild(node)
                        } else if letter == "f" {
                            let node = SKSpriteNode(imageNamed: "finish")
                            node.name = "finish"
                            node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
                            node.physicsBody!.dynamic = false
                            
                            node.physicsBody!.categoryBitMask = CollisionTypes.Finish.rawValue
                            node.physicsBody!.contactTestBitMask = CollisionTypes.Player.rawValue
                            node.physicsBody!.collisionBitMask = 0
                            node.position = position
                            addChild(node)
                        }
                    }
                }
            }
        }
    }
    
    func createPlayer() {
        player = SKSpriteNode(imageNamed: "player")
        player.position = CGPoint(x: 96, y: 672)
        player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.width / 2)
        // setting linear damping to 0.5 to create friction
        player.physicsBody!.linearDamping = 0.5
        // setting allowsRotation property to false b/c the marble reflection doesn't rotate
        player.physicsBody!.allowsRotation = false
        
        //set the bitmasks
        player.physicsBody!.categoryBitMask = CollisionTypes.Player.rawValue
        player.physicsBody!.contactTestBitMask = CollisionTypes.Star.rawValue | CollisionTypes.Vortex.rawValue | CollisionTypes.Finish.rawValue
        player.physicsBody!.collisionBitMask = CollisionTypes.Wall.rawValue
        addChild(player)
    }
}
