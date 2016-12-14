//
//  SlideScrollView.swift
//  SnapShot
//
//  Created by Jacob Li on 14/10/2015.
//  Copyright © 2015 Jacob Li. All rights reserved.
//

import Foundation
import Haneke
import UIKit

protocol SlideScrollViewDelegate {
    
    func SlideScrollViewDidClicked(_ index:Int)

}

class SlidScrollView: UIView,UIScrollViewDelegate {
    var viewSize:CGRect = CGRect()
    var scrollView:UIScrollView = UIScrollView()
    
    var pageControl:UIPageControl = UIPageControl()
    var currentPageIndex:Int = 0
    var noteTitle:UILabel = UILabel()
    var arrayCount: Int = 0
    var timer: Timer?
    var delegate:SlideScrollViewDelegate?
    var titleArray:[String]!
    
    func initWithFrameRect(_ rect:CGRect, picAddressArray:[String], titleArray:[String]) -> AnyObject {
        
        var tempArray:[String] = picAddressArray
        self.titleArray = titleArray
        arrayCount = tempArray.count
        viewSize = rect;
        let pageCount: Int = tempArray.count
        self.isUserInteractionEnabled  = true
        scrollView = UIScrollView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: viewSize.size.width, height: viewSize.size.height)))
        scrollView.isPagingEnabled = true
        scrollView.contentSize = CGSize(width: viewSize.size.width * CGFloat(arrayCount + 2), height: viewSize.size.height)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        scrollView.isScrollEnabled = true
        scrollView.isPagingEnabled = true
        scrollView.scrollsToTop = false
        scrollView.delegate = self
        
        let firstImageView: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: viewSize.size.width, height: viewSize.size.height))
        firstImageView.hnk_setImageFromURL(URL(string: tempArray[tempArray.count - 1])!)
        self.scrollView.addSubview(firstImageView)
        self.titleArray.insert(titleArray[titleArray.count - 1], at: 0)
        
        for i in 0 ..< tempArray.count {
            let imageView: UIImageView = UIImageView(frame: CGRect(x: viewSize.size.width * CGFloat(i + 1), y: 0, width: viewSize.size.width, height: viewSize.size.height))
            imageView.hnk_setImageFromURL(URL(string: tempArray[i])!)
            self.scrollView.addSubview(imageView)
        }
        
        let lastImageView: UIImageView = UIImageView(frame: CGRect(x: viewSize.size.width * CGFloat((tempArray.count + 1)), y: 0, width: viewSize.size.width, height: viewSize.size.height))
        lastImageView.hnk_setImageFromURL(URL(string: tempArray[0])!)
        self.scrollView.addSubview(lastImageView)
        self.titleArray.append(titleArray[1])
        print(titleArray)
        
        
        self.scrollView.scrollRectToVisible(CGRect(x: viewSize.size.width, y: 0, width: viewSize.size.width, height: viewSize.size.height), animated: false)
        let tapGestureRecognizer:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SlidScrollView.imagePressed))
        
        tapGestureRecognizer.numberOfTapsRequired = 1
        tapGestureRecognizer.numberOfTouchesRequired = 1
        self.addGestureRecognizer(tapGestureRecognizer)
        
        
        self.addSubview(scrollView)
        
        let myHeight:Float = 24
        let shadowImg:UIImageView = UIImageView()
        shadowImg.frame = CGRect(x: 0, y: viewSize.height - 80, width: 320, height: 80)
        shadowImg.image = UIImage(named: "shadow.png")
        self.addSubview(shadowImg)
        
        let noteView:UIView = UIView(frame:CGRect(origin:CGPoint(x:0, y:170),size:CGSize(width:320,height:CGFloat(myHeight))))
        noteView.isUserInteractionEnabled = false;
        noteView.backgroundColor = UIColor(red:0/255.0,green:0/255.0,blue:0/255.0,alpha:0)
        
        let pageControlWidth:Float = (Float(pageCount-2)) * 10.0 + Float(40)
        let pagecontrolHeight:Float = myHeight
        
        pageControl = UIPageControl(
                frame: CGRect(origin: CGPoint(x: CGFloat(Float(self.viewSize.size.width)/2 - Float(pageControlWidth/2)), y: 0),
                size: CGSize(width: CGFloat(pageControlWidth), height: CGFloat(pagecontrolHeight))))
        
        pageControl.currentPage = 0;
        pageControl.numberOfPages = pageCount
        noteView.addSubview(pageControl)
        
        noteTitle = UILabel()
        noteTitle.textColor = UIColor.white
        noteTitle.font = UIFont.boldSystemFont(ofSize: 16)
        noteTitle.numberOfLines = 0
        noteTitle.lineBreakMode = NSLineBreakMode.byCharWrapping
        
        noteTitle.text = self.titleArray[1]
        noteTitle.frame = CGRect(origin: CGPoint(x: 10, y: 130), size: CGSize(width: 300, height: 50))
        
        let maskImage = UIImage(named: "HomeImageMask")
        let maskImageView = UIImageView(frame: CGRect(x: 0, y: viewSize.size.height - 75, width: viewSize.size.width, height: 75))
        maskImageView.image = maskImage
        
        self.addSubview(maskImageView)
        self.addSubview(noteTitle)
        self.addSubview(noteView)
        
        
       self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(SlidScrollView.autoShowNextPage), userInfo: nil, repeats: true)
        
        
        return self
        

        
    }
    
    func autoShowNextPage() {
        let pageWidth: CGFloat = self.scrollView.frame.size.width
        currentPageIndex = Int(self.scrollView.contentOffset.x / pageWidth)
        if currentPageIndex == 0 {
            self.pageControl.currentPage = arrayCount - 1
        } else if currentPageIndex == arrayCount + 1 {
            self.pageControl.currentPage = 0
        } else {
            self.pageControl.currentPage = currentPageIndex - 1
        }
        
        var currentPageNumber = self.pageControl.currentPage
        
        self.scrollView .scrollRectToVisible(CGRect(x: CGFloat(currentPageNumber + 2) * pageWidth, y: 0, width: viewSize.size.width, height: viewSize.size.height), animated: true)
        self.noteTitle.text = self.titleArray[currentPageNumber + 2]
        
        currentPageNumber += 1
        
        if currentPageNumber == arrayCount {
            self.scrollView.scrollRectToVisible(CGRect(x: viewSize.size.width, y: 0, width: viewSize.size.width, height: viewSize.size.height), animated: false)
            currentPageNumber = 0
        }
        
        self.pageControl.currentPage = currentPageNumber
    
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentPageIndex = Int(self.scrollView.contentOffset.x / viewSize.size.width)
        if currentPageIndex == 0 {
            self.scrollView .scrollRectToVisible(CGRect(x: viewSize.size.width * CGFloat(arrayCount), y: 0, width: viewSize.size.width, height: viewSize.size.height), animated: false)
            self.pageControl.currentPage = arrayCount - 1
        } else if currentPageIndex == arrayCount + 1 {
            self.scrollView.scrollRectToVisible(CGRect(x: viewSize.size.width, y: 0, width: viewSize.size.width, height: viewSize.size.height), animated: false)
            self.pageControl.currentPage = 0
        } else {
            self.pageControl.currentPage = currentPageIndex - 1
        }
        self.noteTitle.text = self.titleArray[pageControl.currentPage + 1]
        self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(SlidScrollView.autoShowNextPage), userInfo: nil, repeats: true)
    }
    
    
    func imagePressed (){
        delegate?.SlideScrollViewDidClicked(pageControl.currentPage)
    }

    
}
