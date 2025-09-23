//
//  ContentView.swift
//  NameCard
//
//  Created by Harry Ng on 9/8/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        PeopleListView()
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [ContactCategory.self, StoredContact.self], inMemory: true)
}
