//
// 
//  APIModel.swift
//  APIRedo
//
//  Created by Noah_Shan on 2018/4/10.
//  Copyright © 2018年 Inspur. All rights reserved.
//
// 
import Foundation


class APIModel: NSObject {
    
    var apiStrInfo: String = ""
    
    var apiType:APInterfaceType = .realTime
    
    /// api connect fail type - default is time out
    var errorType:APIFailType = .netWorkTimeOut
    
    /// api connect fail resson
    var apiConnectFailReason:String = ""
    
    /// Just use it progress == function
    fileprivate let createTime: String = Date().description
    
    private override init() {
        super.init()
    }
    
    public init(apiInfo: String,apiType: APInterfaceType) {
        self.apiType = apiType
        self.apiStrInfo = apiInfo
    }
    
    public func setFailReasonType(_ reason: APIFailType) {
        self.errorType = reason
    }
    
    public func setFailReason(_ reasonStr: String) {
        self.apiConnectFailReason = reasonStr
    }
    
    deinit {
        //release if not
    }
    
    /// == function
    static func ==(lhs: APIModel,shs: APIModel)->Bool {
        return lhs.apiType.rawValue + lhs.createTime + lhs.apiStrInfo ==
            shs.apiType.rawValue + shs.createTime + shs.apiStrInfo
    }
    
}



