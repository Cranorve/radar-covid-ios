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
    private var currentQuestion: Question?

    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var indexLabel: UILabel!
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
            goToBack()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.dataSource = self
        
        self.isScrollEnabled = false
        
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = 5.0;
        
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
            } else if question.type == .Text {
                vc = TextViewController()
            }
            if var vc = vc {
                vc.question = question
                viewControllers.append(vc as! UIViewController)
            }

        }
        self.reloadData()
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
        var hasMoreQuestions = false
        if let currentQuestion = self.currentQuestion {
            hasMoreQuestions = ((poll?.findNext(question: currentQuestion, option: currentQuestion.getSelectedOption())) != nil)
        }
        return (poll?.isLast(question: currentQuestion) ?? false) && !hasMoreQuestions
    }
    
    private func load(page: Int) {
        currentQuestion = poll?.questions?[page]
        titleLabel.text = currentQuestion?.question
        if currentQuestion?.position != nil {
            progressView.progress = Float(currentQuestion?.position ?? 0) / Float(poll?.numRootQuestions ?? 1)
            loadPageIndex()
        }
        if poll?.isLast(question: currentQuestion) ?? false {
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
                debugPrint("Error saving poll \(error)")
                self?.present(Alert.showAlertOk(title: "Error", message: "Se ha producido un error de conexíon.", buttonTitle: "Aceptar"), animated: true)
        }).disposed(by: disposeBag)
    }
    
    private func goToNext() {
        if let currentQuestion = self.currentQuestion, let nextQuestion = poll?.findNext(question: currentQuestion, option: currentQuestion.getSelectedOption()) {
                scrollToPage(.at(index: nextQuestion), animated: true)
        } else {
            scrollToPage(.next, animated: true)
        }
    }
    
    private func goToBack() {
        guard let currentQuestion = self.currentQuestion else {
            return
        }
        if let lastQuestion = poll?.findLast(question: currentQuestion) {
            scrollToPage(.at(index: lastQuestion), animated: true)
        } else {
            scrollToPage(.previous, animated: true)
        }
    }
    
    private func loadPageIndex() {
        indexLabel.text = (currentQuestion?.position ?? 0).description + " de " + (poll?.numRootQuestions ?? 0).description
    }

}
