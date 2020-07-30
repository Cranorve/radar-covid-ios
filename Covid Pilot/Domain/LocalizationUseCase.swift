//
//  LocalizationUseCase.swift
//  Covid Pilot
//
//  Created by alopezh on 09/07/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation
import RxSwift

class LocalizationUseCase: LocalizationSource {
    
    private let textsApi: TextsAPI
    private let localizationRepository: LocalizationRepository
    
    private var _localizationMap: [String : String]?
    
    var localizationMap: [String : String]? {
        get {
            if _localizationMap == nil {
                _localizationMap = localizationRepository.getTexts()
            }
            
            return _localizationMap
        }
    }
    
    init( textsApi: TextsAPI, localizationRepository: LocalizationRepository) {
        self.textsApi = textsApi
        self.localizationRepository = localizationRepository
    }
    
    func loadlocalization() -> Observable<[String : String]?> {
        
        return .deferred { [weak self] in
            let ca = self?.localizationRepository.getCA()
            let locale = self?.localizationRepository.getLocale()
            return self?.textsApi.getTexts(ccaa: ca, locale: locale).map { texts in
                let texts = texts.additionalProperties
                self?._localizationMap = texts
                self?.localizationRepository.setTexts(texts)
                return texts
            }.catchError{ [weak self] error -> Observable<[String : String]?> in
                guard let localization = self?.localizationMap else {
                    throw error
                }
                return .just(localization)
            } ?? .empty()
        }

    }
    
