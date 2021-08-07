//
//  CommentViewController.swift
//  Rnd02
//
//  Created by SooHoon on 2021/08/05.
//

import UIKit

var commentArray: NSMutableArray = NSMutableArray()
var fNo = 1
var ipAdd = "172.20.10.10"

class CommentViewController: UIViewController {

    @IBOutlet weak var tbComment: UITableView!
    @IBOutlet weak var tvAddComment: UITextView!
    @IBOutlet weak var insertView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var textViewBC: NSLayoutConstraint!
        
        
    var cNo = 0
    var cSubmitDate = ""
    var cWriter = "DDD"
    var cContent = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let commentSelectModel = CommentSelectModel()
        commentSelectModel.delegate = self
        commentSelectModel.getComment(fNo: fNo)
        print(commentArray.count)
        
//        tvAddComment.translatesAutoresizingMaskIntoConstraints = true
//        insertView.sizeToFit()

        
        tvAddComment.text = " j"
        
        
        tbComment.delegate = self
        tbComment.dataSource = self
        tbComment.rowHeight = UITableView.automaticDimension
        tbComment.estimatedRowHeight = 500
        tbComment.separatorStyle = .none
        

    } //ViewDidLoad
    
    override func viewWillLayoutSubviews() {
        insertView.sizeToFit()
        insertView.layoutIfNeeded()
        tbComment.sizeToFit()
        tbComment.layoutIfNeeded()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {

        let commentSelectModel = CommentSelectModel()
        commentSelectModel.delegate = self
        commentSelectModel.getComment(fNo: fNo)
        print("Data Reload")
    }
    
    
    @IBAction func btnAddComment(_ sender: UIButton) {
        
//        cWriter =
        
        cContent = tvAddComment.text
        
        print(" count 1 : " , commentArray.count)
        let insertModel = CommentInsertModel()
        insertModel.delegate = self
        insertModel.insertGetComment(cWriter: cWriter, cContent: cContent, fNo: fNo)
        print("insert End")
     
    }
   
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

} // View

extension CommentViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! CommentTableViewCell
        
        cell.delegate = tbComment as? CommentTableViewCellDelegate
        
        let comment: DBModel = commentArray[indexPath.row] as! DBModel
        
        cell.lblWriter.text = comment.cWriter
        cell.imgProfile.image = UIImage(named: "flower_01.png")
        cell.tvContent.text = comment.cContent
        
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
        
    } // delete row func
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "삭제"
    }
    
    
    
} // UITableViewDataSource / delegate

extension CommentViewController : CommentSelectProtocol{
    func commentDownload(comment: NSArray) {
        commentArray = comment as! NSMutableArray
        self.tbComment.reloadData()
    }
} // SelectProtocol

extension CommentViewController : CommentInsertProtocol{
    func insertDownload(comment: NSArray) {
        commentArray = comment as! NSMutableArray
        self.tbComment.reloadData()
    }
} // InsertProtocol

extension CommentViewController{
    
}

//extension UITextView{
//    func setAddTextview(){
//        self.translatesAutoresizingMaskIntoConstraints = true
//        self.sizeToFit()
//    }
//}

//extension CommentViewController : UITextViewDelegate {
//    func updateTextViewHeight(_ cell: CommentTableViewCell, _ textView: UITextView) {
//
//        let size = textView.bounds.size
//        let newSize = tvAddComment.sizeThatFits(CGSize(width: size.width, height: CGFloat.greatestFiniteMagnitude))
//        print(newSize)
//
//        if size.height != newSize.height {
//        UIView.setAnimationsEnabled(false)
//            tbComment.beginUpdates()
//            tbComment.endUpdates()
//            UIView.setAnimationsEnabled(true)
//        }
//    }
//}
