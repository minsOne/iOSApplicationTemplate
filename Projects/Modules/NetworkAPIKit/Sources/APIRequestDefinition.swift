import Foundation
import Alamofire

public enum APIRequestError: Error {
    case parameterEncodeError
    case connectionError(Error)
    case responseDecodeError(Error)
    case unknownError(URLResponse?)
}

public protocol APIRequestDefinition {
    associatedtype Parameter: Codable
    associatedtype Response: Codable
    
    var baseURL: URL { get }
    var method: HTTPMethod { get }
    var path: String { get }
    
    var parameter: Parameter { get }
    
    func request(completion: (Result<Response, APIRequestError>) -> ())
}

private extension APIRequestDefinition {
    private var urlRequest: URLRequest {
        var baseURL = self.baseURL
        baseURL.appendPathComponent(path)
        var request = URLRequest(url: baseURL)
        request.httpMethod = method.rawValue
        return request
    }
    
    var urlRequestGet: Result<URLRequest, APIRequestError> {
        do {
            let request = try URLEncodedFormParameterEncoder.default.encode(parameter,
                                                                            into: urlRequest)
            return .success(request)
        } catch {
            return .failure(.parameterEncodeError)
        }
    }
    var urlRequestPost: Result<URLRequest, APIRequestError> {
        var urlRequest = self.urlRequest
        
        do {
            let body = try JSONEncoder().encode(parameter)
            urlRequest.httpBody = body
            return .success(urlRequest)
        } catch {
            return .failure(.parameterEncodeError)
        }
    }
}

public extension APIRequestDefinition {
    func request(completion: @escaping (Result<Response, APIRequestError>) -> ()) {
        let urlRequestResult: Result<URLRequest, APIRequestError>
        switch method {
        case .get:
            urlRequestResult = urlRequestGet
        case .post:
            urlRequestResult = urlRequestPost
        }
        
        switch urlRequestResult {
        case let .success(urlRequest):
            dataTask(with: urlRequest, completion: completion)
        case let .failure(error):
            completion(.failure(error))
        }
    }
    
    private func dataTask(with request: URLRequest, completion: @escaping (Result<Response, APIRequestError>) -> ()) {
        let session = URLSession(configuration: .default)
        session.dataTask(with: request, completionHandler: { (data, response, error) in
            switch (data, response, error) {
            case (_, _, let error?):
                completion(.failure(.connectionError(error)))
            case (let data?, _, _):
                do {
                    let decodedResponse = try JSONDecoder().decode(Response.self, from: data)
                    completion(.success(decodedResponse))
                } catch {
                    completion(.failure(.responseDecodeError(error)))
                }
            default:
                completion(.failure(.unknownError(response)))
            }
        })
        .resume()
    }
}

