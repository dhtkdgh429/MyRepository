//
//  DetailViewController.swift
//  Baemin_Test
//
//  Created by Oh Sangho on 2018. 2. 14..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var course: Course?
    
    lazy var df: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "M월 d일(E)"
        return f
    }()
    
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var headerBackgroundView: UIView!
    
    @IBOutlet weak var blackBackButton: UIButton!
    
    @IBOutlet weak var whiteBackButton: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var listTableView: UITableView!
    
    @IBAction func moveToBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        
    }
    
    var whiteMode = false
    
    var barStyle = UIStatusBarStyle.lightContent
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return barStyle
    }
    
    @IBOutlet weak var floatingMenuTopConstraint: NSLayoutConstraint!
    var floatingMenuBase: CGFloat = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print(course)
        
        headerBackgroundView.alpha = 0
        blackBackButton.alpha = 0
        whiteBackButton.alpha = 1
        titleLabel.alpha = 0
        
        titleLabel.text = course?.title
        
        listTableView.contentInset = UIEdgeInsets(top: imageHeightConstraint.constant - headerView.bounds.height, left: 0, bottom: 0, right: 0)
        listTableView.scrollIndicatorInsets = listTableView.contentInset
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if floatingMenuBase == 0.0 {
            let ip = IndexPath(row: 1, section: 0)
            if let cell = listTableView.cellForRow(at: ip) {
                let frame = view.convert(cell.frame, to: view)
                floatingMenuBase = frame.origin.y + listTableView.contentInset.top
                floatingMenuTopConstraint.constant = floatingMenuBase
                
            }
            
        }
        
        
    }
    
    
    
    
}

extension DetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        
        let diff = y + 200
        
        floatingMenuTopConstraint.constant = floatingMenuBase - diff
        
        if y < -200 {
            imageHeightConstraint.constant = 300 + abs(diff)
        } else {
            imageHeightConstraint.constant = 300
        }
        
        if y >= 0 {
            if !whiteMode {
                whiteMode = true
                
                UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.beginFromCurrentState, animations: {
                    [weak self] in
                    self?.headerBackgroundView.alpha = 1.0
                    self?.blackBackButton.alpha = 1.0
                    self?.whiteBackButton.alpha = 0.0
                    self?.titleLabel.alpha = 1.0
                    }, completion: nil)
                
                barStyle = .default
                setNeedsStatusBarAppearanceUpdate()
                
            }
            
        } else {
            if whiteMode {
                whiteMode = false
                
                UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.beginFromCurrentState, animations: {
                    [weak self] in
                    self?.headerBackgroundView.alpha = 0.0
                    self?.blackBackButton.alpha = 0.0
                    self?.whiteBackButton.alpha = 1.0
                    self?.titleLabel.alpha = 0.0
                    }, completion: nil)
                
                barStyle = .lightContent
                setNeedsStatusBarAppearanceUpdate()
            }
        }
    }
}



extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: CourseSummaryTableViewCell.identifier) as! CourseSummaryTableViewCell
            
            cell.nameLabel.text = course?.title
            
            if let start = df.string(for: course?.startDate), let end = df.string(for: course?.endDate) {
                cell.periodLabel.text = "\(start) ~ \(end)"
            }
            cell.timeLabel.text = "월요일, 수요일 19:30 ~ 22:30"
            cell.preparationLabel.text = "xcode 9이 설치된 Mac"
            cell.locationLabel.text = course?.location
            
            return cell
            
        default:
            return tableView.dequeueReusableCell(withIdentifier: "dummy")!
        }
        
    }
    
}



extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 1:
            return 40
        case 2:
            return 1000
        default:
            return UITableViewAutomaticDimension
        }
    }
}























