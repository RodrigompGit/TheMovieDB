//
//  UIViewExtension.swift
//  TheMovieDB
//
//  Created by Eduardo Fornari on 20/06/17.
//  Copyright © 2017 Rodrigo Pacheco. All rights reserved.
//

import UIKit

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
