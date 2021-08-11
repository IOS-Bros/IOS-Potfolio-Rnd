//
//  CommentViewController.swift
//  RndFinal
//
//  Created by SooHoon on 2021/08/11.
//

import UIKit

var commentArray: NSMutableArray = NSMutableArray()
var fNo = 1
var ipAdd = "172.20.10.10"

class CommentViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var tbComment: UITableView!
    @IBOutlet weak var tvAddComment: UITextView!
    @IBOutlet weak var insertView: UIView!
    
    var cNo = 0
    var cSubmitDate = ""
    var cWriter = "DDD"
    var cContent = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let commentSelectModel = CommentSelectModel()
        commentSelectModel.delegate = self
        commentSelectModel.getComment(fNo: fNo)
        print("Data Reload")
        
        // textViewDesign
        tvAddComment.layer.borderWidth = 0.7
        tvAddComment.layer.borderColor = UIColor.gray.cgColor
        tvAddComment.layer.cornerRadius = 20
        tvAddComment.textContainerInset = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        
        // textView Delegate >> Dynamic Height
        tvAddComment.resignFirstResponder()
        tvAddComment.delegate = self
        tvAddComment.setInsertTextView()
//        tvAddComment.returnKeyType = .done
        
        // Dynamic Heigh of UIVIew
        insertView.setView()
//        insertView.resignFirstResponder()
        
        // tableViwe Delegate
        tbComment.delegate = self
        tbComment.dataSource = self
        tbComment.rowHeight = UITableView.automaticDimension
        tbComment.estimatedRowHeight = 500
        tbComment.separatorStyle = .none
        
        tbComment.remembersLastFocusedIndexPath = true
        
        tvAddComment.isUserInteractionEnabled = false
        
        delayTime()
        
        // Solution 3
        NotificationCenter.default.addObserver(self, selector: #selector(CommentViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        
        // call the 'keyboardWillHide' function when the view controlelr receive notification that keyboard is going to be hidden
          NotificationCenter.default.addObserver(self, selector: #selector(CommentViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
    } // ViewDidLoad

    
    override func viewWillAppear(_ animated: Bool) {

//        let commentSelectModel = CommentSelectModel()
//        commentSelectModel.delegate = self
//        commentSelectModel.getComment(fNo: fNo)
//        print("Data Reload")
    }
    
    func delayTime(){
        let time = DispatchTime.now() + .seconds(2)
        DispatchQueue.main.asyncAfter(deadline: time, execute: delayTextview)
    }
    
    func delayTextview(){
        tvAddComment.isUserInteractionEnabled = true
    }
    
    // NotificationCenter Selector func ***************
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
           // if keyboard size is not available for some reason, dont do anything
           return
        }
        if let newFrame = (notification.userInfo?[ UIResponder.keyboardFrameEndUserInfoKey ] as? NSValue)?.cgRectValue {
            let insets = UIEdgeInsets( top: newFrame.height, left: 0, bottom: 0, right: 0 )
                    tbComment.scrollIndicatorInsets = insets
                    tbComment.contentInset = insets
                }
        // move the root view up by the distance of keyboard height
          self.view.frame.origin.y = 60 - keyboardSize.height
//        tbComment.frame.origin.y = 0 - keyboardSize.height
        
        }
      
    @objc func keyboardWillHide(notification: NSNotification) {
      // move back the root view origin to zero
      self.view.frame.origin.y = 0
    
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        if tvAddComment.frame.size.height < 70{

        let maximumWidth: CGFloat = 331 // Change as appropriate for your use.
        let maximunheight: CGFloat = 105
        let newSize = textView.sizeThatFits(CGSize(width: maximumWidth, height: .greatestFiniteMagnitude ))
            
                textView.frame.size = newSize
                insertView.frame.size = newSize
        var newFrame = textView.frame
            
            newFrame.size = CGSize(width: max(newSize.width, maximumWidth), height: newSize.height)
                textView.frame = newFrame
                insertView.frame = newFrame
        } else {
            
        }
    }
    
    
    @IBAction func btnAddComment(_ sender: UIButton) {
        
        cContent = tvAddComment.text
        
        print(" count 1 : " , commentArray.count)
        let insertModel = CommentInsertModel()
        insertModel.delegate = self
        insertModel.insertGetComment(cWriter: cWriter, cContent: cContent, fNo: fNo)
        print("insert End")
        
        tvAddComment.text = ""
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

} // ViewCOntroller

    
//============================================


extension CommentViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! CommentTableViewCell
        
        print("#")
        cell.delegate = tbComment as? CommentTableViewCellDelegate
        
        let comment: DBModel = commentArray[indexPath.row] as! DBModel
        
        cell.lblCWriter.text = comment.cWriter
        cell.tvComment.text = comment.cContent
        cell.imgProfile.image = UIImage(named: "flower_01.png")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let comment : DBModel = commentArray[indexPath.row] as! DBModel
        
        if editingStyle == .delete {
            
            // 삭제에 사용할 키 값 불러오기
            let cNo = comment.cNo!
            print("cNo :", cNo)
            let deleteModel = DeleteModel()
            let result = deleteModel.DeleteItems(cNo: cNo)
            print("---->", result)
            
                if result == true{
                    let resultAlert = UIAlertController(title: "완료", message: "삭제가 완료됐습니다", preferredStyle: .alert)
                    let onAction = UIAlertAction(title: "OK", style: .default, handler: {ACTION in
                        commentArray.removeObject(at: indexPath.row)
                        tableView.deleteRows(at: [indexPath], with: .fade)
                    })
                    
                    resultAlert.addAction(onAction)
                    present(resultAlert, animated: true, completion: nil)
                    
                }else{
                    let resultAlert = UIAlertController(title: "실패", message: "에러가 발생했습니다", preferredStyle: .alert)
                    let onAction = UIAlertAction(title: "OK", style: .default, handler: {ACTION in
                        self.navigationController?.popViewController(animated: true)
                    })
                    
                    resultAlert.addAction(onAction)
                    present(resultAlert, animated: true, completion: nil)
                }
            }else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "삭제"
    }
    
} // UITableView extension


extension UITextView {
    func setInsertTextView(){
        self.translatesAutoresizingMaskIntoConstraints = true
        self.isScrollEnabled = true
    }
}

extension UIView{
    func setView(){
        let newView = UIView()
        self.addSubview(newView)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.sizeToFit()
    }
}



extension CommentViewController : CommentSelectProtocol{
    func commentDownload(comment: NSArray) {
        commentArray = comment as! NSMutableArray
        self.tbComment.reloadData()
        
//        tvAddComment.isUserInteractionEnabled = true
    }
} // SelectProtocol

extension CommentViewController : CommentInsertProtocol{
    func insertDownload(comment: NSArray) {
        commentArray = comment as! NSMutableArray
        self.tbComment.reloadData()
    }
} // InsertProtocol

