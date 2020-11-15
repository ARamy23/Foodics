//
//  MoyaManager.swift
//  camelan
//
//  Created by Ahmed Ramy on 1/30/20.
//  Copyright © 2020 Camelan . All rights reserved.
//
import Moya
import RxSwift
import Alamofire


final class NetworkProvider<Target> where Target: Moya.TargetType {
  private let provider: MoyaProvider<Target>
  
  init(endpointClosure: @escaping MoyaProvider<Target>.EndpointClosure = MoyaProvider.defaultEndpointMapping,
       requestClosure: @escaping MoyaProvider<Target>.RequestClosure = MoyaProvider<Target>.defaultRequestMapping,
       stubClosure: @escaping MoyaProvider<Target>.StubClosure = MoyaProvider.neverStub,
       plugins: [PluginType] = [VerbosePlugin()],
       trackInflights: Bool = false) {
    
    self.provider = MoyaProvider(endpointClosure: endpointClosure,
                                 requestClosure: requestClosure,
                                 stubClosure: stubClosure,
                                 session: Session.default,
                                 plugins: plugins,
                                 trackInflights: trackInflights)
  }
  
  func request(_ token: Target) -> Observable<Moya.Response> {
    return provider.rx.request(token).flatMap { (response) in
      if response.statusCode == 401 {
        return self.refreshSessionToken()
          .do(onSuccess: { [weak self] token in
            // Save token on expire here
          }).flatMap { _ in
            return self.request(token).asSingle()
        }
      } else {
        return Single.just(response)
      }
    }.asObservable().retryExponentially()
  }
  
  private func refreshSessionToken() -> Single<(String)> {
    return Single.create { subscriber in
      // Example
//      let credentials = AuthenticationService.shared.loginCredentials
//      ServiceLocator.network.call(api: AuthEndpoint.login(credentials.email, credentials.password), model: LoginResponse.self, { (results) in
//        switch results {
//        case .success(let response):
//          switch response.status {
//          case 200:
//            subscriber(.success(response.data?.token ?? .empty))
//          default:
//            LoggersManager.error("Failed to Renew token")
//            subscriber(.error(LocalError.genericError))
//          }
//        case .failure(let error):
//          LoggersManager.error("Failed to Renew Token\nError: \(error)")
//          subscriber(.error(error))
//        }
//      })
      
      return Disposables.create()
    }
  }
}

final class CustomServerTrustManager : ServerTrustManager {
  
  override func serverTrustEvaluator(forHost host: String) throws -> ServerTrustEvaluating? {
    return DisabledEvaluator()
  }
  
  public init() {
    super.init(evaluators: [:])
  }
}

final class MoyaManager: NetworkProtocol {
  
  var disposeBag = DisposeBag()
  
  private func handleErrorResponse(_ response: Response) throws {
    
  }
  
  private func reportErrors(_ error: Error) {
    
  }
  
  func removePreviousCall() {
    disposeBag = DisposeBag()
  }
  
  func call<T: Codable, U: Endpoint>(api: U, model: T.Type, _ onFetch: @escaping (Swift.Result<T, Error>) -> Void) {
    let provider = NetworkProvider<U>()
    provider
      .request(api)
      .asObservable()
      .flatMapLatest { response -> Observable<Response> in
        try self.handleErrorResponse(response)
        return Observable.just(response)
    }
    .map(model)
    .subscribe(onNext: { (model) in
      onFetch(.success(model))
    }, onError: { error in
      self.reportErrors(error)
      onFetch(.failure(error))
    }).disposed(by: self.disposeBag)
  }
}
