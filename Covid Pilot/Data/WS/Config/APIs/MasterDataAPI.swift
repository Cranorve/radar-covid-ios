//
// MasterDataAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire
import RxSwift


open class MasterDataAPI {
    
    private let clientApi : SwaggerClientAPI
    
    init(clientApi : SwaggerClientAPI) {
        self.clientApi = clientApi;
    }
    
    /**
     Get availables autonomous communities

     - parameter locale: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open func getCcaa(locale: String? = nil, completion: @escaping ((_ data: [KeyValueDto]?,_ error: Error?) -> Void)) {
        getCcaaWithRequestBuilder(locale: locale).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }

    /**
     Get availables autonomous communities
     - parameter locale: (query)  (optional)
     - returns: Observable<[KeyValueDto]>
     */
    open func getCcaa(locale: String? = nil) -> Observable<[KeyValueDto]> {
        return Observable.create { [weak self] observer -> Disposable in
            self?.getCcaa(locale: locale) { data, error in
                if let error = error {
                    observer.on(.error(error))
                } else {
                    observer.on(.next(data!))
                }
                observer.on(.completed)
            }
            return Disposables.create()
        }
    }

    /**
     Get availables autonomous communities
     - GET /masterData/ccaa

     - examples: [{contentType=application/json, example=[ {
  "description" : "description",
  "id" : "id"
}, {
  "description" : "description",
  "id" : "id"
} ]}]
     - parameter locale: (query)  (optional)

     - returns: RequestBuilder<[KeyValueDto]> 
     */
    open func getCcaaWithRequestBuilder(locale: String? = nil) -> RequestBuilder<[KeyValueDto]> {
        let path = "/masterData/ccaa"
        let URLString = clientApi.basePath + path
        let parameters: [String:Any]? = nil
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems([
                        "locale": locale
        ])

        let requestBuilder: RequestBuilder<[KeyValueDto]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Get availables locales

     - parameter locale: (query)  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open func getLocales(locale: String? = nil, completion: @escaping ((_ data: [KeyValueDto]?,_ error: Error?) -> Void)) {
        getLocalesWithRequestBuilder(locale: locale).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }

    /**
     Get availables locales
     - parameter locale: (query)  (optional)
     - returns: Observable<[KeyValueDto]>
     */
    open func getLocales(locale: String? = nil) -> Observable<[KeyValueDto]> {
        return Observable.create { [weak self] observer -> Disposable in
            self?.getLocales(locale: locale) { data, error in
                if let error = error {
                    observer.on(.error(error))
                } else {
                    observer.on(.next(data!))
                }
                observer.on(.completed)
            }
            return Disposables.create()
        }
    }

    /**
     Get availables locales
     - GET /masterData/locales

     - examples: [{contentType=application/json, example=[ {
  "description" : "description",
  "id" : "id"
}, {
  "description" : "description",
  "id" : "id"
} ]}]
     - parameter locale: (query)  (optional)

     - returns: RequestBuilder<[KeyValueDto]> 
     */
    open func getLocalesWithRequestBuilder(locale: String? = nil) -> RequestBuilder<[KeyValueDto]> {
        let path = "/masterData/locales"
        let URLString = clientApi.basePath + path
        let parameters: [String:Any]? = nil
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems([
                        "locale": locale
        ])

        let requestBuilder: RequestBuilder<[KeyValueDto]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

}
