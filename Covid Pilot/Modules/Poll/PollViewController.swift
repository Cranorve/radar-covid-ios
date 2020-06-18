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
    var finishPollVC: FinishPollViewController?
    
    private var poll: Poll?
    private var viewControllers: [UIViewController] = []
    private var curretnQuestion: Question?

    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func onNext(_ sender: Any) {
        if isLast() {
            saveQuestions()
        } else {
            goToNext()
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
        
        pollUseCase?.getPoll().subscribe(
            onNext:{ [weak self] poll in
                self?.load(poll: poll)
            }, onError: {  [weak self] error in
                debugPrint(error)
                self?.present(Alert.showAlertOk(title: "Error", message: "Se ha producido un error de conexíon.", buttonTitle: "Aceptar"), animated: true)
        }).disposed(by: disposeBag)

    }
    
    private func load(poll: Poll?) {
        self.poll = poll
        poll?.questions?.forEach {question in
            var vc: QuestionController?
            if question.type == .Rate {
                vc = RatingViewController()
            } else if question.type == .SingleSelect || question.type == .MultiSelect {
                vc = SelectViewController()
            }
            if var vc = vc {
                vc.question = question
                viewControllers.append(vc as! UIViewController)
            }

        }
        self.reloadData()
    }
    
    func next() {
        scrollToPage(.next, animated: true)
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        poll?.questions?.count ?? 0
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        nil
    }
    
    func pageboyViewController(_ pageboyViewController: PageboyViewController, didScrollToPageAt index: Int, direction: NavigationDirection,animated: Bool) {
        load(page: index)
       
    }
    
    func pageboyViewController(_ pageboyViewController: PageboyViewController, willScrollToPageAt index: Int, direction: NavigationDirection,animated: Bool) {
    }
    
    func pageboyViewController(_ pageboyViewController: PageboyViewController, didScrollTo position: CGPoint, direction: PageboyViewController.NavigationDirection, animated: Bool) {

    }
    
    func pageboyViewController(_ pageboyViewController: PageboyViewController, didReloadWith currentViewController: UIViewController, currentPageIndex: PageboyViewController.PageIndex) {
        
    }
    
    private func isFirst() -> Bool {
        (currentIndex ?? 0) == 0
    }
    
    private func isLast() -> Bool {
        (currentIndex ?? 0) == (viewControllers.count - 1)
    }
    
    private func load(page: Int) {
        curretnQuestion = poll?.questions?[page]
        titleLabel.text = curretnQuestion?.question
        if viewControllers.count > 0 {
            progressView.progress = Float((curretnQuestion?.position ?? 0) + 1) / Float(poll?.numRootQuestions ?? 1)
        }
        if (isLast()) {
            nextButton.setTitle("Finalizar", for: .normal)
        } else {
            nextButton.setTitle("Siguiente", for: .normal)
        }
    }
    
    private func saveQuestions() {
        guard let poll = self.poll else {
            return
        }
        pollUseCase?.save(poll: poll).subscribe(
            onNext:{ [weak self] questions in
                if let strongSelf = self {
                    strongSelf.navigationController?.pushViewController(strongSelf.finishPollVC!, animated: true)
                }
            }, onError: {  [weak self] error in
                self?.present(Alert.showAlertOk(title: "Error", message: "Se ha producido un error de conexíon.", buttonTitle: "Aceptar"), animated: true)
        }).disposed(by: disposeBag)
    }
    
    private func goToNext() {
        if let selectedOption = curretnQuestion?.getSelectedOption() {
            if let nextQuestion = selectedOption.next {
                scrollToPage(.at(index: nextQuestion), animated: true)
            } else {
                scrollToPage(.next, animated: true)
            }
        } else {
            scrollToPage(.next, animated: true)
        }
        
    }

}
