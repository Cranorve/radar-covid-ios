//
//  HomeViewModel.swift
//  Covid Pilot
//
//  Created by alopezh on 15/07/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation
import RxSwift

class HomeViewModel {
    
    private let disposeBag = DisposeBag()
    
    var expositionUseCase: ExpositionUseCase?
    var radarStatusUseCase: RadarStatusUseCase?
    var syncUseCase: SyncUseCase?
    var resetDataUseCase: ResetDataUseCase?
    var onBoardingCompletedUseCase: OnboardingCompletedUseCase?
    
    var radarStatus = BehaviorSubject<Bool> (value: true)
    var checkState = BehaviorSubject<Bool> (value: false)
    var errorState = BehaviorSubject<DomainError?> (value: nil)
    var expositionInfo = BehaviorSubject<ExpositionInfo> (value: ExpositionInfo(level: .Healthy))
    var errorMessage = PublishSubject<String>()
    var alertMessage = PublishSubject<String>()
    
    func changeRadarStatus(_ active: Bool) {
        radarStatusUseCase?.changeTracingStatus(active: active).subscribe(
            onNext:{ [weak self] active in
                self?.radarStatus.onNext(active)
            }, onError: {  [weak self] error in
                debugPrint(error)
                self?.radarStatus.onNext(false)
        }).disposed(by: disposeBag)
    }
    
    func checkInitialExposition() {
        expositionUseCase?.getExpositionInfo().subscribe(
            onNext:{ [weak self] exposition in
                self?.checkExpositionLevel(exposition)
            }, onError: { [weak self] error in
                debugPrint(error)
                self?.errorMessage.onNext("ALERT_HOME_EXPOSITION_CONTENT".localized)
        }).disposed(by: disposeBag)
    }
    
    private func checkExpositionLevel(_ exposition: ExpositionInfo?) {
        guard let exposition = exposition else {
            return
        }
        if (exposition.level == .Error) {
            errorState.onNext(exposition.error)
        } else {
            expositionInfo.onNext(exposition)
            errorState.onNext(nil)
        }
    }
    
    func restoreLastStateAndSync() {
        radarStatusUseCase?.restoreLastStateAndSync().subscribe(
            onNext:{ [weak self] isTracingActive in
                self?.radarStatus.onNext(isTracingActive)
            }, onError: { [weak self] error in
                debugPrint(error)
                self?.radarStatus.onNext(false)
        }).disposed(by: disposeBag)
    }
    
    func reset() {
        resetDataUseCase?.reset().subscribe(
            onNext:{ [weak self] expositionInfo in
                debugPrint("Data reseted")
                self?.alertMessage.onNext("ALERT_HOME_RESET_SUCCESS_CONTENT".localized)
            }, onError: { [weak self] error in
                debugPrint(error)
                self?.errorMessage.onNext("ALERT_HOME_RESET_ERROR_CONTENT".localized)
        }).disposed(by: disposeBag)
    }
    
    func checkOnboarding() {
        if onBoardingCompletedUseCase?.isOnBoardingCompleted() ?? false {
            checkState.onNext(false)
        } else {
           checkState.onNext(true)
           self.onBoardingCompletedUseCase?.setOnboarding(completed: true)
           DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
               self?.checkState.onNext(false)
           }
        }
    }
    
}
