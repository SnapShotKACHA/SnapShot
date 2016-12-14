//
//  SPNavigationBar.swift
//  SnapShot
//
//  Created by Jacob Li on 27/10/2015.
//  Copyright © 2015 Jacob Li. All rights reserved.
//

import Foundation
import UIKit

class SPNavigationBar: UINavigationBar {
    var SPNavigationBarItem: UINavigationItem?
    override init(frame: CGRect) {
        super.init(frame: frame)
        let titleShadow: NSShadow = NSShadow()
        titleShadow.shadowColor = UIColor(red: 218/255, green: 147/255, blue: 171/255, alpha: 1)
        titleShadow.shadowOffset = CGSize(width: 1, height: 1)
        self.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white, NSFontAttributeName:UIFont(name: "Heiti SC", size: 24.0)!, NSShadowAttributeName:titleShadow]
        
        self.barTintColor = UIColor(red: 2/255, green: 191/255, blue: 141/255, alpha: 1)
        
        self.tintColor = UIColor.white
        self.pushItem(initNavigationBarItem(), animated: false)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initNavigationBarItem() -> UINavigationItem {
        SPNavigationBarItem = UINavigationItem()
        SPNavigationBarItem!.title = "SnapShot"
        SPNavigationBarItem!.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: "searchButtonAction")
        return SPNavigationBarItem!
    }

}
