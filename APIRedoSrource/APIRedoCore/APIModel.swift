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
    
    var requestParams:[AnyHashable:Any] = [:]
    
    /// successAction:- just progress i/o & some without ui
    var successAction:((_ response: Any)->Void)!
    
    var errorAction:((_ error: Any)->Void)!
    
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
    
    public func setParameters(_ params:[AnyHashable:Any]) {
        self.requestParams = params
    }
    
    public func setSuccessAction(action:@escaping (_ response: Any)->Void) {
        self.successAction = action
    }
    
    public func setFailAction(action:@escaping (_ error: Any)->Void) {
        self.errorAction = action
    }
    
    deinit {
        //release if not
    }
    
    static func ==(lhs: APIModel,shs: APIModel)->Bool {
        return lhs.apiType.rawValue + lhs.createTime + lhs.apiStrInfo ==
            shs.apiType.rawValue + shs.createTime + shs.apiStrInfo
    }
    
}



