//
//  CustomAnnotationView.swift
//  SnapShot
//
//  Created by Jacob Li on 14/01/2016.
//  Copyright © 2016 Jacob Li. All rights reserved.
//

import Foundation
import UIKit

class CustomAnnotation: MAAnnotationView {
    var name: String?
    var portrait: UIImage?
    var calloutView: UIView?
    var portraitImageView: UIImageView?
    var nameLabel: UILabel?
    
    func btnAction() {
        print(self.annotation.coordinate)
    }
    
    override init!(annotation: MAAnnotation!, reuseIdentifier: String!) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.bounds = CGRectMake(0, 0, 150, 60)
        self.backgroundColor = UIColor.lightGrayColor()
        self.portraitImageView = UIImageView(frame: CGRectMake(5, 5, 30, 30))
        self .addSubview(self.portraitImageView!)
        
        self.nameLabel = UILabel(frame: CGRectMake(35, 35, 40, 20))
        self.nameLabel?.textColor = UIColor.whiteColor()
        self.nameLabel?.backgroundColor = UIColor.clearColor()
        self.nameLabel?.font = UIFont.systemFontOfSize(15)
        self .addSubview(self.nameLabel!)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    
}