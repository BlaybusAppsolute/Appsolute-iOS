//
//  UIColor+Extension.swift
//  Appsolute
//
//  Created by 권민재 on 1/7/25.
//

import UIKit


extension UIColor {
    /// Hex 코드를 사용하여 UIColor 생성
    ///
    /// - Parameters:
    ///   - hex: 16진수 색상 코드 (예: `0xFF5733` 또는 `"FF5733"`)
    ///   - alpha: 투명도 (기본값: 1.0)
    convenience init(hex: Any, alpha: CGFloat = 1.0) {
        var hexValue: UInt64 = 0
        
        // 문자열로 들어온 hex 처리
        if let hexString = hex as? String {
            let scanner = Scanner(string: hexString)
            if hexString.hasPrefix("#") {
                scanner.currentIndex = hexString.index(after: hexString.startIndex)
            }
            scanner.scanHexInt64(&hexValue)
        } else if let hexInt = hex as? UInt64 {
            hexValue = hexInt
        } else {
            fatalError("Invalid hex input. Use a String (e.g., \"#FF5733\") or UInt64 (e.g., 0xFF5733).")
        }

        let red = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hexValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(hexValue & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

extension UIColor {
    static var backgroundColor = UIColor(red: 0.91, green: 0.95, blue: 1.00, alpha: 1.00)
    static var gridColor = UIColor(red: 0.71, green: 0.83, blue: 0.99, alpha: 1.00)
    static var gray400 = UIColor(red: 189/255.0, green: 189/255.0, blue: 189/255.0, alpha: 1.0)
    static var textColor = UIColor(red: 0.03, green: 0.19, blue: 0.40, alpha: 1.00)
    static var selectedWeekColor = UIColor(red: 0.03, green: 0.19, blue: 0.40, alpha: 1.00)
    static var headerColor = UIColor(red: 0.06, green: 0.45, blue: 0.96, alpha: 1.00)
}
//gray
extension UIColor {
    static let gray50 = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0) // #FAFAFA
    static let gray300 = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0) // #E0E0E0
}
