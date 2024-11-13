//
//  BrowseAllSessions.swift
//  SessionAppIntents
//
//  Created by nate on 11/10/24.
//

import Foundation
import AppIntents

struct BrowseAllSessions: AppIntent {
    static var title: LocalizedStringResource = "Browse All Sessions"
    
    static var description = IntentDescription("Opens the app and let's you browse all the sessions.")
    
    static var openAppWhenRun: Bool = true
    
    @MainActor
    func perform() async throws -> some IntentResult {
        navigationModel.selectedCollection = sessionManager.completeSessionCollection
        return .result()
    }
    
    @Dependency private var navigationModel: NavigationModel
    @Dependency private var sessionManager: SessionDataManager
}
