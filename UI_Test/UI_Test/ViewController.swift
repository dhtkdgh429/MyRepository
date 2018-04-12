//
//  ViewController.swift
//  Baemin_Test
//
//  Created by Oh Sangho on 2018. 2. 9..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

import UIKit

struct Course {
    let title: String
    let imageName: String
    let startDate: Date
    let endDate: Date
    let tags: [String]
    let location: String
    
}


class ViewController: UIViewController {

    var courseList = [
        
        Course(title: "Swift4를 활용한 iOS 앱 개발 CAMP", imageName: "course0", startDate: Date(), endDate: Date(), tags: ["iOS", "Swift4"], location: "리틀스타 10-A"),
        Course(title: "나만의 iOS 앱 개발 입문 CAMP", imageName: "course1", startDate: Date(), endDate: Date(), tags: ["iOS", "Swift4"], location: "리틀스타 10-A"),
        Course(title: "Unity 5 게임 제작 CAMP", imageName: "course2", startDate: Date(), endDate: Date(), tags: ["iOS", "Swift4"], location: "리틀스타 10-A"),
        Course(title: "JavaScript 정복 프로젝트 CAMP", imageName: "course3", startDate: Date(), endDate: Date(), tags: ["iOS", "Swift4"], location: "리틀스타 10-A"),
        Course(title: "Node.js로 구현하는 쇼핑몰 프로젝트 CAMP", imageName: "course4", startDate: Date(), endDate: Date(), tags: ["iOS", "Swift4"], location: "리틀스타 10-A")
        
    ]
    
    
    
    
    
    @IBOutlet weak var moverWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var center1Constraint: NSLayoutConstraint!
    @IBOutlet weak var center2Constraint: NSLayoutConstraint!
    @IBOutlet weak var center3Constraint: NSLayoutConstraint!
    @IBOutlet weak var center4Constraint: NSLayoutConstraint!
    @IBOutlet weak var center5Constraint: NSLayoutConstraint!
    
    @IBOutlet weak var firstButton: UIButton!
    
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    
    @IBOutlet weak var courseCollectionView: UICollectionView!
    
    
    
    var timer: DispatchSourceTimer?
    
    lazy var df: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "M월 d일(E)"
        return f
    }()
    
    
    
    
    
    // tag로 action 설정
    @IBAction func selectMenu(_ sender: UIButton) {
        
        center1Constraint.isActive = sender.tag == 100
        center2Constraint.isActive = sender.tag == 200
        center3Constraint.isActive = sender.tag == 300
        center4Constraint.isActive = sender.tag == 400
        center5Constraint.isActive = sender.tag == 500
        
        
        // mover 이동 시 메뉴 글씨 크기에 따라 변하도록 설정
        if let title = sender.title(for: .normal), let font = sender.titleLabel?.font {
            let attr = [NSAttributedStringKey.font: font]
            let width = (title as NSString).size(withAttributes: attr).width
            moverWidthConstraint.constant = width
            
        }
        UIView.animate(withDuration: 0.3) {
            [weak self] in self?.view.layoutIfNeeded()
        }
        
        for _ in 0 ..< 10 {
            let a = Int(arc4random_uniform(UInt32(courseList.count)))
            let b = Int(arc4random_uniform(UInt32(courseList.count)))
            courseList.swapAt(a, b)
        }
        
        let section = IndexSet(integer: 0)
        courseCollectionView.reloadSections(section)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case .some("detailSegue"):
            if let vc = segue.destination as? DetailViewController, let cell = sender as? UICollectionViewCell, let indexPath = courseCollectionView.indexPath(for: cell) {
                vc.course = courseList[indexPath.item]
            }
        default:
            super.prepare(for: segue, sender: sender)
        }
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 처음 시작 시 mover 크기를 전체 메뉴 크기로 설정
        selectMenu(firstButton)
     
    }

    // 무한 스크롤 설정
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let targetIndexPath = IndexPath(item: 5000, section: 0)
        bannerCollectionView.selectItem(at: targetIndexPath, animated: false, scrollPosition: .centeredHorizontally)
        
        
        // 타이머 실행
        resumeTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        timer?.suspend()
    }
    
    // 타이머 구현 코드
    func resumeTimer() {
        if timer == nil {
            timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
            timer?.schedule(deadline: .now() + 5, repeating: .seconds(5))
            timer?.setEventHandler(handler: {
                [weak self] in
                if var indexPath = self?.bannerCollectionView.indexPathsForVisibleItems.first {
                    indexPath.item += 1
                    
                    self?.bannerCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
                }
            })
            
            timer?.resume()
        }
    }
    
    
    
    
    
}

// 배너 설정
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case bannerCollectionView:
            return 10000
        case courseCollectionView:
            return courseList.count
        default:
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        switch collectionView {
        case bannerCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.identifier, for: indexPath) as! BannerCollectionViewCell
            
            let imageName = "banner\(indexPath.item % 5)"
            cell.bannerImageView.image = UIImage(named: imageName)
            
            
            return cell
        case courseCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CourseCollectionViewCell.identifier, for: indexPath) as! CourseCollectionViewCell
            
            let course = courseList[indexPath.item]
            print(course)
            cell.courseImageView.image = UIImage(named: course.imageName)
            cell.courseNameLabel.text = course.title
            
            if let start = df.string(for: course.startDate), let end = df.string(for: course.endDate) {
                cell.periodLabel.text = "\(start) ~ \(end)"
            }
            
            cell.tagLabel.text = "#" + course.tags.joined(separator: " #")
            cell.locationLabel.text = course.location
            
            return cell
        default:
            fatalError()
            
        }
        
        
    }
    
}

// 그림 레이아웃에 맞게 설정
extension ViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView {
        case bannerCollectionView:
            return collectionView.frame.size
        case courseCollectionView:
            guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else {
                return CGSize.zero
            }
            
            let width = (collectionView.bounds.width - (layout.sectionInset.left + layout.sectionInset.right + layout.minimumLineSpacing)) / 2
            return CGSize(width: width, height: width * 1.5)
        default:
            return CGSize.zero
            
        }
    }
}










