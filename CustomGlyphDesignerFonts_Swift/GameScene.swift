//
//  GameScene.swift
//  CustomGlyphDesignerFonts_Swift
//
//  Created by chuck on 11/3/14.
//  Copyright (c) 2014 Chuck Gaffney. All rights reserved.
//

import SpriteKit


class GameScene: SKScene {
    
    //custom fonts
    var customBitMapFont_  : SSBitmapFont!
    var customText_ = SSBitmapFontLabelNode()
    
    // used to read to the .skf files
    func bitmapFontForFile(filename:String) -> SSBitmapFont{
        // Generate a path to the font file
        let path = NSBundle.mainBundle().pathForResource(filename, ofType: "skf")!
        //assert(path.isEmpty, "Could not find font file")
        // Create a new instance of SSBitmapFont using the font file and check for errors
        let errorPointer = NSErrorPointer()
        let url = NSURL.fileURLWithPath(path)
        let bitmapFont = SSBitmapFont(file: url, error: errorPointer)
        //assert(errorPointer != nil, "\(errorPointer.memory) : \(errorPointer.debugDescription)")
        return bitmapFont
    }

    
    override func didMoveToView(view: SKView) {
        
        //create the custom font objects and text
        customBitMapFont_ =  bitmapFontForFile("combo_text")
        customText_        = customBitMapFont_.nodeFromString("Custom Text")
        
        customText_.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        
        self.addChild(customText_)

    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
            let sprite = SKSpriteNode(imageNamed:"Spaceship")
            
            sprite.xScale = 0.5
            sprite.yScale = 0.5
            sprite.position = location
            
            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            
            sprite.runAction(SKAction.repeatActionForever(action))
            
            self.addChild(sprite)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
