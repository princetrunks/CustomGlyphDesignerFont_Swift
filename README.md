CustomGlyphDesignerFont_Swift
=============================

Swift SpriteKit Game Class With Custom GlyphDesigner Bitmap Fonts

HOW TO USE GLYPH DESIGNER FONTS IN SWIFT... (from my full post found at http://blog.chucksanimeshrine.com/2014/10/how-to-add-glyphdesigner-custom-bitmap.html)

At first, I thought about rewriting the entire SSBitMapFont and SSBitMapFontLabel classes in Swift... but unfortunately you only have access to their interface files (.h files) and not their (.m) implementation files; it's all packed into libSSBitmapFont.a since I'd imagine the implementation code (though probably still obtainable) is proprietary code.  

As of the date of this posting, 71squared has yet to make these classes in Swift... so, how do you use the code? Simple: Accessing Objecive-C classes via a Bridging Header.  In short, a bridging header is a .h interface file that lets you use Objective-C and Swift in the same project.  The file is usually named YourProjectName-Bridging-Header.h. 

How do you use it in a mostly Swift project?(Like my game PikiPop seen above) 
Again, very simple... add the import statements to the file exactly like you would add them in an Objective-c project. ie:

#import "SSBitmapFont.h"
#import "SSBitmapFontLabelNode.h"


That's it! That is all my PikiPop-Bridging-Header.h file has and now my entire Swift project can use SSBitmapFont and SSBitmapFontLabelNode objects


Now, you are not out of the woods yet. You still need to create your SSBitmapFont object to then be used by SSBitmapFontLabelNodes.


Here's how you rewrite implementation of these objects in Swift:


To create the SSBitmapFont object (remember to have your .skf file(s) and texture atlases imported into your project at this point) here's how I do it in PikiPop.  First I created a function that returns an SSBitmapFont object.  This is the swift version of how 71Squared did it in their demo file.


class func bitmapFontForFile(filename:String) -> SSBitmapFont{


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


Do note that I made this a class function since I'm using this function during the game's asset loading screen at it's initial dispatch...thus I needed to make this a function of (in this case) my HUD.swift class. I also use global shared variables as storage of this data; this is to only allocate memory once for these font objects instead of calling them over and over again. You don't have to do this but Swift, unlike C/C++/Objective-C easily makes true full copies of objects (not just references) and I don't want to inadvertently cause ARC to do a massive garbage collect nor bog the CPU/Stack by creating another hard copy of something I can just reference to.

 Also note that as of this post I didn't create the assert warnings well. They seemed to have been firing off no matter if the file URL was right or wrong. I'd advise anyone using this to maybe complete that aspect so to better catch errors than what I did here in commenting them out.


Next, create the SSBitmapFont object.  Here's how I did it for the "combo_text" font I made... seen in the picture at the top of this post.



let comboBitMapFont:SSBitmapFont = bitmapFontForFile("combo_text")


Then I finally create the SSBitmapFontLabelNode that uses this font and add it to my HUD object (which is a child of my game's scene)



let comboTextNum = comboBitMapFont_.nodeFromString("x\(comboCount)")


comboTextNum.position = CGPointMake(currentScene.frame.size.width * 0.47, currentScene.frame.size.height * 0.8)


self.addChild(comboTextNum)



and there it is.  That's the "X3" you see in the photo up top.  The "Combo x" uses another font object and so does the "SCORE" text.  Also note that the bitmapFontForFile("combo_text") line will use either the .skf file or the .skf@2x file based on which resolution the player is using on their device.  So, there's no need to create separate SSBitmapFont objects for each resolution. - See more at: http://blog.chucksanimeshrine.com/2014/10/how-to-add-glyphdesigner-custom-bitmap.html#.VFcqP1PF8QS
