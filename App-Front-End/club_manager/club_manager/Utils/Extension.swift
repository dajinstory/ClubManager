//
//  Extension.swift
//  club_manager
//
//  Created by JoSoJeong on 2021/03/24.
//


import Foundation
import UIKit

extension UIView {
    public var width: CGFloat {
        return self.frame.size.width
    }
    public var height: CGFloat {
        return self.frame.size.height
    }
    public var top: CGFloat {
        return self.frame.size.width
    }
    public var bottom: CGFloat {
        return self.frame.size.height + self.frame.origin.y
    }
    public var left: CGFloat {
        return self.frame.origin.x
    }
    public var right: CGFloat {
        return self.frame.size.width + self.frame.origin.x
    }
    
}

extension Date {
        public var year: Int {
            return Calendar.current.component(.year, from: self)
        }
        
        public var month: Int {
             return Calendar.current.component(.month, from: self)
        }
        
        public var day: Int {
             return Calendar.current.component(.day, from: self)
        }
        
        public var monthName: String {
            let nameFormatter = DateFormatter()
            nameFormatter.dateFormat = "MMMM" // format January, February, March, ...
            return nameFormatter.string(from: self)
        }
}
