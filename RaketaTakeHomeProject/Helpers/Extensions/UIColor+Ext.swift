//
//  UIColor+Ext.swift
//  RaketaTakeHomeProject
//
//  Created by Sergey Yelmanov on 14.06.2020.
//  Copyright © 2020 Sergey Yelmanov. All rights reserved.
//

import UIKit

extension UIColor {

    static let mainBackground: UIColor = {
        UIColor { traintCollection in
            if traintCollection.userInterfaceStyle == .dark {
                return UIColor(red: 18/255, green: 23/255, blue: 27/255, alpha: 1)
            } else {
                return UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
            }
        }
    }()

    static let secondaryBackground: UIColor = {
        UIColor { traintCollection in
            if traintCollection.userInterfaceStyle == .dark {
                return UIColor(red: 40/255, green: 45/255, blue: 49/255, alpha: 1)
            } else {
                return .white
            }
        }
    }()

    static let mainText: UIColor = {
        UIColor { traintCollection in
            if traintCollection.userInterfaceStyle == .dark {
                return .white
            } else {
                return .black
            }
        }
    }()

    static let secondaryText: UIColor = {
        UIColor { traintCollection in
            if traintCollection.userInterfaceStyle == .dark {
                return UIColor(red: 183/255, green: 183/255, blue: 183/255, alpha: 1)
            } else {
                return UIColor(red: 103/255, green: 103/255, blue: 103/255, alpha: 1)
            }
        }
    }()

    static let refreshControl: UIColor = {
        UIColor { traintCollection in
            if traintCollection.userInterfaceStyle == .dark {
                return .white
            } else {
                return UIColor(red: 183/255, green: 183/255, blue: 183/255, alpha: 1)
            }
        }
    }()
    
}
