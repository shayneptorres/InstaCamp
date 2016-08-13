//
//  Update.swift
//  InstaCamp
//
//  Created by Shayne Torres on 6/6/16.
//  Copyright © 2016 Shayne Torres. All rights reserved.
//

import Foundation

class Update {
    var updateID = String()
    var points = Int()
    var team = String()
    var time = String()
    var type = String()
    var user = String()
    
    init(){
        updateID = "none"
        points = 0
        team = "none"
        time = "none"
        type = "none"
        user = "none"
    }
    
    init(id: String, p: Int, te: String, ti: String, ty: String, u: String){
        points = p
        team = te
        time = ti
        type = ty
        user = u
    }
    
    init (id: String, d:[String:String]){
        updateID = id
        print(updateID)
        points = Int(d["points"]!)!
        print(points)
        team = d["team"]!
        print(team)
        time = d["timestamp"]!
        print(time)
        type = d["type"]!
        user = d["user"]!
    }
    
}