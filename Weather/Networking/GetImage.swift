//
//  GetImage.swift
//  Weather
//
//  Created by Victor Vieira on 16/03/22.
//

import UIKit

func downloadImageFrom(url: URL, completion: @escaping (UIImage?, Error?) -> Void) {
    getData(from: url) { data, _ , error in
        
        DispatchQueue.main.async {
            guard let data = data else {
                print("Empty Data")
                return
            }
            
            if let error = error {
                print("DataTask: \(error.localizedDescription)")
                return
            }
            completion(UIImage(data: data), nil)
        }
    }
}

func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void){
    URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
}
