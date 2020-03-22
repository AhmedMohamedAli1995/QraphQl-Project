//
//  NetworkLayer.swift
//  QraphQlProject
//
//  Created by Ahmed-Ali on 3/22/20.
//  Copyright © 2020 com.megatrustgroup.asli. All rights reserved.
//

import Foundation
import Apollo
enum qraphError: Error {
    case parse(message: String)
    var localizedDescription: String {
        switch self {
        case .parse(let string):
            return string
        }
    }
}
class NetworkLayer {
    private static let apollo: ApolloClient = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = [
            "Authorization": "Bearer \(graphQlToken)"
        ]
        
        let url = URL(string: graphQlEndPoint)!
        
        return ApolloClient(
            networkTransport: HTTPNetworkTransport(
                url: url,
                session: URLSession(configuration: configuration))
        )
        
    }()
    class  func getUser(completion: @escaping ((_ data:String? ,_ error :Error?) -> Void)){
        let graphQuery = GetUserQuery()
        self.apollo.fetch(query:graphQuery) { result in
            switch result {
            case .success(let graphQLResult):
                if let name = graphQLResult.data?.user?.name {
                    completion(name,nil)
                } else if let errors = graphQLResult.errors{
                    // GraphQL errors
                    if  errors.count > 0{
                        completion(nil, qraphError.parse(message: errors[0].localizedDescription))
                    }
                    else{
                         completion(nil, qraphError.parse(message: "cant parse"))
                    }
                }
            case .failure(let error):
                // Network or response format errors
                completion(nil,error)
                print(error)
            }
        }
        
    }
}

