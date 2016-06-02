//
//  Team.swift
//  InstaCamp
//
//  Created by Shayne Torres on 5/29/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import Foundation

class Team{
    var name: String
    var points: NSNumber
    var flagImg: String
    var rank: Int
    var leader: String
    
    init(){
        name = ""
        points = 0
        flagImg = "camplogo_black"
        rank = 0
        leader = ""
    }
    
    init(n: String){
        name = n
        points = 0
        flagImg = "camplogo_black"
        rank = 0
        leader = ""
    }
    
    init(n: String, p: NSNumber){
        name = n
        points = p
        flagImg = "camplogo_black"
        rank = 0
        leader = ""
    }
    
    init(n:String, d: [String:String]){
        name = n
        points = Int(d["points"]!)!
        flagImg = d["flagImg"]!
        leader = d["leader"]!
        rank = 0
    }
    
}