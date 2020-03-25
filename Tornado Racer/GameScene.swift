//
//  GameScene.swift
//  Tornado Racer
//
//  Created by DDDD on 25/03/2020.
//  Copyright © 2020 MeerkatWorks. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var dustParticles: SKEmitterNode!
    var player: SKSpriteNode!
    var scoreLabel: SKLabelNode!
    
    var possibleEnemies = ["house", "ball", "tree"]
    var gameTimer: Timer?
    var isGameOver = false

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
        
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
        //creates enemies every 0.4 seconds
        gameTimer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
        
    }

    @objc func createEnemy() {
        guard let enemy = possibleEnemies.randomElement() else { return }
        
        let sprite = SKSpriteNode(imageNamed: enemy)
        sprite.position = CGPoint(x: 1200, y: Int.random(in: 50...736))
        addChild(sprite)
        
        sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
        sprite.physicsBody?.categoryBitMask = 1
        sprite.physicsBody?.velocity = CGVector(dx: -500, dy: 0)
        sprite.physicsBody?.angularVelocity = 5
        sprite.physicsBody?.linearDamping = 0
        sprite.physicsBody?.angularDamping = 0
    }

    override func update(_ currentTime: TimeInterval) {

        for node in children {
            if node.position.x < -300 {
                node.removeFromParent()
            }
        }
        
        if !isGameOver {
            score += 1
        }
  
    }
}
