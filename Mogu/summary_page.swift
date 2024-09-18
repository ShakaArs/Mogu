import SwiftUI

struct SummaryView: View {
    @State private var path = NavigationPath()

    var body: some View {
        TabView {
            
            NavigationStack{
                VStack {
                    HStack {
                        Text("Is it")
                            .padding(.leading)
                            .font(.title2)
                        Text("Time")
                            .foregroundColor(.green)
                            .font(.title2)
                        Text("to service ?")
                            .font(.title2)
                        
                        Spacer()
                    }
                    
                    btnComponent(
                        icon: "",
                        iconInput: "chevron.right",
                        buttonText: "Set Your Vehicle",
                        backgroundColor: .green,
                        textColor: .white,
                        frameHeight: 70,
                        textSize: 30,
                        destination: InputVehiclePage()
                        
                    )
                    HStack {
                        Text("Components")
                            .padding(.leading)
                            .font(.title2)
                        Spacer()
                    }
                    
                    btnComponent(
                        icon: "oilcan.fill",
                        iconInput: "chevron.right",
                        buttonText: "Set Your Lates Oil Change",
                        backgroundColor: .white,
                        textColor: .black,
                        frameHeight: 105,
                        textSize: 15,
                        destination: ReminderView()
                        
                    )
                    btnComponent(
                        icon: "circle.circle.fill",
                        iconInput: "chevron.right",
                        buttonText: "Set Your Lates Oil Change",
                        backgroundColor: .white,
                        textColor: .black,
                        frameHeight: 105,
                        textSize: 15,
                        destination: ReminderView()
                        
                    )
                    btnComponent(
                        icon: "pedal.brake.fill",
                        iconInput: "chevron.right",
                        buttonText: "Set Your Lates Brake Change",
                        backgroundColor: .white,
                        textColor: .black,
                        frameHeight: 105,
                        textSize: 15,
                        destination: ReminderView()
                        
                    )
                    
                    
                    Spacer()
                }
                .navigationTitle("Summary")
                .navigationBarItems(trailing: NavigationLink(destination: HistoryView()) {
                                HStack {
                                    Image(systemName: "book.and.wrench")
                                        .padding()
                                        .foregroundColor(.green)
                                        .font(.title2)
                                    
                                }
                            })
                
            }
            .tabItem {
                Image(systemName: "engine.combustion.fill")
                Text("Summary")
            }
            
            
            NavigationView {
                ReminderView()
            }
            .tabItem {
                Image(systemName: "bell")
                Text("Reminder")
            }
        }
    }
}


#Preview {
    SummaryView()
}
