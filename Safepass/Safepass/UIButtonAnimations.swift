//
//  UIButtonAnimations.swift
//  Safepass
//
//  Created by Deeptadeep Roy on 30/10/19.
//  Copyright © 2019 Deeptadeep Roy. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    func pulsate () {
        
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.55
        pulse.fromValue = 0.95
        pulse.toValue = 1.00
        pulse.autoreverses = true
        pulse.repeatCount = 1
        pulse.initialVelocity = 0.50
        pulse.damping = 1.00
        
        layer.add(pulse , forKey: nil)
        
    }
    
    
    
}
