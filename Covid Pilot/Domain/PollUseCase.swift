//
//  PollUseCase.swift
//  Covid Pilot
//
//  Created by alopezh on 12/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation
import RxSwift

class PollUseCase {
    
    private let settingsRepository: SettingsRepository
    private let preferencesRepository: PreferencesRepository
    
    private let questionsApi: QuestionnaireControllerAPI
    private let answersApi: AnswersControllerAPI
    
    init(questionsApi: QuestionnaireControllerAPI, answersApi: AnswersControllerAPI,
        settingsRepository: SettingsRepository, preferencesRepository: PreferencesRepository) {
        self.questionsApi = questionsApi
        self.answersApi = answersApi
        self.settingsRepository = settingsRepository
        self.preferencesRepository = preferencesRepository
    }
    
    func getPoll() -> Observable<Poll> {

        questionsApi.getQuestions().map { [weak self] questionsDto in
            let poll = Poll()
            var questions: [Question] = []
            var rootQuestions = 0
            for questionDto in questionsDto {
                if let question = self?.map(questionDto,questionsDto) {
                    questions.append(question)
                }
                if questionDto.parentId == nil {
                    rootQuestions += 1
                }
            }
            questions.sort {(self?.getOrder($0) ?? Int.max) < (self?.getOrder($1) ?? Int.max) }
            poll.questions = questions
            poll.numRootQuestions = rootQuestions
            return poll
        }
    
    }
    
    private func getOrder(_ question: Question) -> Int {
        (question.position ?? 0) * 1000 + (question.childPosition ?? 0)
    }
    
    private func map(_ questionDto: QuestionDto, _ questions: [QuestionDto]) -> Question? {
        let question = Question()
        question._id =  questionDto._id
        question.minValue = questionDto.minValue
        question.maxValue = questionDto.maxValue
        question.question  = questionDto.question
        question.parentOption = questionDto.parentOptionId
        if let parentQuestion = findParentQuestion(questionDto.parentId, questions) {
            question.parent = parentQuestion._id
            question.position = parentQuestion.order
            question.childPosition = questionDto.order
        } else {
            question.position = questionDto.order
        }
    
        
        switch questionDto.questionType {
        case .dichotomous:
            question.type = .SingleSelect
        case .multipleChoice:
            question.type = .MultiSelect
        case .checkbox:
            question.type = .SingleSelect
        case .ratingScale:
            question.type = .Rate
        case .openEndedNumber:
            question.type = .Rate
        case .openEndedText:
            question.type = .Text
        case .none:
            question.type = .Text
        }
        
        question.options = []
        for optionDto in questionDto.options ?? [] {
            let option = QuestionOption()
            option._id = optionDto._id
            option.option = optionDto.option
            question.options?.append(option)
        }
        
        return question
    }
    
    private func findParentQuestion(_ parentId: Int?, _ questions: [QuestionDto]) -> QuestionDto? {
        if let parentId = parentId {
            for question in questions {
                if question._id == parentId {
                    return question
                }
            }
        }
        return nil
    }
    
    
    func save(poll: Poll) -> Observable<Poll> {
        .deferred { [weak self] in
            
            guard let udid = self?.settingsRepository.getSettings()?.udid else {
                return .error("UDID not found")
            }
            
            var answers: [AnswerOptionDto] = []
            
            for question in poll.questions ?? [] {
                answers.append(contentsOf: self?.questionToAnswers(question) ?? [])
            }
            
            return self?.answersApi.saveQuestions(body: answers, sEDIAUserToken: udid).map {
                self?.preferencesRepository.setPoll(completed: true)
                return poll
            } ?? .empty()
    
        }
    }
    
    private func questionToAnswers(_ question: Question) -> [AnswerOptionDto] {

        var answers: [AnswerOptionDto] = []
        
        if let type = question.type {
            switch type {
                case .SingleSelect, .MultiSelect :
                    for option in question.options ?? [] {
                        if option.selected ?? false {
                            answers.append(AnswerOptionDto.init(question: question._id, option: option._id, answer: option.option ))
                        }
                    }
                case .Rate:
                    for rate in question.valuesSelected ?? [] {
                        answers.append(AnswerOptionDto.init(question: question._id, option: question._id , answer: (rate as? String?) ?? "" ))
                    }
                    
                case .Text:
                    debugPrint("Text temporalmente deshabilitado")
//                    for text in question.valuesSelected ?? [] {
//                        answers.append(AnswerOptionDto.init(question: question._id, option: 0 , answer: (text as? String?) ?? "" ))
//                    }
            }
        }

        return answers
        
    }
    
}
