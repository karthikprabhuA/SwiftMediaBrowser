//
//  KPACaptionView.swift
//  SwiftMediaBrowser
//
//  Created by Sathiya Karthik Prabhu on 05/09/15.
//  Copyright © 2015 KPAlagu. All rights reserved.
//

import UIKit



class KPACaptionView:UIView {
    var label:UILabel!;
    let labelPadding: CGFloat = 10;
    override init(frame: CGRect) {
        super.init(frame: frame)
    self.userInteractionEnabled = false
   self.autoresizingMask = [UIViewAutoresizing.FlexibleWidth , UIViewAutoresizing.FlexibleTopMargin , UIViewAutoresizing.FlexibleLeftMargin , UIViewAutoresizing.FlexibleRightMargin]

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func sizeThatFits(size: CGSize) -> CGSize {
        var maxHeight: CGFloat = 9999
        if label.numberOfLines > 0 {
            maxHeight = label.font.leading * CGFloat(label.numberOfLines)
        }
        let textSize: CGSize = label.text!.boundingRectWithSize(CGSizeMake(size.width - labelPadding * 2, maxHeight), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: label.font], context: nil).size
        return CGSizeMake(size.width, textSize.height + labelPadding * 2)
    }
    
    func setupCaption(caption:String) {
        label = UILabel(frame: CGRectIntegral(CGRectMake(labelPadding, 0, self.bounds.size.width - labelPadding * 2, self.bounds.size.height)))
        label.autoresizingMask = [UIViewAutoresizing.FlexibleWidth,UIViewAutoresizing.FlexibleHeight]
        label.opaque = false
        label.backgroundColor = UIColor.clearColor()
        label.textAlignment = NSTextAlignment.Center
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.numberOfLines = 3
        label.textColor = UIColor.blackColor()
        label.font = UIFont.systemFontOfSize(17)
        label.text = caption;
     
        self.addSubview(label)
    }
}