    private func mockService() -> [String : String] {
                
        [
            "ALERT_OK_BUTTON" : "OK",
            "ALERT_ACCEPT_BUTTON": "Aceptar",
            "ALERT_CANCEL_BUTTON": "CANCELAR",
            "ALERT_UPDATE_BUTTON": "ACTUALIZAR",
            "ALERT_UPDATE_TEXT_TITLE": "Actualiza Radar COVID",
            "ALERT_UPDATE_TEXT_CONTENT": "Para poder seguir utilizando Radar COVID es necesario que actualices la aplicación.",
            "ALERT_GENERIC_ERROR_TITLE": "Error",
            "ALERT_GENERIC_ERROR_CONTENT": "Se ha producido un error. Compruebe la conexión",
            "ALERT_POLL_TITLE": "No has respondido a una pregunta",
            "ALERT_POLL_CANCEL_BUTTON": "Responder",
            "ALERT_POLL_OK_BUTTON": "Continuar sin respuesta",
            "ALERT_HOME_RADAR_TITLE": "¿Estas seguro de desactivar Radar COVID?",
            "ALERT_HOME_RADAR_CONTENT": "Si desactivas Radar COVID, la aplicación dejará de registrar contactos. Ayúdanos a cuidarte",
            "ALERT_HOME_RADAR_OK_BUTTON": "Desactivar",
            "ALERT_HOME_RADAR_CANCEL_BUTTON": "Mantener activo",
            "ALERT_HOME_COVID_NOTIFICATION_TITLE": "Notificaciones de exposición a la COVID-19 desactivadas",
            "ALERT_HOME_COVID_NOTIFICATION_OK_BUTTON": "Activar",
            "ALERT_HOME_EXPOSITION_CONTENT": "Error al obtener el estado de exposición",
            "ALERT_HOME_RESET_SUCCESS_CONTENT": "Datos reseteados",
            "ALERT_HOME_RESET_ERROR_CONTENT": "Error resetear datos",
            "ALERT_HOME_RESET_TITLE": "Confirmación",
            "ALERT_HOME_RESET_CONTENT": "¿Confirmas el reseteo?",
            "ALERT_MY_HEALTH_SEND_TITLE": "¿Seguro que no quieres enviar tu diagnóstico?",
            "ALERT_MY_HEALTH_SEND_CONTENT": "Por favor, ayúdanos a cuidar a los demas y evitemos que el Covid-19 se propague.",
            "ALERT_MY_HEALTH_CODE_VALIDATION_CONTENT": "Por favor introduce un código válido de 12 dígitos",
            "ALERT_MY_HEALTH_CODE_ERROR_CONTENT": "Se ha producido un error al enviar diagnóstico",
            "SUPPORT_PHONE": "Teléfono de soporte",
            "FREE_CALL": "LLamada gratuita",
            
            
            
            "HOME_EXPOSITION_TITLE_HIGH": "Exposición alta",
            "HOME_EXPOSITION_TITLE_LOW": "Exposición baja",
            "HOME_EXPOSITION_TITLE_POSITIVE": "COVID-19 Positivo",
            "HOME_RADAR_TITLE_ACTIVE": "Radar COVID activo",
            "HOME_RADAR_CONTENT_ACTIVE": "Las interacciones con móviles cercanos se registarán siempre anónimamente. ",
            "HOME_RADAR_TITLE_INACTIVE": "Radar COVID inactivo",
            "HOME_RADAR_CONTENT_INACTIVE": "Por favor, activa esta opción para que la aplicación funcione.",
            "HOME_EXPOSITION_MESSAGE_HIGH": "<b>Has estado en contacto con una persona contagiada de COVID-19.\nInfórmalo en el %@ (gratuito)</b>. <br>Recuerda que esta aplicación es un piloto y sus alertas son simuladas",
            "HOME_EXPOSITION_MESSAGE_LOW": "<b>Te informaremos en el caso de un posible contacto de riesgo.</b><br>Recuerda que esta aplicación es un piloto y sus alertas son simuladas.",
            "HOME_EXPOSITION_MESSAGE_INFECTED": "<b>Tu diagnóstico ha sido enviado.<br>Por favor, aíslate durante 14 días</b>.<br> Recuerda que esta aplicación es un piloto y sus alertas son simuladas",
            "HOME_NOTIFICATION_INACTIVE_MESSAGE": "Notificaciones de exposición a la COVID-19 DESACTIVADAS",
            "HOME_BUTTON_SEND_POSITIVE": "Comunica tu positivo COVID-19",
            "MY_HEALTH_TITLE": "Envía tu diagnóstico <br> COVID positivo",
            "MY_HEALTH_PARAGRAPH_1": "Enviando tu diagnóstico anónimo COVID-19, estás contribuyendo a detener la propagación del virus. ",
            "MY_HEALTH_PARAGRAPH_2": "<b>Gracias por ayudarnos a cuidar a los demás.</b>",
            "MY_HEALTH_PARAGRAPH_3": "<b>Tu información está segura y será tratada siempre anónimamente.</b>",
            "MY_HEALTH_DIAGNOSTIC_CODE_TITLE": "<b>Código de diagnóstico</b>",
            "MY_HEALTH_DIAGNOSTIC_CODE_CONTENT": "Introduce el código que te han enviado",
            "MY_HEALTH_DIAGNOSTIC_CODE_EXAMPLE": "ej. 123456789123",
            "MY_HEALTH_DIAGNOSTIC_CODE_SEND_BUTTON": "Enviar diagnóstico anónimo",
            "MY_HEALTH_REPORTED_TITLE": "<b>Gracias por contribuir a parar el virus</b>",
            "MY_HEALTH_REPORTED_SUBTITLE": "<b>Tu diagnóstico nos ayudará a proteger a los demás</b>",
            "MY_HEALTH_REPORTED_PARAGRAPH_1": "Sin revelar tu identidad en ningún momento, vamos a rastrear qué móviles han estado cerca de ti en los últimos días y les enviaremos una alerta para su seguridad.",
            "MY_HEALTH_REPORTED_BULLET_TITLE": "<b>Sigue las siguientes recomendaciones y los consejos de tu centro de salud:</b>",
            "MY_HEALTH_REPORTED_BULLET_1": "Permanece en casa, preferentemente en tu habitación y no compartas el baño",
            "MY_HEALTH_REPORTED_BULLET_2": "Evita el contacto con otras personas ",
            "MY_HEALTH_REPORTED_BULLET_3": "Usa siempre mascarilla quirúrgica",
            "MY_HEALTH_REPORTED_BULLET_4": "Lávate las manos frecuentemente",
            "MY_HEALTH_REPORTED_BULLET_5": "Ante la aparición de algún síntoma (fiebre, tos, dificultad respiratoria) llama a tu centro de salud",
            "MY_HEALTH_REPORTED_BULLET_6": "Si los síntomas empeoran llama al 112",
            "MORE_INFO": "<b>Más información</b>",
            "THANKS": "<b>Gracias por seguir cuidándote y cuidando a los demás.</b>",
            "MY_DATA_TOP_PLACEHOLDER": "Mis Datos",
            "MY_DATA_TITLE": "Tu privacidad es lo más importante",
            "MY_DATA_BULLET_1": "<b>NO</b> recogemos ningún dato pesonal (nombre, dirección, edad, teléfono, correo electrónico...)",
            "MY_DATA_BULLET_2": "<b>NO</b> recogemos ningún dato de geolocalización, incluidos los datos del GPS ",
            "MY_DATA_BULLET_3": "Por tanto: <br><b>NO</b> podemos determinar tu identidad ni saber las personas con las que has estado",
            "MY_DATA_PARAGRAPH_1": "Los datos son guardados en tu teléfono y la conexión con el servidor están encriptados",
            "MY_DATA_PRIVACY": "Consulta la <b><u>política de privacidad</u></b>",
            "MY_DATA_TERMS": "Consulta las <b><u>condiciones de uso</u></b>",
            "HELP_LINE_TITLE": "Ayúdanos a mejorar",
            "HELP_LINE_PARAGRAPH_1": "Muchas gracias por participar en el piloto de la APP Radar COVID <b>contándonos tu opinión de forma anónima nos ayuda a mejorar</b> y contribuir a prevenir futuros contagios.",
            "HELP_LINE_POLL_BUTTON": "Cuéntanos tu experiencia",
            "HELP_LINE_PHONE_TITLE": "Atención Telefónica",
            "HELP_LINE_PHONE_PARAGRAPH_1": "Contacta con nosotros <b>si tu riesgo de exposición en la aplicación es alto</b> o si tienes cualquier <b>incidencia</b> sobre la aplicación.",
            "HELP_LINE_ONE_MORE_STEP": "<b>Un paso más</b><br>¿Te interesaría participar en una entrevista telefónica para conocer más sobre tu experiencia con Radar COVID? Escribe a:<br><b><u>piloto.appcovid@economia.gob.es</u></b><br><br>Nos pondremos en contacto contigo para fijar el día y la hora que se adapte mejor a ti.",
            "POLL_TELL_YOUR_EXPERIENCE": "Cuéntanos tu experiencia",
            "POLL_EXCELENT": "Excelente",
            "POLL_BAD": "Muy Mala",
            "POLL_NEXT_BUTON": "Siguiente",
            "POLL_END_BUTON": "Finalizar",
            "POLL_TEXTAREA_PLACEHOLDER": "Describir...",
            "EXPOSITION_HIGH_TITLE_1": "Riesgo Alto",
            "EXPOSITION_HIGH_TITLE_2": "Tu exposición es alta",
            "EXPOSITION_HIGH_DESCRIPTION": "Podrías estar infectado desde hace <br> <b>%@ días</b> (actualizado %@)",
            "EXPOSITION_HIGH_WHAT_TO_DO_TITLE": "<b>¿Qué debo hacer?</b>",
            "EXPOSITION_HIGH_WHAT_TO_DO_DESCRIPTION": "Por favor, aíslate durante 14 días y llama al siguiente teléfono",
            "EXPOSITION_HIGH_BULLET_TITLE": "<b>Presta atención a la aparición de cualquiera de los siguientes síntomas:</b>",
            "EXPOSITION_HIGH_BULLET_1": "Tos persistente",
            "EXPOSITION_HIGH_BULLET_2": "Fiebre alta continua",
            "EXPOSITION_HIGH_BULLET_3": "Perdida del gusto y el olfato",
            "EXPOSITION_HIGH_RECOMENDATIONS_BULLET_TITLE": "<b>Sigue las siguientes recomendaciones y los consejos de tu centro de salud:</b>",
            "EXPOSITION_HIGH_RECOMENDATIONS_BULLET_1": "Permanece en casa, preferentemente en tu habitación y no compartas el baño",
            "EXPOSITION_HIGH_RECOMENDATIONS_BULLET_2": "Evita el contacto con otras personas ",
            "EXPOSITION_HIGH_RECOMENDATIONS_BULLET_3": "Usa siempre mascarilla quirúrgica",
            "EXPOSITION_HIGH_RECOMENDATIONS_BULLET_4": "Lávate las manos frecuentemente",
            
            "EXPOSITION_EXPOSED_TITLE_1": "DIAGNÓSTICO COMUNICADO",
            "EXPOSITION_EXPOSED_TITLE_2": "COVID-19 positivo",
            "EXPOSITION_EXPOSED_DESCRIPTION": "Tu diagnóstico fue enviado hace<br><b>%@ días</b> (actualizado %@)",
            "EXPOSITION_EXPOSED_PARAGRAPH_1": "<b>Tu diagnostico nos ayuda a proteger a los demás.</b><br>Sin revelar tu identidad en ningún momento, hemos comunicado tu diagnóstico a móviles han estado cerca de ti en los últimos días y les enviaremos una alerta para su seguridad.",
            
            "EXPOSITION_EXPOSED_WHAT_TO_DO_TITLE": "<b>¿Qué debo hacer?</b>",
            "EXPOSITION_EXPOSED_WHAT_TO_DO_DESCRIPTION": "Por favor, aíslate durante 14 días",
            "EXPOSITION_EXPOSED_RECOMENDATIONS_BULLET_TITLE": "<b>Sigue las siguientes recomendaciones y los consejos de tu centro de salud:</b>",
            "EXPOSITION_EXPOSED_RECOMENDATIONS_BULLET_1": "Permanece en casa, preferentemente en tu habitación y no compartas el baño",
            "EXPOSITION_EXPOSED_RECOMENDATIONS_BULLET_2": "Evita el contacto con otras personas ",
            "EXPOSITION_EXPOSED_RECOMENDATIONS_BULLET_3": "Usa siempre mascarilla quirúrgica",
            "EXPOSITION_EXPOSED_RECOMENDATIONS_BULLET_4": "Lávate las manos frecuentemente",
            "EXPOSITION_EXPOSED_RECOMENDATIONS_BULLET_5": "Ante la aparición de algún síntoma (fiebre, tos, dificultad respiratoria) llama a tu centro de salud ",
            "EXPOSITION_EXPOSED_RECOMENDATIONS_BULLET_6": "Si los síntomas empeoran llama al 112",
            
            
            "EXPOSITION_LOW_TITLE_1": "Riesgo Bajo",
            "EXPOSITION_LOW_TITLE_2": "Tu exposición es baja",
            "EXPOSITION_LOW_DESCRIPTION": "Sin contactos de riesgo aparentes.<br>(actualizado %@)",
            "EXPOSITION_LOW_WHAT_TO_DO_TITLE": "<b>¿Qué debo hacer?</b>",
            "EXPOSITION_LOW_WHAT_TO_DO_DESCRIPTION": "Manten las medidas de seguridad y distanciamiento social.",
            "EXPOSITION_LOW_BULLET_1": "Mantén la distancia de seguridad de 1,5 metros  ",
            "EXPOSITION_LOW_BULLET_2": "Usa siempre mascarilla quirúrgica",
            "EXPOSITION_LOW_BULLET_3": "Lávate las manos frecuentemente",
            "EXPOSITION_LOW_BULLET_4": "Al toser o estornudar, tapate la boca o la nariz y usa pañuelos desechables o la parte interior del codo",
            "EXPOSITION_LOW_BULLET_5": "Respeta las normas particulares en tu territorio sobre aforos y actividades permitidas",
            "EXPOSITION_LOW_BULLET_6": "Ante la aparición de algún síntoma (fiebre, tos, dificultad respiratoria) llama a tu centro de salud ",
            
        ]
       

    }
    
}
