//
//  APICaller.swift
//  ClubManager
//
//  Created by JoSoJeong on 2021/03/08.
//

import Foundation

class APICaller {
    var isPaginating = true
    func fetchData(pagination: Bool = false, completion: @escaping (Result<[String], Error>) -> Void) {
        if pagination {
            self.isPaginating = true
        }
        //code excution time delay
        DispatchQueue.global().asyncAfter(deadline: .now() + (pagination ? 3 : 2), execute: {
            let originalData = [
            "apple",
            "google",
            "facebook",
            "apple",
            "apple",
            "google",
            "facebook",
            "apple",
            "apple",
            "google",
            "facebook",
            "apple"
            ]
             
            let newData = [
            "banana",
            "orange",
            "grape",
            "melon"]
            completion( .success(pagination ? newData : originalData))
            if pagination {
                self.isPaginating = false
            }
        })
        
    }
}
