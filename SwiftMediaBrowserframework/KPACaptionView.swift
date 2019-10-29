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
        self.isUserInteractionEnabled = false
        self.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth , UIView.AutoresizingMask.flexibleTopMargin , UIView.AutoresizingMask.flexibleLeftMargin , UIView.AutoresizingMask.flexibleRightMargin]

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var maxHeight: CGFloat = 9999
        if label.numberOfLines > 0 {
            maxHeight = label.font.leading * CGFloat(label.numberOfLines)
        }
        let textSize: CGSize = label.text!.boundingRect(with: CGSize(width:size.width - labelPadding * 2, height:maxHeight), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: label.font ?? UIFont.systemFont(ofSize: 18)], context: nil).size
        return CGSize(width:size.width, height:textSize.height + labelPadding * 2)
    }
    
    func setupCaption(caption:String) {
        label = UILabel(frame: CGRect(x:labelPadding, y:0, width:self.bounds.size.width - labelPadding * 2, height:self.bounds.size.height).integral)
        label.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth,UIView.AutoresizingMask.flexibleHeight]
        label.isOpaque = false
        label.backgroundColor = UIColor.clear
        label.textAlignment = NSTextAlignment.center
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 3
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 17)
        label.text = caption;
     
        self.addSubview(label)
    }
}
