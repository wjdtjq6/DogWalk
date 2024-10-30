//
//  CommonProfile.swift
//  DogWalk
//
//  Created by 박성민 on 10/30/24.
//

import SwiftUI

struct CommonProfile: View {
    let image: Image
    let size: CGFloat
    
    init(image: Image, size: CGFloat) {
        self.image = image
        self.size = size
    }
    
    var body: some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: size, height: size)
            .cornerRadius(size/2)
            .overlay(
                RoundedRectangle(cornerRadius: size/2)
                    .stroke(Color.primaryBlack.opacity(0.5), lineWidth: 1)
            )
            
    }
}

#Preview {
    CommonProfile(image: .asTestProfile, size: 100)
}
