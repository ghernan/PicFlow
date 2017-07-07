//
//  ImageDownloader.swift
//  PicFlow
//
//  Created by Antonio  Hernandez  on 7/3/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import Alamofire
import AlamofireImage

class ImageDownload {
    
    static let imageDownloader = ImageDownloader(
        configuration: ImageDownloader.defaultURLSessionConfiguration(),
        downloadPrioritization: .fifo,
        maximumActiveDownloads: 10,
        imageCache: AutoPurgingImageCache()
    )
    
    //MARK: - Life cycle
    private init() {
    
    }
    //MARK: - Static functions
    
    static func getImage(fromURL url: URL, success: @escaping (UIImage) -> (), error: @escaping (String) -> ()) {
        let urlRequest = URLRequest(url: url)
        imageDownloader.download(urlRequest) { response in
            guard let image = response.result.value else {
                error("Error: unable to retrieve image")
                return
            }
            success(image)
        }
    }

}
