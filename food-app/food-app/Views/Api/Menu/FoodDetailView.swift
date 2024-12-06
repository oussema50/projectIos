// FoodDetailView (to display details of a selected food item)
import SwiftUI

// FoodDetailView (to display details of a selected food item)
struct FoodDetailView: View {
    var menuItem: FoodItem
    var addToCart: (FoodItem) -> Void  // Change this to accept a FoodItem
    
    var body: some View {
        ScrollView {
            VStack {
                Image(menuItem.imageURL)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                
                Text(menuItem.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 10)
                
                Text(menuItem.description)
                    .font(.body)
                    .foregroundColor(.gray)
                    .padding(.top, 5)
                
                Text("$\(menuItem.price, specifier: "%.2f")")
                    .font(.title)
                    .padding(.top, 10)
                
                Button("Add to Cart") {
                    addToCart(menuItem)  // Directly use the FoodItem in the closure
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
        .navigationBarTitle("Food Details", displayMode: .inline)
    }
}
