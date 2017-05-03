//
//  ExtensionUtility.swift
//  CherishGold
//
//  Created by Leo on 10/22/16.
//  Copyright © 2016 Leo. All rights reserved.
//

import Foundation
import UIKit


// MARK:- String Extension
extension String
{
    public func removeBlankSpaces(stringEntered: String) -> String
    {
        let trimedString = stringEntered.trimmingCharacters(in: .whitespaces)
        return trimedString + "Los Angles"
    }
}


// MARK:- UIImageView Extension
//extension UIImageView
//{
//    public func imageFromUrl(urlString: String)
//    {
//        if let url = NSURL(string: urlString) {
//            let request = NSURLRequest(url: url as URL)
//            NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.mainQueue) {
//                (response: URLResponse!, data: NSData!, error: NSError!) -> Void in
//                self.image = UIImage(data: data as Data)
//            }
//        }
//    }
//}


extension UIImageView
{
    func downloadedImageFromURL(url: URL, contentMode mode: UIViewContentMode = .scaleToFill)
    {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            
            DispatchQueue.main.async() { () -> Void in
                self.image = image
            }
            }.resume()
    }
    
    func downloadedImageFromString(link: String, contentMode mode: UIViewContentMode = .scaleToFill)
    {
        guard let url = URL(string: link) else { return }
        downloadedImageFromURL(url: url, contentMode: mode)
    }
}


// MARK:- UIButton Extension
extension UIButton
{
    func drawBorderWithLightGrayColor(cornerRadius: CGFloat, borderWidth: CGFloat)
    {
        self.backgroundColor = UIColor.clear
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
}


// MARK:- UIViewController Extension
extension UIViewController {
    var classNameInString: String {
        return NSStringFromClass(self.classForCoder).components(separatedBy: ".").last!
    }
}


// MARK:- UIView Extension
@IBDesignable extension UIView {
    @IBInspectable var borderColor:UIColor? {
        set {
            layer.borderColor = newValue!.cgColor
        }
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor:color)
            }
            else {
                return nil
            }
        }
    }

    @IBInspectable var borderWidth:CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    @IBInspectable var cornerRadius:CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }

    /* The color of the shadow. Defaults to opaque black. Colors created
     * from patterns are currently NOT supported. Animatable. */
    @IBInspectable var shadowColor: UIColor? {
        set {
            layer.shadowColor = newValue!.cgColor
        }
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor:color)
            }
            else {
                return nil
            }
        }
    }

    /* The opacity of the shadow. Defaults to 0. Specifying a value outside the
     * [0,1] range will give undefined results. Animatable. */
    @IBInspectable var shadowOpacity: Float {
        set {
            layer.shadowOpacity = newValue
        }
        get {
            return layer.shadowOpacity
        }
    }

    /* The shadow offset. Defaults to (0, -3). Animatable. */
    @IBInspectable var shadowOffset: CGPoint {
        set {
            layer.shadowOffset = CGSize(width: newValue.x, height: newValue.y)
        }
        get {
            return CGPoint(x: layer.shadowOffset.width, y:layer.shadowOffset.height)
        }
    }

    /* The blur radius used to create the shadow. Defaults to 3. Animatable. */
    @IBInspectable var shadowRadius: CGFloat {
        set {
            layer.shadowRadius = newValue
        }
        get {
            return layer.shadowRadius
        }
    }
}


extension NSLayoutConstraint {
    /**
     Change multiplier constraint

     - parameter multiplier: CGFloat
     - returns: NSLayoutConstraint
     */
    func setMultiplier(multiplier:CGFloat) -> NSLayoutConstraint {

        let newConstraint = NSLayoutConstraint(
            item: firstItem,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant)

        newConstraint.priority = priority
        newConstraint.shouldBeArchived = self.shouldBeArchived
        newConstraint.identifier = self.identifier
        newConstraint.isActive = true

        NSLayoutConstraint.deactivate([self])
        NSLayoutConstraint.activate([newConstraint])
        return newConstraint
    }
}


// MARK:- Dictionary Extension
extension Dictionary where Value:Comparable {
    var valuesOrdered:[Value] {
        return self.values.sorted()
    }
}


extension Dictionary where Key:Comparable {
    var keysOrdered:[Key] {
        return self.keys.sorted()
    }
}


extension Dictionary where Value : Equatable {
    func allKeysForValue(val : Value) -> [Key] {
        return self.filter { $1 == val }.map { $0.0 }
    }
}


//MARK:- UITextField Extension
extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSForegroundColorAttributeName: newValue!])
        }
    }
}


//MARK:- Array Extension
extension Array {
    func contains<T>(obj: T) -> Bool where T : Equatable {
        return self.filter({$0 as? T == obj}).count > 0
    }
}


extension Array where Element: Equatable {

    // Remove first collection element that is equal to the given `object`:
    mutating func remove(object: Element) {
        if let index = index(of: object) {
            remove(at: index)
        }
    }
}



