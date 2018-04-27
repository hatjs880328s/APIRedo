//
//  APIFailType.swift
//  APIRedo
//
//  Created by Noah_Shan on 2018/4/11.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation


/// APIFailType
///
/// - netWorkTimeOut: net work - time out
/// - noConnection: have no connection(not reachability)
/// - others: 404|ServerBoom|version-no-matching
enum APIFailType {
    // use
    case netWorkTimeOut
    // use
    case noConnection
    // use
    case others(reason: APIFailType2Lvl)
}


/// APIFailType2Lvl
///
/// - defaultReason: if shouldn't confirm accurately ,then use default
/// - serverBoom: server boom
/// - versionNoMatching: api version no matching the remote servers
enum APIFailType2Lvl: String {
    // use
    case defaultReason
    // no use
    case serverBoom
    // no use
    case versionNoMatching
}
