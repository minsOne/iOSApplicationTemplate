import Foundation
import Alamofire

public enum APIRequestError: Error {
    case baseURLError
    case parameterEncodeError
    case connectionError(Error)
    case responseDecodeError(Error)
    case unknownError(URLResponse?)
    case failResponse
}

public protocol APIRequestDefinition {
    associatedtype Parameter: Codable
    associatedtype Response: Decodable
    
    var baseURL: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    
    var parameter: Parameter { get }
}

private extension APIRequestDefinition {
    var urlRequest: Result<URLRequest, APIRequestError> {
        guard
            var url = URL(string: baseURL)
        else { return .failure(.baseURLError) }

        url.appendPathComponent(path)
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return .success(request)
    }
    var urlRequestGet: Result<URLRequest, APIRequestError> {
        do {
            switch urlRequest {
            case .failure: return urlRequest
            case .success(let urlRequest):
                let request = try URLEncodedFormParameterEncoder.default.encode(parameter,
                                                                                into: urlRequest)
                return .success(request)
            }
        } catch {
            return .failure(.parameterEncodeError)
        }
    }
    var urlRequestPost: Result<URLRequest, APIRequestError> {
        do {
            switch urlRequest {
            case .failure: return urlRequest
            case .success(var urlRequest):
                let body = try JSONEncoder().encode(parameter)
                urlRequest.httpBody = body
                return .success(urlRequest)
            }
        } catch {
            return .failure(.parameterEncodeError)
        }
    }
}

public extension APIRequestDefinition {
    func request(completion: @escaping (Result<Response, APIRequestError>) -> ()) {
        let urlRequestResult: Result<URLRequest, APIRequestError>
        switch method {
        case .get: urlRequestResult = urlRequestGet
        case .post: urlRequestResult = urlRequestPost
        }
        
        switch urlRequestResult {
        case let .success(urlRequest):
            dataTask(with: urlRequest, completion: completion)
        case let .failure(error):
            completion(.failure(error))
        }
    }
    
    private func dataTask<T: Decodable>(with request: URLRequest, completion: @escaping (Result<T, APIRequestError>) -> ()) {
        let session = URLSession(configuration: .default)

        session.dataTask(with: request, completionHandler: { (data, response, error) in
            switch (data, response, error) {
            case (_, _, let error?):
                completion(.failure(.connectionError(error)))
            case (_, let urlResponse as HTTPURLResponse, _) where urlResponse.isSuccess == false:
                completion(.failure(.failResponse))
            case (let data?, _, _):
                do {
                    let decodedResponse = try JSONDecoder().decode(T.self, from: data)
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

private extension HTTPURLResponse {
    var isSuccess: Bool {
        return statusCode == 200
    }
}
