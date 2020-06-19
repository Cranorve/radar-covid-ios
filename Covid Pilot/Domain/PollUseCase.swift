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
    private let answersApi: AnswersControllerAPI
    
    init(questionsApi: QuestionnaireControllerAPI, answersApi: AnswersControllerAPI,
        settingsRepository: SettingsRepository) {
        self.questionsApi = questionsApi
        self.answersApi = answersApi
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
    
    func save(poll: Poll) -> Observable<Bool> {
        .deferred { [weak self] in
            guard let settings = self?.settingsRepository.getSettings() else {
                return .error("Settings not loaded")
            }
            
            //
            var answers: [AnswerOptionDto] = []
            var answer: AnswerOptionDto
            guard let questions = poll.questions else {
                print("Error! al enviar respuestas por q no hay respuestas")
                return .just(false)
            }
            
            for question in questions {
                // TODO switch con el tipo de pregunta
                switch question.type {
                case .SingleSelect:
                    guard let options = question.options else { return .error("No hay opciones para la pregunta de single select") }
                    for option in options {
                        guard let selected = option.selected else { return .error("el booleano de la single select no esta definido")}
                        if (selected) {
                            answer = AnswerOptionDto.init(question: question._id, option: option._id, answer: option.option )
                            answers.append(answer)
                        }
                    }
                case .MultiSelect:
                    guard let options = question.options else { return .error("No hay opciones para la pregunta de single select") }
                    for option in options {
                        guard let selected = option.selected else { return .error("el booleano de la single select no esta definido")}
                        if (selected) {
                            answer = AnswerOptionDto.init(question: question._id, option: option._id, answer: option.option )
                            answers.append(answer)
                        }
                    }
                case .Rate:
                    guard let valuesSelected = question.valuesSelected else { return .error("el rate no tiene valor seleccionado") }
                    if (valuesSelected.count > 0){
                        answer = AnswerOptionDto.init(question: question._id, option: valuesSelected[0] as? Int , answer: valuesSelected[0] as? String)
                        answers.append(answer)
                        
                    }
                // TODO ?? case .some(<#T##QuestionType#>)
                   
                default:
                    return .error("error en envio de respuesta: la pregunta no tiene tipologia")
                }
                
            }
            
            
            //TODO: where is the sEDIAUSERToken ?
            do {
                guard let userToken = settings.udid else { return .error("no se ha podido recuperar el user token")}
                try self?.answersApi.saveQuestions(body: answers, sEDIAUserToken: userToken)
                print("Exito al enviar respuestas")
                return .just(true)
            } catch {
                print("Error! al enviar respuestas")
                return .just(false)
            }
    
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
