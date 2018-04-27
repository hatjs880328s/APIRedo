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
    
    /// start service
    public func startService() {
        DispatchQueue.once(taskid: startTaskID) {
            Timer.scheduledTimer(timeInterval: eachNsecs, target: self, selector: #selector(loopProgressFaildAPIS), userInfo: nil, repeats: true)
            NotificationCenter.default.addObserver(self, selector: #selector(netWorkReach(noti:)), name: NSNotification.Name.APICoreNotification().scanNetWorkReach, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(netWorkNotReach(noti:)), name: NSNotification.Name.APICoreNotification().scanNetWorkNotReach, object: nil)
        }
    }
    
    /// add ur fail api to redoCenter
    /// [if apimodel.apitype == realtime : retry at once ; others add to api array]
    /// - Parameter apiModel: ApiModelIns
    public func addOneRedoAPI(with apiModel:APIModel) {
        let progress = RedoCoreCenterProgress()
        if apiModel.apiType == .realTime {
            progress.onceProgressTheFailAPI(with: apiModel)
        }else{
            progress.addOneRedoAPI(with: apiModel)
        }
    }
}


// MARK: -  actions
extension RedoRuleGodfather {
    @objc private func loopProgressFaildAPIS() {
        let task = IITaskModel(taskinfo: { () -> Bool in
            for eachItem in RedoCoreCenter.getInstance().apiCollection {
                let progressIns = RedoCoreCenterProgress()
                progressIns.onceProgressTheFailAPI(with: eachItem)
            }
            return true
        }, taskname: "loopProgresssFaildAPISTask")
        RedoCoreCenter.getInstance().coreQueue.addTask(task: task)
    }
    
    /// scan net work is success
    @objc private func netWorkReach(noti:Notification) {
        let task = IITaskModel(taskinfo: { () -> Bool in
            for eachItem in RedoCoreCenter.getInstance().apiCollection {
                let progressIns = RedoCoreCenterProgress()
                progressIns.onceProgressTheFailAPI(with: eachItem)
            }
            return true
        }, taskname: "loopProgresssFaildAPISTaskObnetwork")
        RedoCoreCenter.getInstance().coreQueue.addTask(task: task)
    }
    
    /// scan net work is fail
    @objc private func netWorkNotReach(noti: Notification) {
        
    }
}
