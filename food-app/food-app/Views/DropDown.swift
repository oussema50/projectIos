//
//  DropDown.swift
//  food-app
//
//  Created by Tekup-mac-2 on 28/11/2024.
//


import SwiftUI

struct DropDown: View {
    @State var expand = false
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 10){
                HStack{
                    Text("Select Area")
                        .foregroundColor(Color("subfont"))
                    
                    Image(systemName: expand ? "chevron.up" : "chevron.down")
                        .font(.system(size: 10))
                        .foregroundColor(Color("subfont"))
                }.onTapGesture {
                    withAnimation(.spring()){
                        self.expand.toggle()
                    }
                }
                
                if expand {
                    Button(action: {
                        self.expand.toggle()
                    }){
                        VStack(alignment: .leading, spacing: 15) {
                            Text("ABC Building Street 2")
                                .foregroundColor(.black)
                            
                            Divider()
                            
                            Text("ABC Building Street 2")
                                .foregroundColor(.black)
                            
                            Divider()
                            
                            Text("ABC Building Street 2")
                                .foregroundColor(.black)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(color: Color.black.opacity(0.06), radius: 15, x: 0, y: 20)
                }
            }
        }
    }
}
