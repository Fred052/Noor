//
//  AudioPlayerManager.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 20.11.26.
//

import AVFoundation

final class AudioPlayerManager {
    
    static let shared = AudioPlayerManager()
    
    private init() {}
    
    var onStateChange: (() -> Void)?
    var onError: ((String) -> Void)?
    
    private(set) var currentSurahNumber: Int?
    private(set) var isPlaying = false
    
    private var player: AVPlayer?
    private var statusObservation: NSKeyValueObservation?
    private var endObserver: NSObjectProtocol?
    
    func play(surahNumber: Int, urlString: String) {
        
        if currentSurahNumber == surahNumber {
            togglePlayPause()
            return
        }
        
        guard let url = URL(string: urlString) else {
            onError?("Invalid audio URL")
            return
        }
        
        guard activateAudioSession() else { return }
        
        player?.pause()
        stopObserving()
        
        let item = AVPlayerItem(url: url)
        observe(item: item)
        
        player = AVPlayer(playerItem: item)
        player?.play()
        
        currentSurahNumber = surahNumber
        isPlaying = true
        onStateChange?()
    }
    
    private func togglePlayPause() {
        if isPlaying {
            player?.pause()
            isPlaying = false
        } else {
            player?.play()
            isPlaying = true
        }
        onStateChange?()
    }
    
    private func activateAudioSession() -> Bool {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            return true
        } catch {
            onError?(error.localizedDescription)
            return false
        }
    }
    
    private func observe(item: AVPlayerItem) {
        // Yükləmə uğursuz olsa (məs. internet yoxdur)
        
        statusObservation = item.observe(\.status, options: [.new]) { [weak self] item, _ in
            guard item.status == .failed else { return }
            let message = item.error?.localizedDescription ?? "Audio could not be loaded"
            DispatchQueue.main.async {
                self?.reset()
                self?.onError?(message)
            }
        }
        
        endObserver = NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime,
                                                             object: item,
                                                             queue: .main,) { [weak self] _ in
            self?.reset()
        }
    }
    
    private func reset() {
        player?.pause()
        player = nil
        currentSurahNumber = nil
        isPlaying = false
        stopObserving()
        onStateChange?()
    }
    
    private func stopObserving() {
        statusObservation?.invalidate()
        statusObservation = nil
        if let endObserver {
            NotificationCenter.default.removeObserver(endObserver)
        }
        endObserver = nil
    }
}
