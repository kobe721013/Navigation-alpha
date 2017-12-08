//
//  ViewController.swift
//  Example1
//
//  Created by wl on 15/11/5.
//  Copyright © 2015年 wl. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, TableHeaderViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setMyBackgroundColor(color:UIColor(red: 200/255.0, green: 200/255.0, blue: 200/255.0, alpha: 0))
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
       
        
        let imageView = UIImageView(frame: CGRect(x:0, y:0, width:self.tableView.bounds.width, height:200))
        imageView.image = #imageLiteral(resourceName: "kobe")
        imageView.contentMode = .scaleAspectFill
        
        let heardView = TableHeaderView(subView: imageView, headerViewSize: CGSize(width: self.tableView.bounds.width, height: 200), maxOffsetY: -300, delegate: self)

        self.tableView.tableHeaderView = heardView
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //self.navigationController?.navigationBar.setMyNaviBarDispear(dispear: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //self.navigationController?.navigationBar.setMyNaviBarDispear(dispear: false)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        
        return 50;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        cell?.textLabel?.text = "test\(indexPath.row)"
        
        return cell!
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let heardView = self.tableView.tableHeaderView as! TableHeaderView
        heardView.layoutHeaderViewWhenScroll(offset:scrollView.contentOffset)
        print("offset = \(scrollView.contentOffset)")
    }
    
}

