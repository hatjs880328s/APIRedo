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
 1.Scan network status [notis: NetWorkStatus.reachability & NetWorkStatus.notReachability]
 2.get current net work status [getcurrentNetWorkStatus]
 
 */

enum NetWorkStatus:String {
    case reachability
    case notReachability
}

extension Notification.Name {
    struct APICoreNotification {
        let scanNetWorkNotReach = Notification.Name(rawValue: "scanNetWorkNotReach")
        let scanNetWorkReach = Notification.Name(rawValue: "scanNetWorkReach")
    }
}

/// networkUtility - singleInstance
class NetMoniterCenter: NSObject {
    
    private static var shareInstance: NetMoniterCenter!
    
    private override init() { super.init() }
    
    public static func getInstance()->NetMoniterCenter {
        if shareInstance == nil {
            shareInstance = NetMoniterCenter()
        }
        return shareInstance
    }
    
    /// start network scan ......
    public func startService(with pingHost: String = "http://www.baidu.com",doubleWith checkPingHost: String = "http://www.sina.com.cn/") {
        RealReachability.sharedInstance().startNotifier()
        RealReachability.sharedInstance().hostForPing = pingHost
        RealReachability.sharedInstance().hostForCheck = checkPingHost
        NotificationCenter.default.addObserver(self, selector: #selector(netWorkStatusChanged(noti:)), name: NSNotification.Name.realReachabilityChanged, object: nil)
    }
    
    /// initilize the Class networkstatus is nil.
    public func getCurrentNetWorkStatus()->NetWorkStatus {
        let status = RealReachability.sharedInstance().currentReachabilityStatus()
        if status == .RealStatusNotReachable {
            return NetWorkStatus.notReachability
        }
        return NetWorkStatus.reachability
    }
    
    /// observer the net work
    @objc private func netWorkStatusChanged(noti: Notification) {
        let reachability = (noti.object as! RealReachability)
        let status = reachability.currentReachabilityStatus()
        if status == .RealStatusNotReachable {
            NotificationCenter.default.post(name: NSNotification.Name.APICoreNotification().scanNetWorkNotReach, object: nil, userInfo: nil)
        }else{
            NotificationCenter.default.post(name: NSNotification.Name.APICoreNotification().scanNetWorkReach, object: nil, userInfo: nil)
        }
    }
}


