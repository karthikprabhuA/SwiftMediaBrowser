//
//  KPAMediaBrowserCollectionViewCell.swift
//  SwiftMediaBrowser
//
//  Created by Karthik Prabhu Alagu on 25/08/15.
//  Copyright © 2015 KPAlagu. All rights reserved.
//

import UIKit

class KPAMediaBrowserCollectionViewCell: UICollectionViewCell {
    var imageView:UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.imageView = UIImageView(frame: self.bounds);
        self.imageView.contentMode = .scaleAspectFill;
        self.imageView.clipsToBounds = true;
        self.imageView.autoresizingMask = [UIView.AutoresizingMask.flexibleHeight,UIView.AutoresizingMask.flexibleWidth];
        self.addSubview(self.imageView);
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
}
