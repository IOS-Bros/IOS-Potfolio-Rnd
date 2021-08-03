//
//  FeedTableViewController.swift
//  RndNew
//
//  Created by SooHoon on 2021/08/03.
//

import UIKit

var commentArray: NSArray = NSArray()
var fNo = 1

class FeedTableViewController: UITableViewController {

    @IBOutlet var tbComment: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbComment.estimatedRowHeight = 200
        tbComment.rowHeight = UITableView.automaticDimension
        tbComment.separatorStyle = .none
//        let commentSelectModel = CommentSelectModel()
//        commentSelectModel.delegate = self
//        commentSelectModel.getComment(fNo: 1)
//        let commentComplete = commentSelectModel.getComment(fNo: 1)
//        if commentComplete {
//            print("get Comment well")
//        }else{
//            print("get Comment has been met Error")
//        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func viewWillAppear(_ animated: Bool) {
        let commentSelectModel = CommentSelectModel()
        commentSelectModel.delegate = self
        commentSelectModel.getComment(fNo: fNo)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return commentArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! FeedTableViewCell
        cell.delegate = self
        // Configure the cell...
        let comment: DBModel = commentArray[indexPath.row] as! DBModel
        
        cell.lblWriter.text = comment.cWriter!
        cell.tvContent.text = comment.cContent!
        cell.imgProfile.image = UIImage(named: "flower_01.png")

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

} // TableViewController

extension FeedTableViewController: CommentSelectProtocol{
    func commentDownload(comment: NSArray) {
        commentArray = comment
        self.tbComment.reloadData()
    }
}

extension FeedTableViewController: FeedTableViewCellDelegate {
    func updateTextViewHeight(_ cell: FeedTableViewCell, _ textView: UITextView) {
        
        let size = textView.bounds.size
        let newSize = tableView.sizeThatFits(CGSize(width: size.width, height: CGFloat.greatestFiniteMagnitude))
        print(newSize)
        
        if size.height != newSize.height {
        UIView.setAnimationsEnabled(false)
            tableView.beginUpdates()
            tableView.endUpdates()
            UIView.setAnimationsEnabled(true)
        }
    }
}
