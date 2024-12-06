import SwiftUI

struct CheckoutView: View {
    var cartItems: [FoodCartItem]
    var totalPrice: Double
    var onOrderPlaced: () -> Void // The closure you pass to handle the order placement
    
    @State private var userAddress = ""
    @State private var showLoading = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Checkout")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            // Display cart items again for confirmation
            List(cartItems) { cartItem in
                HStack {
                    AsyncImage(url: URL(string: cartItem.item.imageURL)) { image in
                        image.resizable()
                             .scaledToFit()
                             .frame(width: 50, height: 50)
                    } placeholder: {
                        ProgressView()
                    }
                    
                    VStack(alignment: .leading) {
                        Text(cartItem.item.name)
                            .font(.headline)
                        Text("Quantity: \(cartItem.quantity)")
                            .font(.subheadline)
                    }
                    Spacer()
                    Text("$\(Double(cartItem.quantity) * cartItem.item.price, specifier: "%.2f")")
                }
            }
            
            TextField("Enter your shipping address", text: $userAddress)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                placeOrder()
            }) {
                Text("Place Order")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.mint]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            
            if showLoading {
                ProgressView("Placing your order...")
            }
            
            Spacer()
        }
        .padding()
    }
    
    private func placeOrder() {
        // Show loading spinner while order is being placed
        showLoading = true
        
        // Simulate order placement delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            showLoading = false
            onOrderPlaced() // Call the closure passed from CartView
        }
    }
}
