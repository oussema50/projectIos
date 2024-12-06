import Foundation

class CartManager: ObservableObject {
    @Published var cartItems: [FoodCartItem] = []
    
    var totalPrice: Double {
        cartItems.reduce(0) { $0 + Double($1.quantity) * $1.item.price }
    }

    // Add item to cart
    func addItemToCart(_ item: FoodCartItem) {
        if let index = cartItems.firstIndex(where: { $0.item.id == item.item.id }) {
            cartItems[index].quantity += item.quantity  // If item exists, increase quantity
        } else {
            cartItems.append(item)  // Otherwise, add a new item
        }
    }

    // Clear cart
    func clearCart() {
        cartItems.removeAll()
    }
}
