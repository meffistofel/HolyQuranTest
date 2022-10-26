//
//  Resource.swift
//  DepartmentSwiftUI
//
//  Created by Oleksandr Kovalov on 29.08.2022.
//

import Foundation

// MARK: - Resource
struct Resource<T: Decodable> {

    // MARK: - Properties

    let route: String
    let v: String

    let httpMethod: HTTPMethod
    let headers: HTTPHeaders

    var urlQueryParameters: Parameters
    var httpBodyParameters: Parameters

    var httpBody: Data?

    // MARK: - Init

    init(
        route: String,
        v: String = "v1",
        httpMethod: HTTPMethod,
        headers: HTTPHeaders = [:],
        urlQueryParameters: Parameters = [:],
        httpBodyParameters: Parameters = [:],
        httpBody: Data? = nil
    ) {
        self.route = route
        self.v = v
        self.httpMethod = httpMethod
        self.headers = headers
        self.urlQueryParameters = urlQueryParameters
        self.httpBodyParameters = httpBodyParameters
        self.httpBody = httpBody
    }

    // MARK: - Methods

    func createRequest() throws -> URLRequest {
        let url = try entriesRequestURL()

        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = getHttpBody()
        return request
    }
}

// MARK: - Private Extension

private extension Resource {

    func entriesRequestURL() throws -> URL {
        let configuration = Configuration()

        guard var urlComponents = URLComponents(string: configuration.apiURL) else {
            throw APIError.invalidURL
        }

        urlComponents.path = "/api/\(v)/\(route)"

        return urlComponents.url!
    }

    func getHttpBody() -> Data? {
        guard let contentType = headers["Content-Type"] else { return nil }
        if (contentType as AnyObject).contains("application/json") {
            return try? JSONSerialization.data(withJSONObject: httpBodyParameters)
        } else if (contentType as AnyObject).contains("application/x-www-form-urlencoded") {
            let bodyString = httpBodyParameters.map { "\($0)=\(String(describing: ($1 as AnyObject).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)))" }.joined(separator: "&")
            return bodyString.data(using: .utf8)
        } else if (contentType as AnyObject).contains("multipart/form-data"), let data = httpBodyParameters["data"] as? [Data], let type = httpBodyParameters["type"] as? MediaType {
            let body = uploadMedia(data: data, mediaType: type)
            return body
        } else {
            return httpBody
        }
    }

    func uploadMedia(data: [Data], mediaType: MediaType) -> Data? {

        switch mediaType {
        case .image:
            let boundary = String(data.hashValue)
            return getMultipartImageData(
                name: "file.jpg",
                filePathKey: "file",
                data: data,
                boundary: boundary,
                mimetype: "image/jpg"
            )
        case .video:
            let boundary = String(data.hashValue)
            return getMultipartImageData(
                name: "myVideo.mov",
                filePathKey: "video",
                data: data,
                boundary: boundary,
                mimetype: "video/mov"
            )
        }
    }

    func getMultipartImageData(name: String, filePathKey: String?, data: [Data], boundary: String, mimetype: String) -> Data? {
        let body = NSMutableData()
        data.enumerated().forEach { index, value in
            body.appendString("--\(boundary)\r\n")
            body.appendString("\(HTTPHeadersKey.contentDisposition.rawValue): form-data; name=\"\(filePathKey!)\"; filename=\"\(index)\(name)\"\r\n")
            body.appendString("\(HTTPHeadersKey.contentType.rawValue): \(mimetype)\r\n\r\n")
            body.append(value)
            body.appendString("\r\n")

        }
        body.appendString("--\(boundary)--\r\n")
        
        return body as Data
    }
}
