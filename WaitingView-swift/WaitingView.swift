//
//  WaitingView.swift
//  WaitingView-swift
//
//  Created by Han Chen on 05/05/2017.
//  Copyright © 2017 Han Chen. All rights reserved.
//

import Foundation
import UIKit

class WaitingView: UIView {
  
  @IBOutlet weak var image_View: UIView!
  
  lazy private var animationLayer = CALayer()
  lazy private var image = UIImage(named: "ic_spinner")
  private var isAnimating = false
  
  override func awakeFromNib() {
    self.animationLayer.frame = CGRect(origin: CGPoint.zero, size: self.image_View.frame.size)
    self.animationLayer.contents = image?.cgImage
    self.animationLayer.masksToBounds = true
    self.image_View.layer.addSublayer(self.animationLayer)
    self.addRotation(layer: self.animationLayer)
    self.pause(layer: self.animationLayer)
  }
  
  @IBAction func cancelButtonPressed(_ sender: UIButton) {
    self.stopAnimation()
    self.removeFromSuperview()
  }
  
  // MARK: - Utilities
  private func addRotation(layer: CALayer) {
    let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
    
    rotationAnimation.fromValue = NSNumber(value: 0)
    rotationAnimation.toValue = NSNumber(value: Double.pi * 2)
    rotationAnimation.duration = 1.0
    rotationAnimation.repeatCount = HUGE
    rotationAnimation.fillMode = kCAFillModeForwards
    rotationAnimation.isRemovedOnCompletion = false
    
    layer.add(rotationAnimation, forKey: "rotate")
  }
  
  private func pause(layer: CALayer) {
    let pausedTime = layer.convertTime(CACurrentMediaTime(), from: nil)
    layer.speed = 0.0
    layer.timeOffset = pausedTime
    self.isAnimating = false
  }
  
  private func resume(layer: CALayer) {
    let pausedTime = layer.timeOffset
    layer.speed = 1.0
    layer.timeOffset = 0.0
    layer.beginTime = 0.0
    let timeSincePause = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
    layer.beginTime = timeSincePause
    self.isAnimating = true
  }
  
  func startAnimating() {
    guard self.isAnimating == false else {
      return
    }
    self.resume(layer: self.animationLayer)
  }
  
  func stopAnimation() {
    self.pause(layer: self.animationLayer)
  }
}
