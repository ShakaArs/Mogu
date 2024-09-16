import SwiftUI

struct SummaryView: View {
    var body: some View {
        TabView {
            NavigationView {
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
                    HStack {
                        Button(action: {
                            print("Button tapped")
                        }) {
                            HStack {
                                Text("Set Your Vehicle")
                                    .font(.title2)
                                    .bold()
                                Spacer()
                                Image(systemName: "arrow.right")
                                    .font(.title)
                            }
                            .padding(25)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                        .padding()
                    }
                    
                    HStack {
                        Text("Component")
                            .padding(.leading)
                            .font(.title2)
                        Spacer()
                    }
                    
                    btnComponent(
                        icon: "oilcan.fill",
                        iconInput: "arrow.right",
                        buttonText: "Set your latest oil changes",
                        backgroundColor: .white,
                        textColor: .black,
                        action: {
                            print("Back button tapped")
                        }
                    )
                    btnComponent(
                        icon: "car.2.fill",
                        iconInput: "arrow.right",
                        buttonText: "Set your latest tires changes",
                        backgroundColor: .white,
                        textColor: .black,
                        action: {
                            print("Back button tapped")
                        }
                    )
                    btnComponent(
                        icon: "brakesignal",
                        iconInput: "arrow.right",
                        buttonText: "Set your latest brake changes",
                        backgroundColor: .white,
                        textColor: .black,
                        action: {
                            print("Back button tapped")
                        }
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

struct btnComponent: View {
    var icon: String
    var iconInput: String
    var buttonText: String
    var backgroundColor: Color
    var textColor: Color
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                VStack {
                    HStack {
                        Image(systemName: icon)
                            .font(.title)
                        Text(buttonText)
                            .bold()
                        Spacer()
                        Image(systemName: iconInput)
                            .font(.title)
                    }
                }
                .padding(.top, 30)
                .padding(.bottom, 30)
                .padding()
            }
            .background(backgroundColor)
            .foregroundColor(textColor)
            .cornerRadius(10)
            .shadow(radius: 4)
        }
        .padding(.leading)
        .padding(.trailing)
    }
}

#Preview {
    SummaryView()
}
