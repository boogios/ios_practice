//
//  ViewController.swift
//  practice_ios
//
//  Created by 변상우 on 2022/12/30.
//

import UIKit

class ReminderListViewController: UICollectionViewController {
    
    var dataSource: DataSource! // Use implicitly unwrapped optionals only when you know that the optional will have a value.

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let listLayout = listLayout()
        collectionView.collectionViewLayout = listLayout
        
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistraionHandler) // handler parameter로 변경
        
        dataSource = DataSource(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: String) in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(Reminder.sampleData.map {$0.title}) // Reminder의 title 정보들만 포함
        dataSource.apply(snapshot) // Applying the snapshot reflects the changes in the user interface.
        
        collectionView.dataSource = dataSource // Assign the data source to the collection view.
    }
    
    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguration.showsSeparators = false // 구분선 제거
        listConfiguration.backgroundColor = .clear
        
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }


}

