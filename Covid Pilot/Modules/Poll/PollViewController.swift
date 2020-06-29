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
    
    var router: AppRouter?
    var pollUseCase: PollUseCase?
    var finishPollVC: FinishPollViewController?
    var nextButtonYOrigin:CGFloat = 0
    
    var poll: Poll?
    private var viewControllers: [UIViewController] = []
    private var currentQuestion: Question?

    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func onNext(_ sender: Any) {
        
        guard let currentQuestion = currentQuestion else {
            fetchPoll()
            return
        }
        
        if currentQuestion.hasResponse() {
            nextConfirmed()
        } else {
            let alert = Alert.showAlertCancelContinue(title:  "No has respondido a una pregunta", message: "", buttonOkTitle: "Continuar sin respuesta", buttonCancelTitle: "Responder") { [weak self] _ in
                self?.nextConfirmed()
            }
            present(alert, animated: true)
        }

    }
    
    @IBAction func onBack(_ sender: Any) {
        if isFirst() {
            navigationController?.popViewController(animated: true)
        } else {
            goToBack()
        }
    }
    
    func nextConfirmed() {
        if isLast() {
            saveQuestions()
        } else {
            goToNext()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        self.dataSource = self
        
        self.isScrollEnabled = false
        
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = 5.0;

        
        //Add observers to move up/down the main view when the keyboard appears/dissapear
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)


    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        fetchPoll()

    }
    
    private func fetchPoll() {
        DispatchQueue.main.async {
            self.view.showLoading()
        }
        pollUseCase?.getPoll().subscribe(
            onNext:{ [weak self] poll in
                DispatchQueue.main.async {
                    self?.view.hideLoading()
                }
                self?.load(poll: poll)
            }, onError: {  [weak self] error in
                DispatchQueue.main.async {
                    self?.view.hideLoading()
                }
                debugPrint(error)
                self?.present(Alert.showAlertOk(title: "Error", message: "Se ha producido un error de conexíon.", buttonTitle: "Aceptar"), animated: true)
        }).disposed(by: disposeBag)
    }
    
    private func load(poll: Poll?) {
        nextButton.titleLabel?.text = "Siguiente"
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
                    strongSelf.router?.route(to: .Home, from: strongSelf)
//                    strongSelf.navigationController?.pushViewController(strongSelf.finishPollVC!, animated: true)
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

    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
           // if keyboard size is not available for some reason, dont do anything
           return
        }
      
      // move the root view up by the distance of keyboard height
        self.nextButtonYOrigin = self.nextButton.frame.origin.y
        self.nextButton.frame.origin.y = self.nextButtonYOrigin - keyboardSize.height
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
      // move back the root view origin to zero
        self.nextButton.frame.origin.y = self.nextButtonYOrigin
    }
}
