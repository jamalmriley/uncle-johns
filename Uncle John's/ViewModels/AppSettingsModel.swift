//
//  AppSettingsModel.swift
//  Uncle John's
//
//  Created by Jamal Riley on 7/13/22.
//

import Foundation
import UIKit

public final class AppSettingsModel: ObservableObject {
    @Published public var iconIndex: Int = 0
    @Published var emojiIndex = 0
    
    public private(set) var icons: [Icon] = []
    public var currentIconName: String? {
        UIApplication.shared.alternateIconName
    }
    
    public init() {
        fetchIcons()
    }
    
    public func fetchIcons() {
        if let bundleIcons = Bundle.main.object(forInfoDictionaryKey: "CFBundleIcons") as? [String: Any] {
            // Default Icon
            if let primaryIcon = bundleIcons["CFBundlePrimaryIcon"] as? [String: Any],
               let iconFileName = (primaryIcon["CFBundleIconFiles"] as? [String])?.first {
                let displayName = (primaryIcon["CFBundleIconName"] as? String) ?? ""
                icons.append(Icon(displayName: displayName, iconName: nil, image: UIImage(named: iconFileName)))
            }
            
            // Alternate Icons
            if let alternateIcons = bundleIcons["CFBundleAlternateIcons"] as? [String: Any] {
                alternateIcons.forEach { iconName, iconInfo in
                    if let iconInfo = iconInfo as? [String: Any],
                       let iconFileName = (iconInfo["CFBundleIconFiles"] as? [String])?.first {
                        icons.append(Icon(displayName: iconName, iconName: iconName, image: UIImage(named: iconFileName)))
                    }
                }
            }
        }
        iconIndex = icons.firstIndex(where: { icon in
            return icon.iconName == currentIconName
        }) ?? 0
    }
}
