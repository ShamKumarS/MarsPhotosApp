//
//  Reachability.swift
//  MarsPhotosApp
//
//  Created by BrainX IOS Dev on 7/25/23.
//

import SystemConfiguration

public class Reachability {
    
    class func isConnectedToNetwork() -> Bool {
        /// Create an empty sockaddr_in structure named zeroAddress.
        var zeroAddress = sockaddr_in()
        
        /// Specify the size of the sockaddr_in
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        
        /// Specify the address family as AF_INET (IPv4)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        /// Check if the SCNetworkReachabilityCreateWithAddress call was successful
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        /// Retrieve flags
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        
        guard let defaultRouteReachability,
            SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) == true
        else {
            return false
        }
        
        /// Check network reachability
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        
        /// Check connection requirement
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        
        /// Check the device is connected to the network and can access the internet
        return (isReachable && !needsConnection)
    }
}
