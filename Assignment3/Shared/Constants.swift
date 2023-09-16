//
//  Constants.swift
//  Assignment3
//
//  Created by Trung Nguyen on 10/09/2023.
//

import Foundation
import SwiftUI
import SimpleToast

let FOODS_COLLECTION_PATH = "foods"

let FOOD_ORDERS_COLLECTION_PATH = "foodOrders"

let USERS_COLLECTION_PATH = "users"

let DEFAULT_TOAST_OPTIONS = SimpleToastOptions(
    alignment: .top,
    hideAfter: 2,
    backdrop: Color.black.opacity(0.5),
    animation: .default,
    modifierType: .slide,
    dismissOnTap: true
)

let ERROR_TOAST_OPTIONS = SimpleToastOptions(
    alignment: .top,
    hideAfter: 2,
    animation: .default,
    modifierType: .slide,
    dismissOnTap: true
)

let SUCCESS_TOAST_OPTIONS = SimpleToastOptions(
    alignment: .top,
    hideAfter: 2,
    backdrop: Color.green.opacity(0.5),
    animation: .default,
    modifierType: .slide,
    dismissOnTap: true
)


