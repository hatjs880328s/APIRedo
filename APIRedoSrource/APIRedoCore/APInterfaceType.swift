//
//  APInterfaceType.swift
//  APIRedo
//
//  Created by Noah_Shan on 2018/4/11.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation


/// API TYPE
///
/// - realTime: real time (user invoking)
/// - MUST: must have response
/// - SHOULD: should retry
/// - SHOUDNT: shouldn't retry
enum APInterfaceType: String {
    case realTime
    case must
    case should
    case shouldnt
}
