//
//  history_page.swift
//  MoGu
//
//  Created by MacBook Air on 18/09/24.
//

import SwiftUI

// A struct to store exactly one history's data.
struct History: Identifiable {
    let id = UUID()
    let date: String
    let service: String
}

// A view that shows the data for one History.
struct HistoryRow: View {
    var history: History

    var body: some View {
        VStack(alignment: .leading) {
            // Align text to the left within the VStack
            Text("\(history.date)")
                .frame(maxWidth: .infinity, alignment: .leading).bold()  // Left align date text
            Text("Service: \(history.service)")
                .frame(maxWidth: .infinity, alignment: .leading)  // Left align service text
        }
        .padding(.vertical, 4) // Optional padding to space out the rows
    }
}

struct HistoryView: View {
    //indikator supaya bisa dilihat View
    @State private var searchText = ""
    
    let histories = [
        History(date: "27 January 2020", service: "Ban"),
        History(date: "9 September 2019", service: "Oli"),
        History(date: "16 August 2019", service: "Ban"),
        History(date: "4 June 2019", service: "Kampas Rem")
    ]
    
    // Computed property to filter the items
    var filteredTexts: [History] {
        if searchText.isEmpty {
            return histories
        } else {
            return histories.filter { $0.service.lowercased().contains(searchText.lowercased())||$0.date.lowercased().contains(searchText.lowercased())}
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack{
                    // Search Bar
                    TextField("Search Date, Service", text: $searchText)
                        .padding(7)
                        .padding(.leading, 30) // Add padding for the magnifying glass icon
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .overlay(
                            // Magnifying glass on the left
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 10)
                        )
                        .overlay(
                            // X button on the right
                            HStack {
                                Spacer() // Push the button to the right
                                if !searchText.isEmpty {
                                    Button(action: {
                                        searchText = ""
                                    }) {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundColor(.gray)
                                            .padding(.trailing, 10)
                                    }
                                }
                            }
                        )
                        .padding(.horizontal, 10)
                    
                    // Search Button
//                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
//                        Image(systemName: "magnifyingglass")
//                            .padding(.trailing, 10)
//                    })
                }
                
                List(filteredTexts) { history in
                    HistoryRow(history: history)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
//                    Button(action: {print("Back to Summary")}, label: {
//                        Image(systemName: "chevron.left")
//                        Text("Summary")
//                    NavigationLink(destination: SummaryView()) {
//                                            Image(systemName: "chevron.left")
//                                            Text("Summary")
//                    }
                    
                }
                ToolbarItem(placement: .principal) {
                    Text("History").font(.title).bold()
                }
            }
            
        }
    }
}


#Preview {
    HistoryView()
}
