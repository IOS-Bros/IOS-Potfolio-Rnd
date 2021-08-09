//
//  ViewController.swift
//  HeightTest
//
//  Created by SooHoon on 2021/08/07.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate{
    
    @IBOutlet weak var insertView: UIView!
    @IBOutlet weak var textView: UITextView!
//    var keyHeight: CGFloat = 0.0

    
    
    // 애니메이션이 끝난 후 프레임이 동작하므로 keyboardFramdEndUserInfoKey를 사용한다.
//    let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        textView.text = "cofee Love cofee Love "
        // Do any additional setup after loading the view.
        // textView Design
        textView.textContainer.maximumNumberOfLines = 3
        textView.textContainer.lineBreakMode = .byTruncatingTail
        textView.layer.borderWidth = 0.7
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.layer.cornerRadius = 20
        textView.textContainerInset = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        
        
        textView.resignFirstResponder()
        textView.delegate = self
        textView.setTextView()
       
        
        textView.delegate = self
        textView.returnKeyType = .done
        
        
        // Solution 3
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        
        // call the 'keyboardWillHide' function when the view controlelr receive notification that keyboard is going to be hidden
          NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    } // ViewDidLoad
    
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
           // if keyboard size is not available for some reason, dont do anything
           return
        }
        // move the root view up by the distance of keyboard height
          self.view.frame.origin.y = 0 - keyboardSize.height
        
        }
      
    @objc func keyboardWillHide(notification: NSNotification) {
      // move back the root view origin to zero
      self.view.frame.origin.y = 0
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let maximumWidth: CGFloat = 271 // Change as appropriate for your use.
        let maximunheight: CGFloat = 70
        let newSize = textView.sizeThatFits(CGSize(width: maximumWidth, height: .greatestFiniteMagnitude ))
        textView.frame.size = newSize
        var newFrame = textView.frame
        newFrame.size = CGSize(width: max(newSize.width, maximumWidth), height: max(maximunheight, newSize.height))
              textView.frame = newFrame
//        let newSizeFit = textView.sizeThatFits(CGSize(width: fixedWidth, height: fixedHeight))
//        textView.frame.size = newSizeFit
//        let newSize = textView.sizeThatFits(CGSize(width: 271, height: .greatestFiniteMagnitude))
        
    }
    
} // ViewController



extension UITextView{
    func setTextView(){
        self.translatesAutoresizingMaskIntoConstraints = true
    }
}
//
//
//extension ViewController: UITextViewDelegate{
//    func textViewDidChange(_ textView: UITextView) {
//        let maximumWidth: CGFloat = 357 // Change as appropriate for your use.
//        let maximunheight: CGFloat = 200
//           let newSize = textView.sizeThatFits(CGSize(width: maximumWidth, height: .greatestFiniteMagnitude))
//           textView.frame.size = CGSize(width: newSize.width, height: newSize.height)
//    }
//}




