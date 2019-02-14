//
//  FaceView.swift
//  FaceIt
//
//  Created by Chen Richard on 2016/5/7.
//  Copyright © 2016年 Chen Richard. All rights reserved.
//

import UIKit

@IBDesignable
class FaceView: UIView {
    @IBInspectable
    var scale: CGFloat = 0.90 { didSet{ setNeedsDisplay() } }
    @IBInspectable
    var mouthCurvature: Double = 1.0 { didSet{ setNeedsDisplay() } }
    @IBInspectable
    var eyesOpen: Bool = true { didSet{ setNeedsDisplay() } }
    @IBInspectable
    var eyeBrowTilt: Double = 0.0 { didSet{ setNeedsDisplay() } }
    @IBInspectable
    var color: UIColor = UIColor.blueColor() { didSet{ setNeedsDisplay() } }
    @IBInspectable
    var linewidth: CGFloat = 5.0 { didSet{ setNeedsDisplay() } }
    
    func changeScale(recognizer: UIPinchGestureRecognizer){
        switch recognizer.state{
        case .Changed, .Ended:
            scale *= recognizer.scale
            recognizer.scale = 1.0
        default:
            break
        }
    }
    
    private var skullradius: CGFloat{
        return min(bounds.size.width, bounds.size.height)/2 * scale
    }
    
    private var skullcenter: CGPoint{
        return CGPoint(x:bounds.midX, y:bounds.midY)
    }
    
    private struct Ratios{
        static let SkullRadiusToEyeOffset: CGFloat = 3
        static let SkullRadiusToEyeRadius: CGFloat = 10
        static let SkullRadiusToMouthWidth: CGFloat = 1
        static let SkullRadiusToMouthHeight: CGFloat = 3
        static let SkullRadiusToMouthOffset: CGFloat = 3
        static let SkullRadiusToBrowOffset: CGFloat = 5
    }
    
    private enum Eye{
        case Left
        case Right
    }
    
    private func pathForCircleCenteredAtPoint(midPoint:CGPoint, withRadius radius: CGFloat) -> UIBezierPath
    {
        let path = UIBezierPath(
            arcCenter: midPoint,
            radius: radius,
            startAngle:0.0,
            endAngle: CGFloat(2*M_PI),
            clockwise:false
        )
        path.lineWidth = linewidth
        return path
    }
    
    private func getEyeCenter(eye: Eye)-> CGPoint{
        let eyeOffset = skullradius / Ratios.SkullRadiusToEyeOffset
        var eyeCenter = skullcenter
        eyeCenter.y -= eyeOffset
        switch eye{
        case .Left: eyeCenter.x -= eyeOffset
        case .Right: eyeCenter.x += eyeOffset
        }
        return eyeCenter
    }
    
    private func pathForEye(eye: Eye)-> UIBezierPath
    {
        let eyeRadius = skullradius / Ratios.SkullRadiusToEyeRadius
        let eyeCenter = getEyeCenter(eye)
        if eyesOpen{
            return pathForCircleCenteredAtPoint(eyeCenter, withRadius: eyeRadius)
        }else{
            let path = UIBezierPath()
            path.moveToPoint(CGPoint(x: eyeCenter.x - eyeRadius, y: eyeCenter.y))
            path.addLineToPoint(CGPoint(x: eyeCenter.x + eyeRadius, y: eyeCenter.y))
            path.lineWidth = linewidth
            return path
        }
    }
    
    private func pathForBrow(eye: Eye)-> UIBezierPath
    {
        var tilt = eyeBrowTilt
        switch eye {
        case .Left: tilt *= -1.0
        case .Right: break
        }
        var browCenter = getEyeCenter(eye)
        browCenter.y -= skullradius / Ratios.SkullRadiusToBrowOffset
        let eyeRadius = skullradius / Ratios.SkullRadiusToEyeRadius
        let tiltOffset = CGFloat(max(-1,min(tilt,1))) * eyeRadius / 2
        let browStart = CGPoint(x: browCenter.x - eyeRadius, y:browCenter.y - tiltOffset)
        let browEnd = CGPoint(x: browCenter.x + eyeRadius, y:browCenter.y + tiltOffset)
        let path = UIBezierPath()
        path.moveToPoint(browStart)
        path.addLineToPoint(browEnd)
        path.lineWidth = linewidth
        return path
    }
    
    private func pathForMouth()->UIBezierPath {
        let mouthWidth = skullradius / Ratios.SkullRadiusToMouthWidth
        let mouthHeight = skullradius / Ratios.SkullRadiusToMouthHeight
        let mouthOffset = skullradius / Ratios.SkullRadiusToMouthOffset
        let mouthRect = CGRect(x: skullcenter.x - mouthWidth/2, y: skullcenter.y + mouthOffset, width: mouthWidth, height: mouthHeight)
        
        
        let smileOffset = CGFloat(max(-1 , min(mouthCurvature,1))) * mouthRect.height
        let start = CGPoint(x: mouthRect.minX, y: mouthRect.minY)
        let end = CGPoint(x:mouthRect.maxX, y: mouthRect.minY)
        let cp1 = CGPoint(x: mouthRect.minX + mouthRect.width/3 , y: mouthRect.minY + smileOffset)
        let cp2 = CGPoint(x: mouthRect.maxX - mouthRect.width/3, y: mouthRect.minY + smileOffset)
        
        let path = UIBezierPath()
        path.moveToPoint(start)
        path.addCurveToPoint(end, controlPoint1: cp1, controlPoint2: cp2)
        path.lineWidth = linewidth
        return path
    }
    

    override func drawRect(rect: CGRect)
    {
        // Drawing code
        
        //Create basic path for circle
        color.set()
        pathForCircleCenteredAtPoint(skullcenter, withRadius: skullradius).stroke()
        pathForEye(.Left).stroke()
        pathForEye(.Right).stroke()
        pathForMouth().stroke()
        pathForBrow(.Left).stroke()
        pathForBrow(.Right).stroke()
    }

}