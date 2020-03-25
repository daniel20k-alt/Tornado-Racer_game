//
//  GameScene.swift
//  Tornado Racer
//
//  Created by DDDD on 25/03/2020.
//  Copyright © 2020 MeerkatWorks. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var dustParticles: SKEmitterNode!
    var player: SKSpriteNode!
    var scoreLabel: SKLabelNode!
    
    var score =  0 {
    didSet {
    scoreLabel.text = "Score: \(score)"
    }
    }

    override func didMove(to view: SKView) {
        
        backgroundColor = .black
        dustParticles = SKEmitterNode(fileNamed: "dustParticles")!
        dustParticles.position = CGPoint(x: 1024, y: 284)
        
        dustParticles.advanceSimulationTime(10)  //makes the SMEmitter run for 10 seconds prior to opening
        addChild(dustParticles)
        dustParticles.zPosition = -1
        
        
        player = SKSpriteNode(imageNamed: "player")
        player.position = CGPoint(x: 100, y: 384)
        player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
        player.physicsBody?.contactTestBitMask = 1
        addChild(player)
        
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.position = CGPoint(x:16, y:16)
        scoreLabel.horizontalAlignmentMode = .left
        addChild(scoreLabel)
        
        score = 0

    }

    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
    }
}
