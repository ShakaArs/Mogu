import SwiftUI

struct CardServiceFilled: View {
    var icon: String?
    var iconInput: String
    var buttonText: String
    var backgroundColor: Color
    var textColor: Color
    var frameHeight: CGFloat
    var textSize: CGFloat
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
                RoundedRectangle(cornerRadius: 7)
                    .fill(backgroundColor)
                    .frame(height: frameHeight)
                    .shadow(radius: 10)
                
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        if let icon = icon {
                            Image(systemName: icon)
                                .font(.system(size: 30, weight: .medium))
                        }
                        VStack{
                            Text("Next Change: \(formattedDate(nextChange))")
                                .font(.system(size: textSize * 0.9))
                                .foregroundColor(textColor)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            
                            Text("Last Change: \(formattedDate(lastChange))")
                                .font(.system(size: textSize * 0.8))
                                .foregroundColor(textColor)
                            
                            Text("Range Kilometers: 2500-5000")
                                .font(.system(size: textSize * 0.7))
                                .foregroundColor(textColor)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        }
                        
                        VStack{
                            Image(systemName: iconInput)
                                .font(.system(size: 30, weight: .medium))
                            Text("Update")
                                .font(.system(size: textSize * 0.8))
                        }
                    }
                    .foregroundColor(textColor)
                    
                                    }
                .padding()
            }
        }
        .sheet(isPresented: $showingDatePicker) {
            DatePickerView(serviceType: serviceType, selectedDate: $selectedDate, viewModel: SeviceViewModel())
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
                          iconInput: "calendar",
                          buttonText: "2024-09-19",
                          backgroundColor: .white,
                          textColor: .black,
                          frameHeight: 150,
                          textSize: 15,
                          serviceType: "oil",
                          nextChange: Date(),
                          lastChange: Date().addingTimeInterval(-30 * 24 * 60 * 60)) // Example dates
    }
}
