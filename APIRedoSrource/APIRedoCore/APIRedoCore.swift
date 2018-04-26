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
    1.observer the network then progress the apis
    2.
 */

class RedoRuleGodfather: NSObject {
    
    let eachNsecs:Double = 15
    
    private static var shareInstance: RedoRuleGodfather!
    
    private let startTaskID:String = NSUUID().uuidString
    
    private override init() {
        super.init()
    }
    
    public static func getInstance() -> RedoRuleGodfather {
        if shareInstance == nil {
            shareInstance = RedoRuleGodfather()
        }
        return shareInstance
    }
    
    public func startService() {
        DispatchQueue.once(taskid: startTaskID) {
            Timer.scheduledTimer(timeInterval: eachNsecs, target: self, selector: #selector(progressFaildAPIS), userInfo: nil, repeats: true)
            NotificationCenter.default.addObserver(self, selector: #selector(netWorkReach(noti:)), name: NSNotification.Name.APICoreNotification().scanNetWorkReach, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(netWorkNotReach(noti:)), name: NSNotification.Name.APICoreNotification().scanNetWorkNotReach, object: nil)
        }
        
    }
    
    @objc private func progressFaildAPIS() {
        
    }
    
    /// scan net work is success
    @objc private func netWorkReach(noti:Notification) {
        
    }
    
    /// scan net work is fail
    @objc private func netWorkNotReach(noti: Notification) {
        
    }
    
    // add one apimodel [progressAction: just <realtime> & <no net work> shouldn't be nil]
    func addOneRedoAPI(with apiModel:APIModel,progressAction:((_ couldRetry:Bool)->Void)? = nil) {
        let progress = RedoCoreCenterProgress()
        progress.addOneRedoAPI(with: apiModel, progressAction: progressAction)
    }
}
