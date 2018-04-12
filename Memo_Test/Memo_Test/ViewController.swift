//
//  ViewController.swift
//  Memo_Test
//
//  Created by Oh Sangho on 2018. 2. 20..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    
    var list = [MemoEntity]()
    
    lazy var df: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .long
        f.timeStyle = .none
        return f
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // 100으로 default 값 설정
        listTableView.estimatedRowHeight = 100
        
        // rowHeight으로 인해 listTableView 값이 유동적일 수 있음.
        listTableView.rowHeight = UITableViewAutomaticDimension
        
         // 단, 이 방법을 사용하기 전에 필수 조건은 스토리보드 상에서 혹은 프로그래밍으로 먼저! 제약조건을 걸어 컴포넌트들의 오토레이아웃을 설정해야 한다. 그리고 위의 heightForRowAt 함수를 오버라이딩 하지 않는다.
        
    }
    
    func fetchMemo() {
        list.removeAll()
        
        let request = NSFetchRequest<MemoEntity>(entityName: "Memo")
        
        let sortByDate = NSSortDescriptor(key: "insertDate", ascending: false)
        let sortByTitle = NSSortDescriptor(key: "title", ascending: true)
        
        request.sortDescriptors = [sortByDate, sortByTitle]
        
        do {
            let list = try context.fetch(request)
            self.list = list
            listTableView.reloadData()
        } catch {
            show(message: error.localizedDescription)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchMemo()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case .some("detailSegue"):
            if let vc = segue.destination as? DetailViewController, let cell = sender as? UITableViewCell, let indexPath = listTableView.indexPath(for: cell) {
                vc.memo = list[indexPath.row]
            }
        default:
            super.prepare(for: segue, sender: sender)
        }
    }
    
    
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MemoTableViewCell.identifier) as! MemoTableViewCell
        
        let target = list[indexPath.row]
        cell.memoTitleLabel.text = target.title
        
        //cell.memoContentLabel.text = target.content
        
        if let content = target.content, content.count > 200 {
            let to = content.index(content.startIndex, offsetBy: 200)
            cell.memoContentLabel.text = "\(content[..<to])..."
        } else {
          cell.memoContentLabel.text = target.content
        }
        
        cell.memoDateLabel.text = df.string(for: target.insertDate)
        
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            let target = list[indexPath.row]
            context.delete(target)
            
            do {
                try context.save()
                
                list.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            } catch {
                show(message: error.localizedDescription)
            }
            
        default:
            break
        }
    }
}


























