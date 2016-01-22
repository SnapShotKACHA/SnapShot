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
    var portrait: UIImage?
    var calloutView: UIView?
    var portraitImageView: UIImageView?
    
    
    func btnAction() {
        print(self.annotation.coordinate)
    }
    
    override init!(annotation: MAAnnotation!, reuseIdentifier: String!) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.bounds = CGRectMake(0, 0, 40, 40)
        self.backgroundColor = UIColor.clearColor()
        self.portraitImageView = UIImageView(frame: CGRectMake(0, 0, 40, 40))
        self.portraitImageView?.contentMode = .ScaleAspectFit
        self .addSubview(portraitImageView!)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    
}