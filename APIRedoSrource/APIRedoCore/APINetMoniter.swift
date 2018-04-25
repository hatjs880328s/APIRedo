//
// 
//  APINetMoniter.swift
//  APIRedo
//
//  Created by Noah_Shan on 2018/4/10.
//  Copyright © 2018年 Inspur. All rights reserved.
//
// 
import Foundation


/*
 
 Net moniter center 
 TODO:
 1.Scan network status -- reachability or not then notify
 2.
 */

enum NetWorkStatus:String {
    case reachability
    case notReachability
}

/// interface about networkUtility
protocol IScanNetWorkStatus {
    
    func observerNetWorkChangedReachability()
    
    func observerNetWorkChangedNotReachability()
    
    func notifyNetWorkStatus(status: NetWorkStatus)
    
    
}

/// networkUtility - singleInstance
class NetMoniterCenter: IScanNetWorkStatus {
    
    private var netWorkStatus: NetWorkStatus!
    
    private static var shareInstance: NetMoniterCenter!
    
    private init() {}
    
    public static func getInstance()->NetMoniterCenter {
        if shareInstance == nil {
            shareInstance = NetMoniterCenter()
        }
        return shareInstance
    }
    
    /// initilize the Class networkstatus is nil.
    public func getCurrentNetWorkStatus()->NetWorkStatus? {
        return self.netWorkStatus
    }
    
    func notifyNetWorkStatus(status: NetWorkStatus) {
        
    }
    
    func observerNetWorkChangedReachability() {
        
    }
    
    func observerNetWorkChangedNotReachability() {
        
    }
    
    
}


