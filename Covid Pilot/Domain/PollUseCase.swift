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
    
    private let questionsApi: QuestionnaireControllerAPI
    
    init(questionsApi: QuestionnaireControllerAPI) {
        self.questionsApi = questionsApi
    }
    
    func getQuestions() -> Observable<[Question]> {
        var questions: [Question] = []
        questions.append(Question(
            type: QuestionType.Rate,
            question: "¿Cómo valorarías el funcionamiento de la aplicación?"))
        questions.append(Question(
            type: QuestionType.MultiSelect,
            question: "¿Recibiste una alerta de contagio?"))
        questions.append(Question(
            type: QuestionType.SingleSelect,
            question: "¿Seguiste las recomendaciones sanitarias y de prevención indicadas en la aplicación?"))
        return .just(questions)
    }
    
}
