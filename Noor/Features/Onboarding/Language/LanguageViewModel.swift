//
//  LanguageViewModel.swift
//  Noor
//
//  Created by Ferid Suleymanzade on 05.11.26.
//

import Foundation

class LanguageViewModel {
    
    var onSelectionChanged: (() -> Void)?
    
    private let languages: [LanguageModel] = [
        LanguageModel(nativeName: "English", englishName: "English"),
        LanguageModel(nativeName: "العربية", englishName: "Arabic"),
        LanguageModel(nativeName: "Türkçe", englishName: "Turkish"),
        LanguageModel(nativeName: "Azərbaycanca", englishName: "Azerbaijani"),
        LanguageModel(nativeName: "اردو", englishName: "Urdu"),
        LanguageModel(nativeName: "Bahasa Indonesia", englishName: "Indonesian"),
        LanguageModel(nativeName: "Français", englishName: "French")
    ]
    
    private(set) var selectedIndex = 0
    
    var numberOfLanguage: Int {
        return languages.count
    }
    
    var selectedLanguage: LanguageModel {
        return languages[selectedIndex]
    }
    
    func language(at index: Int) -> LanguageModel {
        return languages[index]
    }
    
    func isSelected(at index: Int) -> Bool {
        index == selectedIndex
    }
    
    func selectLanguage(at index: Int) {
        selectedIndex = index
        onSelectionChanged?()
    }
}


