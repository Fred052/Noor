//
//  CoreHelper.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 19.11.26.
//

import Foundation

final class CoreHelper {
    
    static let shared  = CoreHelper()
    
    private init() {}
    
    private let baseURL = "https://api.alquran.cloud/v1/"
    private let audioBaseURL = "https://cdn.islamic.network/quran/audio-surah/"
    
    func configureURL(endpoint: String) -> String {
        baseURL + endpoint
    }
    
    func configureAudioURL(surahNumber: Int, bitrate: Int = 128, reciter: String = "ar.alafasy") -> String {
        "\(audioBaseURL)\(bitrate)/\(reciter)/\(surahNumber).mp3"
    }
}
