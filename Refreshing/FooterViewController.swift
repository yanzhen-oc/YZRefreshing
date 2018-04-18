//
//  FooterViewController.swift
//  Refreshing
//
//  Created by yanzhen on 2018/4/18.
//  Copyright © 2018年 yanzhen. All rights reserved.
//

import UIKit

class FooterViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var items = [String]()
    deinit {
        print("FooterViewController -- deinit")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        automaticallyAdjustsScrollViewInsets = false
        for i in 1...8 {
            items.append(i.description + " item")
        }
        
        tableView.yz_footer = FunnyRefreshFooter({ [weak self] in
            DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                for i in 19...25 {
                    self?.items.append(i.description)
                }
                self?.tableView.reloadData()
                self?.tableView.yz_footer?.endRefreshing()
            })
        })
        tableView.yz_footer?.beginRefreshing()
    }

}

extension FooterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = items[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        tableView.yz_header?.endRefreshing()
        if #available(iOS 11.0, *) {
            print(tableView.adjustedContentInset, tableView.contentInset, tableView.contentOffset)
        } else {
            // Fallback on earlier versions
        }
    }
}
