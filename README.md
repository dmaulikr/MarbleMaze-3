# MarbleMaze
Repo following Project 26: Marble Maze with Core Motion at Hacking with Swift

## Concepts learned/practiced
* Learned:
  * Core Motion
    * ```CMMotionManager()```
    * ```startAccelerometerUpdates()``` - instructs Core Motion to start recording accelerometer information to be read later
  * Special compiler instructions/Compiler directives
    * Have multiple sets of instructions that only compile when one set OR the other evaluates to true.
    * Example:
      ```Swift
      override func update(currentTime: CFTimeInterval) {
    if !gameOver {
#if (arch(i386) || arch(x86_64))
        if let currentTouch = lastTouchPosition {
            let diff = CGPoint(x: currentTouch.x - player.position.x, y: currentTouch.y - player.position.y)
            physicsWorld.gravity = CGVector(dx: diff.x / 100, dy: diff.y / 100)
        }
#else
        if let accelerometerData = motionManager.accelerometerData {
            physicsWorld.gravity = CGVector(dx: accelerometerData.acceleration.y * -50, dy: accelerometerData.acceleration.x * 50)
        }
#endif
    }
}
      ```
  * Collision bitmasks - defining what categorie of object node should collide with
  * Array reversing
    * In this project, the array needed to be read in reverse because the level had to be constructed bottom to top due to how the GameScene is oriented.
    * Example:
      ```Swift
      for (row, line) in lines.reverse().enumerate() {
        // run code here
      }
      ```
      
* Practiced:
  * ```enumerate()``` method on arrays to pull out item and index for use within a for-in loop
  * Enums
    * Example:
    ```Swift
    enum CollisionTypes: UInt32 {
      case Player = 1
      case Wall = 2
      case Star = 4
      case Vortex = 8
      case Finish = 16
    }
    ```
  * Property observers
  * SpriteKit
    * ```SKNode```
    * ```SKAction```

## Attributions
[Project 26: Marble Maze with Core Motion](https://www.hackingwithswift.com/read/26/overview)
