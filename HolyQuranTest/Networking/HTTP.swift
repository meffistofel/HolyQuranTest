//
//  HTTP.swift
//  DepartmentSwiftUI
//
//  Created by Oleksandr Kovalov on 29.08.2022.
//

import Foundation

enum HTTPMethod: String {
    case get
    case post
    case put
    case patch
    case delete
}

enum HTTPHeadersKey: String {
    case contentType = "Content-Type"
    case authorization = "Authorization"
    case contentDisposition = "Content-Disposition"
    case contentLength = "Content-Length"
    case applicationId = "X-Parse-Application-Id"
    case restApiKey = "X-Parse-REST-API-Key"
}

typealias HTTPCode = Int
typealias HTTPCodes = Range<Int>
typealias HTTPHeaders = [String: String]
typealias Parameters = [String: Any]

extension HTTPCodes {
    static let success = 200 ..< 300
}
