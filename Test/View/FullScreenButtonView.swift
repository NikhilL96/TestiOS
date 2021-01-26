//
//  FullScreenButtonView.swift
//  Test
//
//  Created by Nikhil L on 26/01/21.
//

import SwiftUI

struct FullScreenButtonView: View {
    
    @Binding var isFullScreen: Bool
    var body: some View {
        Group{
            Button(action: {
                self.isFullScreen.toggle()

            }, label: {
                if isFullScreen {
                     Image(systemName: "arrow.down.right.and.arrow.up.left")
                        .foregroundColor(Color.white.opacity(0.8))
                            .font(.subheadline)
                
                
                    } else {
                        Image(systemName:"arrow.up.left.and.arrow.down.right")
                        .foregroundColor(Color.white.opacity(0.8))
                            .font(.subheadline)
                    }
            })
        }.padding(.horizontal, 15)
        .padding(.bottom, 10)
        .padding(.top, 10)
        .background(Color.white.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius:10))
        
    }
}

struct FullScreenButtonView_Previews: PreviewProvider {
    static var previews: some View {
        FullScreenButtonView(isFullScreen: Binding.constant(false))
    }
}
