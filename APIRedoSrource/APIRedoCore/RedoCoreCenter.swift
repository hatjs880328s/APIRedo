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
    private var apiCollection: [APIModel] = []
    
    private let coreQueue = IISlinkManager(linkname: "RedoCore")
    
    private override init() {
        super.init()
    }
    
    public static func getInstance() ->RedoCoreCenter {
        if shareInstance == nil {
           shareInstance = RedoCoreCenter()
        }
        return shareInstance
    }
    
    // add one apimodel [progressAction: just <realtime> & <no net work> shouldn't be nil]
    func addOneRedoAPI(with apiModel:APIModel,progressAction:((_ couldRetry:Bool)->Void)? = nil) {
        let queueTask = IITaskModel(taskinfo: { () -> Bool in
            self.apiCollection.append(apiModel)
            return true
        }, taskname: "redoCoreAddOneApiModel")
        self.coreQueue.addTask(task: queueTask)
        
        self.onceProgressTheFailAPI(with: apiModel,progressAction: progressAction)
    }
    
    /// deleate one apimodel
    private func deleateOneapiModel(with apiModel: APIModel) {
        let queueTask = IITaskModel(taskinfo: { () -> Bool in
            for i in 0 ... self.apiCollection.count - 1 {
                if self.apiCollection[i] == apiModel {
                    self.apiCollection.remove(at: i)
                }
            }
            return true
        }, taskname: "redoCoreDeleateOneAPIModel")
        self.coreQueue.addTask(task: queueTask)
    }
    
    /// when add one fail api to self.apiCollection - save fail reason to disk [api log]
    private func logForSaveFailReason() {
        
    }
    
    /// when api fail - first save to arr & invoke current api-rule progress it
    private func onceProgressTheFailAPI(with apiModel: APIModel,progressAction:((_ couldRetry:Bool)->Void)? = nil) {
        let progressIns = RedoCoreProgressCenter().getRealProgressInstance(apiModel: apiModel)
        progressIns?.progressAction = progressAction
        progressIns?.progress()
    }
}