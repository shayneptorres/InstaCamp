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
    var leader: String
    
    init(){
        name = ""
        points = 0
        leader = "bob"
    }
    
    init(n: String){
        name = n
        points = 0
        leader = "robert"
    }
    
    init(n: String, p: NSNumber){
        name = n
        points = p
        leader = "stan"
    }
    
    init(n:String, d: [String:String]){
        name = n
        points = Int(d["points"]!)!
        leader = d["leader"]!
    }
    
}