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
    
    private let questionsApi: QuestionnaireControllerAPI
    
    init(questionsApi: QuestionnaireControllerAPI,
        settingsRepository: SettingsRepository) {
        self.questionsApi = questionsApi
        self.settingsRepository = settingsRepository
    }
    
    func getPoll() -> Observable<Poll> {

        questionsApi.getQuestions().map { [weak self] questionsDto in
            let poll = Poll()
            var questions: [Question] = []
            var rootQuestions = 0
            var questionsEdit = questionsDto
            questionsEdit.sort { ($0.order ?? Int.max) < ($1.order ?? Int.max) }
            for questionDto in questionsEdit {
                if let question = self?.map(questionDto: questionDto) {
                    questions.append(question)
                }
                if questionDto.parentId == nil {
                    rootQuestions += 1
                }
            }
            self?.asignOptions(questions, questionsDto)
            poll.questions = questions
            poll.numRootQuestions = rootQuestions
            return poll
        }
    

//
//        var questions: [Question] = []
//        questions.append(Question(
//            type: QuestionType.Rate,
//            question: "¿Cómo valorarías el funcionamiento de la aplicación?",
//            minValue: 1, maxValue: 10)
//        )
//        var question = Question(
//        type: QuestionType.MultiSelect, question: "¿Recibiste una alerta de contagio?", minValue: nil, maxValue: nil)
//        question.options = [QuestionOption(_id: 0, option: "Sí", selected: false), QuestionOption(_id: 0, option: "No", selected: false)]
//        questions.append(question)
//
//        question = Question(
//        type: QuestionType.SingleSelect,
//        question: "¿Seguiste las recomendaciones sanitarias y de prevención indicadas en la aplicación?", minValue: nil, maxValue: nil)
//        question.options = [QuestionOption(_id: 0, option: "Sí", selected: false), QuestionOption(_id: 0, option: "No", selected: false)]
//        questions.append(question)
//
//        return .just(questions)
    }
    
    private func asignOptions(_ questions: [Question], _ questionsDto: [QuestionDto]) {
        for questionDto in questionsDto {
            if let question = findParentQuestion(parentId: questionDto.parentId, questions: questions) {
                for i in 0 ... (question.options?.count ?? 0) - 1 {
                    var option = question.options?[i]
                    if option?._id == questionDto.parentOptionId {
                        option?.next = questionDto.order
                    }
                }
            }
        }
    }
    
    func save(poll: Poll) -> Observable<Poll> {
        .deferred { [weak self] in
            guard let settings = self?.settingsRepository.getSettings() else {
                return .error("Settings not loaded")
            }
            return .just(poll)
        }
    }
    
    private func map(questionDto: QuestionDto) -> Question? {
        let question = Question()
        question._id =  questionDto._id
        question.minValue = questionDto.minValue
        question.maxValue = questionDto.maxValue
        question.question  = questionDto.question
        
        switch questionDto.questionType {
        case .dichotomous:
            question.type = .SingleSelect
        case .multipleChoice:
            question.type = .MultiSelect
        case .checkbox:
            question.type = .SingleSelect
        case .ratingScale:
            question.type = .Rate
        default:
            return nil
        }
        
        question.options = []
        for optionDto in questionDto.options ?? [] {
            var option = QuestionOption()
            option._id = optionDto._id
            option.option = optionDto.option
            question.options?.append(option)
        }
        
        return question
    }
    
    
    private func findParentQuestion(parentId: Int?, questions: [Question]) -> Question? {
        if let parentId = parentId {
            for question in questions {
                if question._id == parentId {
                    return question
                }
            }
        }
        return nil
    }
    
}
