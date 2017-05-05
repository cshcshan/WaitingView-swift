//
//  ViewController.swift
//  WaitingView-swift
//
//  Created by Han Chen on 05/05/2017.
//  Copyright © 2017 Han Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  lazy var waitingView: WaitingView = {
    let view = UINib(nibName: "WaitingView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! WaitingView
    view.frame = CGRect(origin: CGPoint.zero, size: UIScreen.main.bounds.size)
    return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func openButtonPressed(_ sender: UIButton) {
    self.view.addSubview(self.waitingView)
    self.waitingView.startAnimating()
  }
}

