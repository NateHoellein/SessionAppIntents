//
//  SessionAppIntentsApp.swift
//  SessionAppIntents
//
//  Created by nate on 11/10/24.
//
import SwiftUI
import AppIntents
import CoreSpotlight

@main
struct SessionAppIntentsApp: App {
    private var sessionManager: SessionDataManager
    private let sceneNavigationModel: NavigationModel

    init() {
      let sessionDataManager = SessionDataManager.shared
      sessionManager = sessionDataManager

      let navigationModel = NavigationModel.shared
      sceneNavigationModel = navigationModel

      /**
      Register important objects that are required as dependencies of an `AppIntent` or an `EntityQuery`.
      The system automatically sets the value of properties in the intent or entity query to these values when the property is annotated with
      `@Dependency`. Intents that launch the app in the background won't have associated UI scenes, so the app must register these values
      as soon as possible in code paths that don't assume visible UI, such as the `App` initialization.
      */
      AppDependencyManager.shared.add(dependency: sessionDataManager)
      AppDependencyManager.shared.add(dependency: navigationModel)

      /**
      Call `updateAppShortcutParameters` on `AppShortcutsProvider` so that the system updates the App Shortcut phrases with any changes to the app's intent parameters. The app needs to call this function during its launch, in addition to any time the parameter values for the shortcut phrases change.
      */
      SessionShortcuts.updateAppShortcutParameters()

      Task {
        try await CSSearchableIndex
          .default()
          .indexAppEntities(sessionDataManager.sessions.map(SessionEntity.init(session:)))
      }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(sessionManager)
                .environment(sceneNavigationModel)
        }
    }
}
