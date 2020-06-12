//
//  PollViewController.swift
//  Covid Pilot
//
//  Created by alopezh on 11/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit
import RxSwift
import Pageboy

class PollViewController: PageboyViewController, PageboyViewControllerDataSource, PageboyViewControllerDelegate {

    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var progressView: UIProgressView!
    
    var pollUseCase: PollUseCase?
    
    private var questions: [Question]?
    private var viewControllers: [UIViewController] = []

    @IBOutlet weak var nextButton: UIButton!
    
    @IBAction func onNext(_ sender: Any) {
        if isLast() {
//            TODO: Save
        } else {
            scrollToPage(.next, animated: true)
        }
    }
    
    @IBAction func onBack(_ sender: Any) {
        if isFirst() {
            navigationController?.popViewController(animated: true)
        } else {
            scrollToPage(.previous, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.dataSource = self
        
        self.isScrollEnabled = false
        
        pollUseCase?.getQuestions().subscribe(
            onNext:{ [weak self] questions in
                self?.load(questions: questions)
            }, onError: {  [weak self] error in
                self?.present(Alert.showAlertOk(title: "Error", message: "Se ha producido un error de conexíon.", buttonTitle: "Aceptar"), animated: true)
        }).disposed(by: disposeBag)

    }
    
    private func load(questions: [Question]?) {
        self.questions = questions
        questions?.forEach {question in
            let vc = RatingViewController()
            vc.question = question
            viewControllers.append(vc)
        }
        self.reloadData()
    }
    
    func next() {
        scrollToPage(.next, animated: true)
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        questions?.count ?? 0
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        nil
    }
    
    func pageboyViewController(_ pageboyViewController: PageboyViewController, didScrollToPageAt index: Int, direction: NavigationDirection,animated: Bool) {
        if viewControllers.count > 0 {
            progressView.progress = Float(index + 1) / Float(viewControllers.count)
        }
        if (isLast()) {
            nextButton.setTitle("Finalizar", for: .normal)
        } else {
            nextButton.setTitle("Siguiente", for: .normal)
        }
       
    }
    
    func pageboyViewController(_ pageboyViewController: PageboyViewController, willScrollToPageAt index: Int, direction: NavigationDirection,animated: Bool) {
    }
    
    func pageboyViewController(_ pageboyViewController: PageboyViewController, didScrollTo position: CGPoint, direction: PageboyViewController.NavigationDirection, animated: Bool) {

    }
    
    func pageboyViewController(_ pageboyViewController: PageboyViewController, didReloadWith currentViewController: UIViewController, currentPageIndex: PageboyViewController.PageIndex) {
        
    }
    
    private func isFirst() -> Bool {
        currentIndex == 0
    }
    
    private func isLast() -> Bool {
        currentIndex == (viewControllers.count - 1)
    }
    

}
