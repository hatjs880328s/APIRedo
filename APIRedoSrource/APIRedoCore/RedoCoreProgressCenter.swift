//
//  RedoCoreProgressCenter.swift
//  APIRedo
//
//  Created by Noah_Shan on 2018/4/11.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation


class RedoCoreProgressCenter: NSObject {
    
    override init() {
        super.init()
    }
    
    func getRealProgressInstance(apiModel:APIModel)->RedoRule? {
        switch (apiModel.apiType,apiModel.errorType) {
            
        case (APInterfaceType.realTime,APIFailType.netWorkTimeOut):
            return RedoRuleRealTimeAndTimeOut(apiModel: apiModel)
            
        case (APInterfaceType.realTime,APIFailType.noConnection):
            return RedoRuleRealTimeAndNoNetWork(apiModel: apiModel)
            
        case (APInterfaceType.realTime,APIFailType.others(reason: APIFailType2Lvl.defaultReason)):
            return RedoRuleRealTimeAndOthers(apiModel: apiModel)
            
        case (APInterfaceType.must,APIFailType.netWorkTimeOut):
            return RedoRuleNRTAndMustResponseAndTimeout(apiModel: apiModel)
            
        case (APInterfaceType.must,APIFailType.noConnection):
            return RedoRuleNRTAndMustResponseAndNonetwork(apiModel: apiModel)
            
        case (APInterfaceType.must,APIFailType.others(reason: APIFailType2Lvl.defaultReason)):
            return RedoRuleNRTAndMustResponseAndOthers(apiModel: apiModel)
            
        default:
            print(" are u kidding me?")
            return nil
        }
    }
    
    deinit {
        // dealloc
    }
    
}

/// Rule father class
class RedoRule: NSObject {
    
    var apiModel:APIModel!
    
    var progressAction:((_ couldRetry:Bool)->Void)!
    
    init(apiModel: APIModel) {
        super.init()
        self.apiModel = apiModel
    }
    
    func progress() {}
    
    /// do nothing
    func doNothing() { return }
    
    /// observer the network now & retry once now [just san the network]
    func obserNetAndRetryOnce()->Bool {
        let status = NetMoniterCenter.getInstance().getCurrentNetWorkStatus()
        if status == .notReachability {
            return false
        }
        return true
    }
    
    /// wait for network & retry
    func waitNetworkAndRetry() {
        
    }
    
    /// each N secs retry
    func eachNSecsRetry() {
        
    }
}

/// real time & time out [do nothing]
class RedoRuleRealTimeAndTimeOut:RedoRule {
    override func progress() {
        super.doNothing()
    }
}

/// real time & no net work[retry once now - observer the network]
class RedoRuleRealTimeAndNoNetWork: RedoRule {
    override func progress() {
        if self.progressAction == nil { return }
        self.progressAction(super.obserNetAndRetryOnce())
    }
}

/// real time & others[do nothing]
class RedoRuleRealTimeAndOthers: RedoRule {
    override func progress() {
        super.doNothing()
    }
}

/// no-real time & importAPI & timeout[each N secs retry]
class RedoRuleNRTAndMustResponseAndTimeout: RedoRule {
    override func progress() {
        super.eachNSecsRetry()
    }
}

/// no-real time & importAPI & no net work[net work connect then retry]
class RedoRuleNRTAndMustResponseAndNonetwork: RedoRule {
    override func progress() {
        super.waitNetworkAndRetry()
    }
}

/// no-real time & importAPI & others[each N secs retry]
class RedoRuleNRTAndMustResponseAndOthers: RedoRule {
    override func progress() {
         super.eachNSecsRetry()
    }
}
