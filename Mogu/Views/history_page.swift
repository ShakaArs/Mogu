//
//  history_page.swift
//  MoGu
//
//  Created by MacBook Air on 18/09/24.
//

import SwiftUI
import SwiftData

//// A struct to store exactly one history's data.
//struct History: Identifiable {
//    let id = UUID()
//    
//}

// A view that shows the data for one History.
struct HistoryRow: View {
    @State var serviceType:String
    @State var lastDate:Date

    var body: some View {
        // Date Formatter to show only Day, Date, Month, Year
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE, d MMMM yyyy" // Day, Date, Month, Year format
                
        let formattedDate = dateFormatter.string(from: lastDate)
        
        return VStack(alignment: .leading) {
            Text(formattedDate)
                .frame(maxWidth: .infinity, alignment: .leading)
                .bold()// Left align service text
            Text("Service: \(serviceType)")
                .frame(maxWidth: .infinity, alignment: .leading)  // Left align service text
            
        }
        .padding(.vertical, 4) // Optional padding to space out the rows
    }
}

struct HistoryView: View {
    @Query var serviceModel: [ServiceModel]
    
    //indikator supaya bisa dilihat View
    @State private var searchText = ""
    
    
    
//    let histories = [
//        History(date:ServiceModel(lastDateService: <#T##Date#>), service: ServiceModel(serviceType: <#T##String#>),
//        History(date: "9 September 2019", service: "Oli"),
//        History(date: "16 August 2019", service: "Ban"),
//        History(date: "4 June 2019", service: "Kampas Rem")
//    ]
    
    // Computed property to filter the items
    var filteredTexts: [ServiceModel] {
        // DateFormatter to convert Date to string for search
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "d MMMM yyyy" // Only date, month, and year for search
                
        // Filter by both serviceType and formatted lastDateService
                let filtered = serviceModel.filter { service in
                    let formattedDate = dateFormatter.string(from: service.lastDateService)
                    
                    // Check if the service type or the formatted date contains the search text
                    return searchText.isEmpty ||
                           service.serviceType.lowercased().contains(searchText.lowercased()) ||
                           formattedDate.lowercased().contains(searchText.lowercased())
                }
                
                // Sort the filtered results by lastDateService in descending order (newest first)
                return filtered.sorted { $0.lastDateService > $1.lastDateService }
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
                    HistoryRow(serviceType: history.serviceType,lastDate: history.lastDateService)
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
