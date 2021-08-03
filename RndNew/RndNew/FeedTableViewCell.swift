//
//  FeedTableViewCell.swift
//  RndNew
//
//  Created by SooHoon on 2021/08/03.
//

import UIKit

protocol FeedTableViewCellDelegate :class {
    func updateTextViewHeight(_ cell: FeedTableViewCell,_ textView:UITextView)
}

class FeedTableViewCell: UITableViewCell {

    weak var delegate: FeedTableViewCellDelegate?
    
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblWriter: UILabel!
    @IBOutlet weak var tvContent: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setTextView()
        
//        lblWriter.text
//        tvContent.text
    }
    
    func setTextView(){
        tvContent.delegate = self
        tvContent.isScrollEnabled = false
        tvContent.sizeToFit()
    }
//
//    func setEmptyView() {
//        let tap = UITapGestureRecognizer(target: self, action: #selector(tapEmptyView))
//        emptyView.addGestureRecognizer(tap)
//    }
    
//    @objc func tapEmptyView() {
//        tvContent.becomeFirstResponder()
//    }


//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}

extension FeedTableViewCell: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        if let delegate = delegate {
            delegate.updateTextViewHeight(self, tvContent)
        }
    }
}

