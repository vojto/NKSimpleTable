//
//  NKSimpleTable.swift
//  Median
//
//  Created by Vojtech Rinik on 28/09/2016.
//  Copyright © 2016 Vojtech Rinik. All rights reserved.
//

import Foundation

class NKSimpleTable<ItemType, ViewType: NSView>: NSScrollView, NSTableViewDataSource, NSTableViewDelegate {
    var build: ((Void) -> (ViewType))!
    var update: ((ViewType, ItemType, Int) -> ())!
    
    var tableView: NSTableView!
    
    var items = [ItemType]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    convenience init() {
        self.init(frame: NSZeroRect)
        
        tableView = NSTableView(frame: NSZeroRect)
        self.documentView = tableView
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.headerView = nil
        tableView.selectionHighlightStyle = .none
        
        let column = NSTableColumn(identifier: "column")
        column.resizingMask = .autoresizingMask
        tableView.addTableColumn(column)
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var view: ViewType? = tableView.make(withIdentifier: "view", owner: self) as! ViewType?
        
        if view == nil {
            view = self.build()
            view?.identifier = "view"
        }
        
        self.update(view!, items[row], row)
        
        return view
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 20
    }
}
