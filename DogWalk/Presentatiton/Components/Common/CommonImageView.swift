//
//  CommonImageView.swift
//  DogWalk
//
//  Created by 박성민 on 11/11/24.
//

import SwiftUI

struct asImageView: View {
    let imageCacheManager = ImageCacheManager()
    let url: String
    let saveType: ImageSaveType
    @State private var image: Image
    init(url: String, image: Image = .asTestImage, saveType: ImageSaveType = .cache) {
        self.url = url
        self.image = image //플레이스 홀더
        self.saveType = saveType
    }
    var body: some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fill)
            .task {
                let result = await imageCacheManager.getImage(url, saveType: saveType)
                image = Image(uiImage: result)
                let _ = print(#function, url)
            }
    }
}

