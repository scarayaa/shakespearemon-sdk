//
//  HTTPResponseProtocol.swift
//  shakespearemon-sdk
//
//  Created by Fabrizio Scarano on 06/05/25.
//

import Foundation.NSData
import RealHTTP

protocol HTTPResponseProtocol {
    var error: HTTPError? { get }
    
    var data: Data? { get }
}
