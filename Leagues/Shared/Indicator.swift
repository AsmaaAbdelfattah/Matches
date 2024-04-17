//
//  Indicator.swift
//  Safari
//
//  Created by Asmaa_Abdelfattah on 20/07/1402 AP.
//

import Foundation
import NVActivityIndicatorView

extension NVActivityIndicatorView{
    public func showIndicator(start:Bool){
        self.isHidden = !start
        if start{
            self.type = .ballZigZag
            self.color = .blue
            self.startAnimating()
        }else{
            self.stopAnimating()
        }
    }
}

