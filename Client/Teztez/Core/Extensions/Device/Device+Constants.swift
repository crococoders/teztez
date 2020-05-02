//
//  Device+Constants.swift
//  Teztez
//
//  Created by Almas Zainoldin on 4/18/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import UIKit

// swiftlint:disable all
enum Device: Equatable, CustomStringConvertible {
    indirect case simulator(Device)
    case unknown(String)

    case iPhone5
    case iPhone5c
    case iPhone5s
    case iPhone6
    case iPhone6Plus
    case iPhone6s
    case iPhone6sPlus
    case iPhone7
    case iPhone7Plus
    case iPhoneSE
    case iPhone8
    case iPhone8Plus
    case iPhoneX
    case iPhoneXS
    case iPhoneXSMax
    case iPhoneXR
    case iPhone11
    case iPhone11Pro
    case iPhone11ProMax

    var description: String {
        switch self {
        case .iPhone5: return "iPhone 5"
        case .iPhone5c: return "iPhone 5c"
        case .iPhone5s: return "iPhone 5s"
        case .iPhone6: return "iPhone 6"
        case .iPhone6Plus: return "iPhone 6 Plus"
        case .iPhone6s: return "iPhone 6s"
        case .iPhone6sPlus: return "iPhone 6s Plus"
        case .iPhone7: return "iPhone 7"
        case .iPhone7Plus: return "iPhone 7 Plus"
        case .iPhoneSE: return "iPhone SE"
        case .iPhone8: return "iPhone 8"
        case .iPhone8Plus: return "iPhone 8 Plus"
        case .iPhoneX: return "iPhone X"
        case .iPhoneXS: return "iPhone Xs"
        case .iPhoneXSMax: return "iPhone Xs Max"
        case .iPhoneXR: return "iPhone Xʀ"
        case .iPhone11: return "iPhone 11"
        case .iPhone11Pro: return "iPhone 11 Pro"
        case .iPhone11ProMax: return "iPhone 11 Pro Max"
        case let .simulator(model): return "Simulator (\(model))"
        case let .unknown(identifier): return identifier
        }
    }

    static func == (lhs: Device, rhs: Device) -> Bool {
        return lhs.description == rhs.description
    }

    private static func mapToDevice(identifier: String) -> Device {
        switch identifier {
        case "iPhone5,1", "iPhone5,2": return iPhone5
        case "iPhone5,3", "iPhone5,4": return iPhone5c
        case "iPhone6,1", "iPhone6,2": return iPhone5s
        case "iPhone7,2": return iPhone6
        case "iPhone7,1": return iPhone6Plus
        case "iPhone8,1": return iPhone6s
        case "iPhone8,2": return iPhone6sPlus
        case "iPhone9,1", "iPhone9,3": return iPhone7
        case "iPhone9,2", "iPhone9,4": return iPhone7Plus
        case "iPhone8,4": return iPhoneSE
        case "iPhone10,1", "iPhone10,4": return iPhone8
        case "iPhone10,2", "iPhone10,5": return iPhone8Plus
        case "iPhone10,3", "iPhone10,6": return iPhoneX
        case "iPhone11,2": return iPhoneXS
        case "iPhone11,4", "iPhone11,6": return iPhoneXSMax
        case "iPhone11,8": return iPhoneXR
        case "iPhone12,1": return iPhone11
        case "iPhone12,3": return iPhone11Pro
        case "iPhone12,5": return iPhone11ProMax
        case "i386", "x86_64": return simulator(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))
        default: return unknown(identifier)
        }
    }
}

extension Device {
    static var current: Device {
        return Device.mapToDevice(identifier: Device.identifier)
    }

    var isSmall: Bool {
        switch self {
        case let .simulator(device):
            return device.isOneOf(allSmallPhones)
        case .unknown:
            return false
        default:
            return isOneOf(allSmallPhones)
        }
    }

    var isSESecondGeneration: Bool {
        switch self {
        case let .simulator(device):
            return device.isOneOf(allSESecondGenerationSizePhones)
        case .unknown:
            return false
        default:
            return isOneOf(allSESecondGenerationSizePhones)
        }
    }

    private static var identifier: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let mirror = Mirror(reflecting: systemInfo.machine)

        let identifier = mirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }()

    private func isOneOf(_ devices: [Device]) -> Bool {
        return devices.contains(self)
    }

    private var allSmallPhones: [Device] {
        return [.iPhone5, .iPhone5c, .iPhone5s, .iPhoneSE]
    }

    private var allSESecondGenerationSizePhones: [Device] {
        return [.iPhone6, .iPhone6s, .iPhone7, .iPhone8]
    }

    private var allDevicesWithSensorHousing: [Device] {
        return [.iPhoneX, .iPhoneXS, .iPhoneXSMax, .iPhoneXR, .iPhone11, .iPhone11Pro, .iPhone11ProMax]
    }
}
