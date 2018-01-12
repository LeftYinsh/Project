//
//  DiariesTableViewController.swift
//  Project
//
//  Created by HongRuWu on 2018/1/11.
//  Copyright © 2018年 HongRuWu. All rights reserved.
//

import UIKit

class DiariesTableViewController: UITableViewController {
    
    var diaries = [Diary]()
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        diaries.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        Diary.saveToFile(diaries: diaries)
        tableView.reloadData()
        
    }
    
    @IBAction func addDiariesTableViewController(segue: UIStoryboardSegue) {
        if let controller = segue.source as? AddDiaryTableViewController {
            diaries.append(controller.diary)
            Diary.saveToFile(diaries: diaries)
            tableView.reloadData()
        }
    }
    
    @IBAction func saveDiariesTabkeViewController(segue: UIStoryboardSegue) {
        let source = segue.source as? EditDiaryTableViewController
        if let diary = source?.diary, let row = tableView.indexPathForSelectedRow?.row {
            diaries[row] = diary
            Diary.saveToFile(diaries: diaries)
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        if let diaries = Diary.readLoversFromFile() {
            self.diaries = diaries
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return diaries.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "diaryCell", for: indexPath) as? DiaryTableViewCell else  {
            assert(false)
        }
        
        // Configure the cell...
        let diary = diaries[indexPath.row]
        cell.titleLabel.text = diary.title
        cell.dateLabel.text = diary.date
        cell.photoImageView.image = diary.image
        
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
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let editDiaryTableViewController = segue.destination as? EditDiaryTableViewController
        if let row = tableView.indexPathForSelectedRow?.row {
            editDiaryTableViewController?.diary = diaries[row]
        }
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
}
