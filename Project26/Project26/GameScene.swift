//
//  GameScene.swift
//  Project26
//
//  Created by Jeffrey Eng on 9/8/16.
//  Copyright (c) 2016 Jeffrey Eng. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       
    }
   
    override func update(currentTime: CFTimeInterval) {

    }
    
    func loadLevel() {
        // get the file path for the level from NSBundle
        if let levelPath = NSBundle.mainBundle().pathForResource("level1", ofType: "txt") {
            if let levelString = try? String(contentsOfFile: levelPath, usedEncoding: nil) {
                let lines = levelString.componentsSeparatedByString("\n")
                
                for (row, line) in lines.reverse().enumerate() {
                    for (column, letter) in line.characters.enumerate() {
                        let position = CGPoint(x: (64 * column) + 32, y: (64 * row) + 32)
                        
                        if letter == "x" {
                            // load wall
                        } else if letter == "v" {
                            // load vortex
                        } else if letter == "s" {
                            // load star
                        } else if letter == "f" {
                            // load finish
                        }
                    }
                }
            }
        }
    }
}
