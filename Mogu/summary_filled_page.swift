import SwiftUI

struct SummaryFilledView: View {
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
                    .padding(.horizontal)
                    VStack(alignment : .leading){
                        HStack{
                            Text("Automatic")
                                .foregroundColor(.green)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .font(.title2)
                            Text("Motorcycle")
                                .font(.title2)
                            Spacer()
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                Text("Edit")
                                    .foregroundColor(.black)
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            })
        
                        }
                        .padding(.horizontal)
                        HStack(){
                            Text("012670")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            Text("km")
                                .foregroundColor(.green)
                                .fontWeight(.bold)
                        }
                        .padding(.leading)
                    }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    
                    
                    HStack {
                        Text("Components")
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


// Button Component Struct


#Preview {
    SummaryFilledView()
}
