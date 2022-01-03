//
//  ForexRequest.swift
//  DailyForex
//
//  Created by Jithin on 01/01/22.
//

import Foundation

struct ForexRequest<Resource: APIResource> {
    let resource: Resource

    init(resource: Resource) {
        self.resource = resource
    }
}
extension ForexRequest: NetworkRequest {

    typealias Model = Forex
    func decode(_ data: Data) -> Forex? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970
        return try? decoder.decode(Forex.self, from: data)
    }

    func execute(withCompletion completion: @escaping (Result<Model?, Error>) -> Void) {
        load(resource: resource, withCompletion: completion)
    }

}
