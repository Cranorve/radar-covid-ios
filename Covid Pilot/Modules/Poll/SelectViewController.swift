//
//  SelectViewController.swift
//  Covid Pilot
//
//  Created by alopezh on 12/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit

class SelectViewController: UIViewController, QuestionController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var question: Question?
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib.init(nibName: "QuestionItemCell", bundle: nil), forCellWithReuseIdentifier: "ITEM")
        }
    }
    
    override func viewDidLoad() {
        if self.question?._id == 16 {
            self.topConstraint.constant = 260
        }
        super.viewDidLoad()
        collectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        question?.options?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let view: QuestionItemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ITEM", for: indexPath) as! QuestionItemCell
        view.questionOption = question?.options?[indexPath.item]
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? QuestionItemCell {
            if (question?.type == .SingleSelect) {
                singleSelect(indexPath.item)
            } else {
                cell.toggleSelected()
            }
           
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = view.frame.size.width - 32

        return CGSize(width: width, height: 60)
    }
    
    private func singleSelect(_ index: Int) {

        for i in 0...((question?.options?.count ?? 0) - 1) {
            question?.options?[i].selected = (index == i)
        }
        collectionView.reloadData()
    }
    

}
