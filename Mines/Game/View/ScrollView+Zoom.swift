//
//  ScrollView+Zoom.swift
//  Mines
//
//  Created by Andrey Zonov on 28/10/2018.
//  Copyright © 2018 Andrey Zonov. All rights reserved.
//

import UIKit

extension UIScrollView {
    
    func zoomTo(location: CGPoint) {
        let rect = zoomRectForScale(1, center: location)
        zoom(to: rect, animated: true)
    }
    
    func zoomRectForScale(_ scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect: CGRect = .zero
        
        zoomRect.size.height = frame.size.height / scale;
        zoomRect.size.width  = frame.size.width / scale;
        
        zoomRect.origin.x = center.x * (2 - minimumZoomScale) - (zoomRect.size.width  / 2)
        zoomRect.origin.y = center.y * (2 - minimumZoomScale) - (zoomRect.size.height / 2)
        
        return zoomRect
    }
}

