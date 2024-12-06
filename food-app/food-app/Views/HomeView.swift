import SwiftUI
import Lottie

struct HomeView: View {
    let foodItems: [FoodItem] = [
        FoodItem(name: "Pizza", description: "Delicious cheese pizza", price: 9.99, imageURL: "pizza"),
        FoodItem(name: "Burger", description: "Juicy beef burger", price: 5.99, imageURL: "burger"),
        FoodItem(name: "Pasta", description: "Creamy pasta with sauce", price: 7.99, imageURL: "pasta"),
        FoodItem(name: "Tacos", description: "French tacos with cheese", price: 7.99, imageURL: "tacos")
    ]
    
    @State private var showFoodDetail = false
    @State private var selectedItem: FoodItem? = nil
    @State private var showCheckout = false
    @StateObject private var cartManager = CartManager()
    @State private var searchText = ""
    @State private var categoryIndex = 0
    
    // Alert state
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    // Lottie Animation State
    @State private var isLottiePlaying = false
    
    var categories = ["All", "Pizza", "Burger", "Pasta", "Tacos"]
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment: .leading) {
                    // Top Bar
                    HStack {
                        Image(systemName: "menu")
                            .resizable()
                            .frame(width: 20, height: 20)
                        
                        Spacer()
                        
                        NavigationLink(destination: CartView().environmentObject(cartManager)) {
                            Image(systemName: "cart")
                                .font(.system(size: 20))
                                .foregroundColor(Color("Color4"))
                        }
                    }
                    .padding(.top, 20)
                    
                    // Title
                    Text("Deliver to")
                        .font(.title)
                        .foregroundColor(Color("mainfont"))
                        .padding(.top, 30)
                    
                    // Search Bar
                    SearchBar(text: $searchText)
                        .padding(.top, 10)
                    
                    // Category Selector
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(0..<categories.count, id: \.self) { index in
                                CategoryButton(title: categories[index], isSelected: index == categoryIndex) {
                                    categoryIndex = index
                                }
                            }
                        }
                        .padding(.top, 20)
                    }
                    
                    // Menu Items Grid
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                            ForEach(filteredFoodItems, id: \.id) { food in
                                NavigationLink(destination: FoodDetailView(menuItem: food, addToCart: addToCart)) {
                                    FoodItemCard(foodItem: food, addToCart: addToCart)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.top, 20)
                    }
                }
                .padding(.horizontal, 20)
                
                // Lottie Animation (added as an overlay)
                if isLottiePlaying {
                    LottieView(animationURL: "checkmark-success", loopMode: .playOnce)  // Assuming you've added the Lottie file
                        .frame(width: 100, height: 100)
                        .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                isLottiePlaying = false  // Hide animation after a brief delay
                            }
                        }
                }
            }
            .navigationTitle("Menu")
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Item Added"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    // Filtered food items based on search and category selection
    var filteredFoodItems: [FoodItem] {
        let filteredByCategory = categoryIndex == 0 ? foodItems : foodItems.filter { $0.name.lowercased().contains(categories[categoryIndex].lowercased()) }
        return filteredByCategory.filter { searchText.isEmpty || $0.name.lowercased().contains(searchText.lowercased()) }
    }
    
    // Add to cart function
    func addToCart(_ food: FoodItem) {
        let cartItem = FoodCartItem(item: food, quantity: 1)
        cartManager.addItemToCart(cartItem)
        alertMessage = "\(food.name) has been added to your cart!"
        showAlert = true
        
        // Play Lottie Animation
        isLottiePlaying = true
        
        // Optional: Automatically navigate to checkout after a short delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            showCheckout = true
        }
    }
}

// Category Button
struct CategoryButton: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Text(title)
                    .font(.title3)
                    .fontWeight(isSelected ? .bold : .regular)
                    .foregroundColor(isSelected ? Color("mainfont") : Color("subfont"))
                
                if isSelected {
                    Capsule()
                        .fill(Color("mainfont"))
                        .frame(width: 30, height: 4)
                }
            }
        }
    }
}

// Food Item Card
struct FoodItemCard: View {
    var foodItem: FoodItem
    var addToCart: (FoodItem) -> Void
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack {
                Image(foodItem.imageURL)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                
                VStack(alignment: .leading) {
                    Text(foodItem.name)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(Color("mainfont"))
                    
                    Text("$\(foodItem.price, specifier: "%.2f")")
                        .font(.subheadline)
                        .foregroundColor(Color("subfont"))
                }
                .padding(.top, 10)
                
                Button(action: {
                    addToCart(foodItem)
                }) {
                    Text("Add to Cart")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.mint]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(10)
                }
                .padding(.top, 10)
            }
            .padding(.horizontal, 15)
            .padding(.bottom, 20)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .shadow(radius: 5)
        }
    }
}


// Lottie View Representable (to use LottieAnimationView in SwiftUI)
struct LottieViewRepresentable: UIViewRepresentable {
    @Binding var animationView: LottieAnimationView
    var animationName: String
    var loopMode: LottieLoopMode
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        animationView = LottieAnimationView(name: animationName)
        animationView.loopMode = loopMode
        animationView.frame = view.bounds
        view.addSubview(animationView)
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}

#Preview {
    HomeView()
}
