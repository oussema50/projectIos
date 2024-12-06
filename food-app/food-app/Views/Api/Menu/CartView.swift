import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartManager: CartManager
    
    var body: some View {
        NavigationStack {
            VStack {
                if cartManager.cartItems.isEmpty {
                    Text("Your cart is empty.")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List(cartManager.cartItems) { cartItem in
                        HStack {
                            Image(cartItem.item.imageURL)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                            VStack(alignment: .leading) {
                                Text(cartItem.item.name)
                                    .font(.headline)
                                
                                Text("$\(cartItem.item.price, specifier: "%.2f") x \(cartItem.quantity)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                            
                            Text("$\(Double(cartItem.quantity) * cartItem.item.price, specifier: "%.2f")")
                                .font(.subheadline)
                        }
                    }
                    .listStyle(PlainListStyle())
                    
                    // Total Price and Checkout Button
                    VStack {
                        Text("Total: $\(cartManager.totalPrice, specifier: "%.2f")")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding()
                        
                        Button(action: {
                            // Proceed to Checkout
                        }) {
                            Text("Checkout")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.green)
                                .cornerRadius(10)
                        }
                    }
                }
            }
            .navigationTitle("Your Cart")
            .padding()
        }
    }
}
