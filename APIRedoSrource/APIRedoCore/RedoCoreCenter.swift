//
//  RedoCoreCenter.swift
//  APIRedo
//
//  Created by Noah_Shan on 2018/4/11.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation


/*
 Engineer invoking the apinterface fail
 RedoCenter collect the fail-api  [api-model & fail-reason]
 Use rule-factory create right rule to solve it
 ...
 */


///  !!!!the center couldn't create parameters besides [shareInstance,shareInstance,coreQueue]!!!!
class RedoCoreCenter: NSObject {
    
    private static var shareInstance: RedoCoreCenter!
    
    /// apimodel array [ each func who progress the arr should be put in coreQueue ]
    var apiCollection: [APIModel] = []
    
    let coreQueue = IISlinkManager(linkname: "RedoCore")
    
    private override init() {
        super.init()
    }
    
    public static func getInstance() ->RedoCoreCenter {
        if shareInstance == nil {
           shareInstance = RedoCoreCenter()
        }
        return shareInstance
    }
}

class RedoCoreCenterProgress: NSObject {
    
    override init() { super.init() }
    
    // add one apimodel [progressAction: just <realtime> & <no net work> shouldn't be nil]
    func addOneRedoAPI(with apiModel:APIModel,progressAction:((_ couldRetry:Bool)->Void)? = nil) {
        let queueTask = IITaskModel(taskinfo: { () -> Bool in
            RedoCoreCenter.getInstance().apiCollection.append(apiModel)
            return true
        }, taskname: "redoCoreAddOneApiModel")
        RedoCoreCenter.getInstance().coreQueue.addTask(task: queueTask)
    }
    
    /// when api fail - invoke current api-rule progress it
    public func onceProgressTheFailAPI(with apiModel: APIModel) {
        let progressIns = RedoCoreProgressCenter().getRealProgressInstance(apiModel: apiModel)
        progressIns?.progress()
    }
    
    /// deleate one apimodel
    func deleateOneapiModel(with apiModel: APIModel) {
        let queueTask = IITaskModel(taskinfo: { () -> Bool in
            for i in 0 ... RedoCoreCenter.getInstance().apiCollection.count - 1 {
                if RedoCoreCenter.getInstance().apiCollection[i] == apiModel {
                    RedoCoreCenter.getInstance().apiCollection.remove(at: i)
                }
            }
            return true
        }, taskname: "redoCoreDeleateOneAPIModel")
        RedoCoreCenter.getInstance().coreQueue.addTask(task: queueTask)
    }
    
    /// when add one fail api to self.apiCollection - save fail reason to disk [api log]
    private func logForSaveFailReason() {
        
    }
    
}
