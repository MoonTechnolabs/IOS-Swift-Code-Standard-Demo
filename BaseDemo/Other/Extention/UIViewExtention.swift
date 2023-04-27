//
//  UIViewExtention.swift
//  BaseDemo
//
//  Created by Moontechnolabs on 27/04/23.
//

import UIKit

//MARK: - UIView Extension
enum cornerRadius{
    case topLeft
    case topRight
    case bottomLeft
    case bottomRight
    case topRightLeft
    case bottomRightLeft
    case bottomRightTopRight
    case topLeftBottomLeft
    case bottomRightTopLeft
}

extension UIView {
    
    //MARK: - IBInspectable
    //Set Corner Radious
    @IBInspectable var cornerRadius:CGFloat {
        set {
            self.layer.cornerRadius = newValue
        }
        get {
            return self.layer.cornerRadius
        }
    }
    //Set Top Corner Radious
    @IBInspectable var onlyTopCornerRadius:CGFloat {
        set {
            self.roundCorners(corners: [.topLeft, .topRight], radius: newValue)
        }get {
            return self.layer.cornerRadius
        }
    }
    
    //Set Top Corner Radious
    @IBInspectable var onlyLeftCornerRadius:CGFloat {
        set {
            self.roundCorners(corners: [.topLeft, .bottomLeft], radius: newValue)
        }get {
            return self.layer.cornerRadius
        }
    }
    
    @IBInspectable var onlyRightCornerRadius:CGFloat {
        set {
            self.roundCorners(corners: [.bottomRight, .topRight], radius: newValue)
        }get {
            return self.layer.cornerRadius
        }
    }
    
    //MARK: Cell Corner Radius
    /*
     layerMinXMinYCorner - Top Left
     layerMinXMaxYCorner - Bottom Left
     layerMaxXMaxYCorner - Bottom Right
     layerMaxXMinYCorner Top Right
     */
    func roundCornerwithCell (_ corners: cornerRadius, radius: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        switch corners {
        case .topLeft:
            self.layer.maskedCorners = [.layerMinXMinYCorner]
        case .topRight:
            self.layer.maskedCorners = [.layerMaxXMinYCorner]
        case .bottomLeft:
            self.layer.maskedCorners = [.layerMinXMaxYCorner]
        case .bottomRight:
            self.layer.maskedCorners = [.layerMaxXMaxYCorner]
        case .topRightLeft:
            self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        case .bottomRightLeft:
            self.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        case .topLeftBottomLeft:
            self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        case .bottomRightTopRight:
            self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        case .bottomRightTopLeft:
            self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMinYCorner]
            
        }
    }
    
    private func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    func roundCorner(_ radius : CGFloat = 2) {
        self.layer.cornerRadius = self.frame.size.height/radius
        self.layer.masksToBounds = false
        self.clipsToBounds = true
    }
    func lightGrayShadow(opacity:Float = 0.15) {
        let shadowSize : CGFloat = 5.0
        let shadowPath = UIBezierPath(roundedRect: CGRect(x: -shadowSize / 2,
                                                          y: -shadowSize / 2,
                                                          width: self.frame.size.width + shadowSize,
                                                          height: self.frame.size.height + shadowSize),cornerRadius: self.cornerRadius)
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = opacity
        self.layer.shadowPath = shadowPath.cgPath
    }
    func shadowDecorate(_ radius: CGFloat = 10) {
        self.layer.cornerRadius = radius
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.masksToBounds = true
        
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
        layer.cornerRadius = radius
    }
    
    //Set Round
    @IBInspectable var Round:Bool {
        set {
            self.layer.cornerRadius = self.frame.size.height / 2.0
        }
        get {
            return self.layer.cornerRadius == self.frame.size.height / 2.0
        }
    }
    //Set Border Color
    @IBInspectable var borderColor:UIColor {
        set {
            self.layer.borderColor = newValue.cgColor
        }
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
    }
    
    //Set Border Width
    @IBInspectable var borderWidth:CGFloat {
        set {
            self.layer.borderWidth = newValue
        }
        get {
            return self.layer.borderWidth
        }
    }
    
    //Set Shadow to view
    @IBInspectable var ShdwColor:UIColor {
        set {
            self.layer.shadowColor = newValue.cgColor
        }
        get {
            return UIColor(cgColor: self.layer.shadowColor!)
        }
    }
    @IBInspectable var ShdwOffset:CGSize  {
        set {
            self.layer.shadowOffset = newValue
        }
        get {
            return self.layer.shadowOffset
        }
    }
    @IBInspectable var ShdwOpacity:CGFloat {
        set {
            self.layer.shadowOpacity = Float(newValue)
        }
        get {
            return CGFloat(self.layer.shadowOpacity)
        }
    }
    
    @IBInspectable var ShdwRadius:CGFloat {
        set {
            self.layer.shadowRadius = newValue
        }
        get {
            return self.layer.shadowRadius
        }
    }
    func roundCorners(corners:CACornerMask, radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = corners
    }
    func setGradiant() {
        if !(self.layer.sublayers?.isEmpty ?? true) {
            for layer in self.layer.sublayers! {
                //if layer.isKind(of: CAShapeLayer.self) {
                if layer.name == "gradiant" {
                    layer.removeFromSuperlayer()
                }
                
                //  }
            }
        }
        
        let layer = CAGradientLayer()
        layer.frame = CGRect(origin: CGPoint.zero, size: self.frame.size)
        layer.colors = [UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor,UIColor(red: 0, green: 0, blue: 0, alpha: 0.81).cgColor]
        layer.locations = [0.0, 1.0]
        layer.startPoint = CGPoint(x: 0.0, y: 0.0)
        layer.endPoint = CGPoint(x: 1.0, y: 0.0)
        layer.transform = CATransform3DMakeRotation(90.0 / 180.0 * .pi, 0.0, 0.0, 1.0)
        self.layer.masksToBounds = true
        self.layer.name = "gradiant"
        self.layer.insertSublayer(layer, at: 0)
    }
    
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.8
        layer.shadowOffset = .zero
        layer.shadowRadius = 1
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    func blurBackground(style: UIBlurEffect.Style, fallbackColor: UIColor) {
        if !UIAccessibility.isReduceTransparencyEnabled {
            self.backgroundColor = .clear
            
            let blurEffect = UIBlurEffect(style: style)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            //always fill the view
            blurEffectView.roundCornerwithCell(.topRightLeft, radius: 25)
            blurEffectView.frame = self.frame
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            self.insertSubview(blurEffectView, at: 0)
        } else {
            self.backgroundColor = fallbackColor
        }
    }
}

