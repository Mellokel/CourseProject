//
//  CheckInternetConnection.swift
//  Sokolov 0.1.1
//
//  Created by test on 4/23/17.
//  Copyright © 2017 test. All rights reserved.
//

import Foundation

import SystemConfiguration

public class CheckInternetConnection {
    
    func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
    
        guard let defaultRouteReachability = withUnsafePointer(&zeroAddress, {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        
        }) else {
            return false
        }
    
        
        var flags : SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags (defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.Reachable)
        let needsConnection = flags.contains(.ConnectionRequired)
        
        return (isReachable && !needsConnection)
    }


}