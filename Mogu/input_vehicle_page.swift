import SwiftUI

struct InputVehiclePage: View {
    var body: some View {
        NavigationView {
            
            VStack {
                Spacer()
    
                Button(action: {
                    
                }) {
                    Text("Submit")
                        .font(.title2)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                
                Spacer()
            }
            .navigationTitle("Input Vehicle")
        }
    }
}

#Preview {
    InputVehiclePage()
}

