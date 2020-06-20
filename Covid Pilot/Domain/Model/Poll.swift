//
//  Poll.swift
//  Covid Pilot
//
//  Created by alopezh on 17/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation

public class Poll {
    var questions: [Question]?
    var numRootQuestions: Int?
    
    func findNext(question: Question, option: QuestionOption?) -> Int? {
        if (question.isChild()) {
            for (i, q) in (questions ?? []).enumerated()  {
                if q.isChild() && q.parent == question.parent && q.childPosition == (question.childPosition ?? 0) + 1 {
                    return i
                }
            }
        }
        if let option = option {
            for (i, q) in (questions ?? []).enumerated()  {
                if q.isChild() && q.parent == question._id  && q.parentOption == option._id {
                    return i
                }
            }
        }
        for (i, q) in (questions ?? []).enumerated()  {
            if (q.position ?? 0) > (question.position ?? 0) && !q.isChild() {
                return i
            }
        }
        return nil
    }
    
    func findLast(question: Question) -> Int? {
        let index = findQuestionIndex(question)
        if (index > 0) {
            if let last = questions?[index-1], last.isChild() {
                if let parent = findParent(last.parent) {
                    if let questionOption = findOption(parent, last.parentOption) {
                        if questionOption.selected ?? false {
                            return index - 1
                        } else {
                            return findQuestionIndex(parent)
                        }
                    }
                }
            }
        }
        
        return nil
    }
    
    private func findParent(_ questionId: Int?) -> Question? {
        for question in questions ?? []{
            if question._id == questionId {
                return question
            }
        }
        return nil
    }
    
    private func findOption(_ question: Question, _ optionId: Int?) -> QuestionOption? {
        for option in question.options ?? [] {
            if (option._id == optionId) {
                return option
            }
        }
        return nil
    }
    
    private func findQuestionIndex(_ question: Question) -> Int {
        for (i, q) in (questions ?? []).enumerated()  {
            if q._id == question._id {
                return i
            }
        }
        return 0
    }
    
    func isLast(question: Question?) -> Bool {
        guard let question = question else {
            return false
        }
        return question.position == numRootQuestions
    }
    
}
