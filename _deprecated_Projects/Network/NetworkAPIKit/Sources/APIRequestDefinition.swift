import Foundation
import Alamofire

public enum APIRequestError: Error {
    case baseURLError
    case parameterEncodeError
    case connectionError(Error)
    case responseDecodeError(Error)
    case unknownError(URLResponse?)
    case failResponse
    case invalidBaseURL(URL)
}

public protocol APIRequestDefinition {
    associatedtype BodyParameter: Encodable
    associatedtype Response: Decodable
    
    /// The base URL.
    var baseURL: URL { get }
    /// The HTTP request method.
    var method: HTTPMethod { get }
    /// The path URL component.
    var path: String { get }
    /// The HTTP header fields. In addition to fields defined in this property, `Accept` and `Content-Type`
    /// fields will be added by `dataParser` and `bodyParameters`. If you define `Accept` and `Content-Type`
    /// in this property, the values in this property are preferred.
    var headerFields: [String: String] { get }
    var queryParameters: [String: String]? { get }
    var bodyParameter: BodyParameter? { get }
}

public extension APIRequestDefinition {
    var baseURL: URL {
        return URLComponents(string: "https://api.ambeedata.com").flatMap { try? $0.asURL() }
            ?? URL(string: "https://api.ambeedata.com")!
    }
    var headerFields: [String: String] { [:] }
    var queryParameters: [String: String]? { nil }
    var bodyParameter: BodyParameter? { nil }
    var token: String { "747f32a7c70bb12bd2439fe11c8702f2f8242e0ced994ed9fefd9682b78a2801"
    }
}

private extension APIRequestDefinition {
    var urlRequest: Result<URLRequest, APIRequestError> {
        let url = path.isEmpty ? baseURL : baseURL.appendingPathComponent(path)
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            return .failure(.invalidBaseURL(baseURL))
        }

        var request = URLRequest(url: url)

        if let queryParameters = queryParameters, !queryParameters.isEmpty {
            components.percentEncodedQuery = URLEncodedSerialization.string(from: queryParameters)
        }

        request.url = components.url
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        request.setValue(token, forHTTPHeaderField: "x-api-key")

        return .success(request)
    }

    var urlRequestPost: Result<URLRequest, APIRequestError> {
        do {
            switch urlRequest {
            case .failure: return urlRequest
            case .success(var urlRequest):
                let body = try JSONEncoder().encode(bodyParameter)
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
        case .get: urlRequestResult = urlRequest
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
        #if DEBUG
        dump(urlRequest)
        #endif
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
        return 200..<300 ~= statusCode
    }
}
