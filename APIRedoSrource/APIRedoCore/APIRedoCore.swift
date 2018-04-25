//
// 
//  APIRedoCore.swift
//  APIRedo
//
//  Created by Noah_Shan on 2018/4/10.
//  Copyright © 2018年 Inspur. All rights reserved.
//
// 
import Foundation

/*
    Core as we all know...
 */

class RedoRuleGodfather: NSObject {
    
    var api: APIModel!
    
    var apiFailType: APIFailType!
    
    init(apiFailType: APIFailType,api: APIModel) {
        self.apiFailType = apiFailType
        self.api = api
    }
    
    func analyzeAndProgressAPI(api: APIModel) {}
}

//class 
