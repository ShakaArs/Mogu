import SwiftUI

struct CardServiceFilled: View {
    var icon: String?
//    var iconInput: String
    var buttonText: String
    var backgroundColor: Color
//    var textColor: Color
//    var frameHeight: CGFloat
//    var textSize: CGFloat
    var serviceType: String
    var nextChange: Date
    var lastChange: Date
    @State private var showingDatePicker = false
    @State private var selectedDate = Date()
    
    var body: some View {
        Button(action: {
            showingDatePicker.toggle()
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(backgroundColor)
                    .frame(height: 125)
                    .shadow(radius: 10)
                
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        VStack{
                            if let icon = icon {
                                Image(systemName: icon)
                                    .font(.system(size: 30, weight: .medium))
                            }
                            Spacer().frame(height: 18)
                            Text(serviceType)
                                .font(.system(size: 15 * 0.9))
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        }
                        VStack{
                            Text("Next Change: \(formattedDate(nextChange))")
                                .font(.system(size: 15))
                                .foregroundColor(.black)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            Spacer().frame(height: 20)
                            Text("Last Change: \(formattedDate(lastChange))")
                                .font(.system(size: 15 * 0.7))
                                .foregroundColor(.gray)
                            
                            Text("Range Kilometers: 2500-5000")
                                .font(.system(size: 15 * 0.7))
                                .foregroundColor(.gray)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        }
                        
                        VStack{
                            Image(systemName: "calendar")
                                .font(.system(size: 30, weight: .medium))
                            Spacer().frame(height: 18)
                            Text("Update")
                                .font(.system(size: 15 * 0.9))
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        }
//                        .foregroundStyle(.green)
                    }
                    .foregroundColor(.black)
                    
                                    }
                .padding()
            }
        }
        .sheet(isPresented: $showingDatePicker) {
            DatePickerView(serviceType: serviceType, selectedDate: $selectedDate, viewModel: ServiceViewModel())
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 3)
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

struct CardServiceFilled_Previews: PreviewProvider {
    static var previews: some View {
        CardServiceFilled(icon: "oilcan.fill",
//                          iconInput: "calendar",
                          buttonText: "2024-09-19",
                          backgroundColor: .white,
//                          textColor: .black,
//                          frameHeight: 150,
//                          textSize: 15,
                          serviceType: "Oil",
                          nextChange: Date(),
                          lastChange: Date().addingTimeInterval(-30 * 24 * 60 * 60)) // Example dates
    }
}
