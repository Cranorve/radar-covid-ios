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
    
    func getQuestions() -> Observable<[Question]> {

        questionsApi.getQuestions().map { questionsDto in
            var questions: [Question] = []
            var questionsEdit = questionsDto
            questionsEdit.sort { ($0.order ?? 0) < ($1.order ?? 0) }
            for questionDto in questionsEdit {
                let question = Question()
                question._id =  questionDto._id
                question.minValue = questionDto.minValue
                question.maxValue = questionDto.maxValue
                question.question  = questionDto.question
                question.type = QuestionType.init(rawValue: questionDto.questionType ?? 0)
                question.options = []
                for optionDto in questionDto.options ?? [] {
                    var option = QuestionOption()
                    option._id = optionDto._id
                    option.option = optionDto.option
                    question.options?.append(option)
                }
                questions.append(question)
            }
            return questions
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
    
    func saveQuestions(questions: [Question]) -> Observable<[Question]> {
        .deferred { [weak self] in
            guard let settings = self?.settingsRepository.getSettings() else {
                return .error("Settings not loaded")
            }
            return .just(questions)
        }
    }
    
}
