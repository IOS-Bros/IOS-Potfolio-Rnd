//
//  ViewController.swift
//  HeightTest
//
//  Created by SooHoon on 2021/08/07.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        textView.translatesAutoresizingMaskIntoConstraints = true
        textView.isScrollEnabled = false
        
        self.view.addSubview(textView)
        
        
    }


}

