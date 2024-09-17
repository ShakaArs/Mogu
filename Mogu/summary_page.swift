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
                        destination: ReminderView()
                        
                    )
                    HStack {
                        Text("Components")
                            .padding(.leading)
                            .font(.title2)
                        Spacer()
                    }
                    
                    btnComponent(
                        icon: "star",
                        iconInput: "chevron.right",
                        buttonText: "Set Your Vehicle",
                        backgroundColor: .white,
                        textColor: .black,
                        frameHeight: 105,
                        textSize: 20,
                        destination: ReminderView()
                        
                    )
                    btnComponent(
                        icon: "star",
                        iconInput: "chevron.right",
                        buttonText: "Set Your Vehicle",
                        backgroundColor: .white,
                        textColor: .black,
                        frameHeight: 105,
                        textSize: 20,
                        destination: ReminderView()
                        
                    )
                    btnComponent(
                        icon: "star",
                        iconInput: "chevron.right",
                        buttonText: "Set Your Vehicle",
                        backgroundColor: .white,
                        textColor: .black,
                        frameHeight: 105,
                        textSize: 20,
                        destination: ReminderView()
                        
                    )
                    
                    
                    Spacer()
                }
                .navigationTitle("Summary")
                .navigationBarItems(trailing: Button(action: {
                    print("Button tapped")
                }) {
                    Image(systemName: "book.and.wrench")
                        .font(.title2)
                        .foregroundColor(.green)
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
