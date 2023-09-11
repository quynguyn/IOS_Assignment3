//
//  FirebaseServiceProtocol.swift
//  Assignment3
//
//  Created by Trung Nguyen on 10/09/2023.
//

import Foundation
import FirebaseFirestore

protocol FirebaseService {
    associatedtype GetType
    associatedtype CreateType
    associatedtype UpdateType
    
    static func fromFirebaseDocument(_ docSnapshot: DocumentSnapshot) -> GetType?
    
    static func create(
        _ dto: CreateType,
        onSuccess: @escaping () -> Void,
        onError: @escaping (_ error: any Error) -> Void
    )
    
    static func update(
        id: String,
        _ dto: UpdateType,
        onSuccess: @escaping () -> Void,
        onError: @escaping (_ error: any Error) -> Void
    )
    
    static func delete(
        id: String,
        onSuccess: @escaping () -> Void,
        onError: @escaping (_ error: any Error) -> Void
    )

}
