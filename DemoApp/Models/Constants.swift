//
//  Constants.swift
//  LoginScreen
//
//  Created by ashutosh on 31/07/21.
//

import SwiftUI

struct Screen {
    static let maxWidth = UIScreen.main.bounds.width
    static let maxHeight = UIScreen.main.bounds.height
}

extension Image{
    func fromUrl(url : String) -> Self{
        if let data = try? Data(contentsOf: URL(string: url)!) {
        return Image(uiImage: UIImage(data: data)!)
        .resizable()
        }
        return self
            .resizable()
    }
}
