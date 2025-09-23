//
//  NameCardApp.swift
//  NameCard
//
//  Created by Harry Ng on 9/8/25.
//

import SwiftUI
import SwiftData

@main
struct NameCardApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            ContactPerson.self,
            Contact.self
        ])
        
        let modelConfiguration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: false,
            allowsSave: true
        )
        
        do {
            let container = try ModelContainer(for: schema, configurations: [modelConfiguration])
            print("✅ SwiftData ModelContainer 創建成功")
            return container
        } catch {
            print("❌ 無法創建 ModelContainer: \(error)")
            // 如果失敗，嘗試創建一個更簡單的容器
            do {
                let fallbackContainer = try ModelContainer(for: ContactPerson.self, Contact.self)
                print("✅ 使用備用 ModelContainer")
                return fallbackContainer
            } catch {
                fatalError("完全無法創建 ModelContainer: \(error)")
            }
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
