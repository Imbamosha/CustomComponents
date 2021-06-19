//
//  FragmentsVC.swift
//  CustomComponents
//
//  Created by Razgildeev Ilya on 13.05.2021.
//

import UIKit

class FragmentsVC: UIViewController {
    
    private weak var segmented: UISegmentedControl!
    private weak var defaultTableView: UITableView!
    private weak var defaultCollectionView: UICollectionView!
    
    private let testArrayTable = ["First","Second","Third"]
    
    private let testArrayCollection = ["1", "2", "3", "4"]
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupSegmenterControl()
        setupTableView()
        setupCollectionView()
    }
}

extension FragmentsVC {
    
    private func setupSegmenterControl() {
        let pickupSegmented = UISegmentedControl(items: ["Таблица", "Коллекция"])
        pickupSegmented.selectedSegmentIndex = 0
        pickupSegmented.addTarget(self, action: #selector(deliveryTypeDidChange), for: .valueChanged)
        
        pickupSegmented.tintColor = UIColor(red: 0.694, green: 0.702, blue: 0.702, alpha: 0.2)
        pickupSegmented.setTitleTextAttributes( [NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        pickupSegmented.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
        
        segmented = pickupSegmented
        
        view.addSubview(segmented)
        
        segmented.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(18)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(36)
            
        }
       
    }
    
    private func setupTableView() {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.isHidden = false
        defaultTableView = tableView
        self.view.addSubview(defaultTableView)
        
        defaultTableView.snp.makeConstraints {
            $0.top.equalTo(segmented.snp.bottom).offset(50)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupCollectionView() {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collection.delegate = self
        collection.dataSource = self
        collection.isHidden = true
        collection.backgroundColor = .white
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        
        defaultCollectionView = collection
        view.addSubview(defaultCollectionView)
        
        defaultCollectionView.snp.makeConstraints {
            $0.top.equalTo(segmented.snp.bottom).offset(50)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    @objc private func deliveryTypeDidChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            defaultTableView.isHidden = false
            defaultCollectionView.isHidden = true
        case 1:
            defaultTableView.isHidden = true
            defaultCollectionView.isHidden = false
        default:
            break
        }
    }
}

extension FragmentsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath as IndexPath)
        
        cell.backgroundColor = UIColor.cyan
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
}

extension FragmentsVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        testArrayTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        cell.backgroundColor = .white
        cell.selectionStyle = .none
        cell.textLabel!.textColor = .black
        cell.textLabel!.text = "\(testArrayTable[indexPath.row])"
        return cell
    }
    
    
}
