//
//  UIView + ext.swift
//  JustChat
//
//  Created by Ангел предохранитель on 03.11.2024.
//

import UIKit

extension UIView {
    
    var width: CGFloat {
        return self.frame.width
    }
    
    var height: CGFloat {
        return self.frame.height
    }
    
    var top: CGFloat {
        return self.frame.origin.y
    }
    
    var left: CGFloat {
        return self.frame.origin.x
    }
    
    var right: CGFloat {
        return self.frame.width + self.frame.origin.x
    }
    
    var bottom: CGFloat {
        return self.frame.height + self.frame.origin.y
    }
}
