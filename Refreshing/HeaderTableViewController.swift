//
//  HeaderTableViewController.swift
//  Refreshing
//
//  Created by yanzhen on 2018/4/18.
//  Copyright © 2018年 yanzhen. All rights reserved.
//

import UIKit

class HeaderTableViewController: UITableViewController {

    private var items = [String]()
    deinit {
        print("HeaderTableViewController -- deinit")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        for i in 1...18 {
            items.append(i.description + " item")
        }
        
        
        tableView.yz_header = FunnyRefreshHeader({ [weak self] in
            DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                for i in 19...25 {
                    self?.items.insert(i.description, at: 0)
                }
                self?.tableView.reloadData()
                self?.tableView.yz_header?.endRefreshing()
            })
        })

        tableView.yz_header?.beginRefreshing()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = items[indexPath.row]
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.yz_header?.endRefreshing()
        if #available(iOS 11.0, *) {
            print(tableView.adjustedContentInset, tableView.contentInset, tableView.contentOffset)
        } else {
            print(tableView.contentInset, tableView.contentOffset)
        }
    }

}
