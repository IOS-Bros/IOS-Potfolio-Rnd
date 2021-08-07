//
//  CommentTableViewCell.swift
//  Rnd02
//
//  Created by SooHoon on 2021/08/05.
//

import UIKit

protocol CommentTableViewCellDelegate : class {
    func updateTextViewHeight(_ cell: CommentTableViewCell,_ textView:UITextView)
}

class CommentTableViewCell: UITableViewCell {
    
    weak var delegate: CommentTableViewCellDelegate?
    
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var tvContent: UITextView!
    @IBOutlet weak var lblWriter: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setTextView()
        // Initialization code
        tvContent.isUserInteractionEnabled = false
    }

    
    func setTextView(){
        tvContent.delegate = self
        tvContent.isScrollEnabled = false
        tvContent.sizeToFit()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension CommentTableViewCell: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        if let delegate = delegate {
            delegate.updateTextViewHeight(self, tvContent)
        }
    }
}

extension UITextView{
    func setTextview(){
        // 텍스트 뷰 줄 수만큼 높이 조절
        self.translatesAutoresizingMaskIntoConstraints = true
        self.sizeToFit()
    }
}
