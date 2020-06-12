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

    @IBAction func onBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            viewControllers.append(RatingViewController())
        }
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
            progressView.progress = Float(index) / Float(viewControllers.count)
        }
    }
    
    func pageboyViewController(_ pageboyViewController: PageboyViewController, willScrollToPageAt index: Int, direction: NavigationDirection,animated: Bool) {
    }
    
    func pageboyViewController(_ pageboyViewController: PageboyViewController, didScrollTo position: CGPoint, direction: PageboyViewController.NavigationDirection, animated: Bool) {

    }
    
    func pageboyViewController(_ pageboyViewController: PageboyViewController, didReloadWith currentViewController: UIViewController, currentPageIndex: PageboyViewController.PageIndex) {
        
    }
    

}
