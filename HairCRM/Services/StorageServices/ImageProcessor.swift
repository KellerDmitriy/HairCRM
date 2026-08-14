//
//  ImageProcessor.swift
//  HairCRM
//
//  Created by Келлер Дмитрий on 07.08.2026.
//


import UIKit

enum ImageProcessor {

    static func resize(
        imageData: Data,
        size: CGSize = CGSize(width: 100, height: 100),
        compressionQuality: CGFloat = 0.8
    ) -> Data? {

        guard let image = UIImage(data: imageData) else {
            return nil
        }

        let renderer = UIGraphicsImageRenderer(size: size)

        let resizedImage = renderer.image { _ in
            image.draw(
                in: CGRect(
                    origin: .zero,
                    size: size
                )
            )
        }

        return resizedImage.jpegData(
            compressionQuality: compressionQuality
        )
    }
}