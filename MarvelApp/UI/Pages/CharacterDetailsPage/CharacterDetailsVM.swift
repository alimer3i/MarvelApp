//
//  CharacterDetailsVM.swift
//  MarvelApp
//
//  Created by Ali Merhie on 1/21/23.
//

import Foundation

class CharacterDetailsVM: BaseVM {
    
    //MARK: - Closures
    @Action var reloadTableView
    @Action var showEmptyTableView
    @Published var titleText: String = ""
    
    //MARK: - Properties
    let group = DispatchGroup()
    
    var character: CharacterModel?{
        didSet{
            titleText = character?.name ?? ""
        }
    }
    
    var numberOfItems: Int {
        return CharacterSectionsEnum.allCases.count
    }
    var characterID: Int{
        return character?.id ?? 0
    }
    var dataDictionary: [CharacterSectionsEnum: [CollectionItemProtocol]] = [:]
    
    func getData(at indexPath: IndexPath) -> (data: [CollectionItemProtocol], title: String){
        let currentSection = CharacterSectionsEnum.allCases[indexPath.row]
        let data = dataDictionary[currentSection] ?? []
        let title = currentSection.getTitle
        return (data, title)
    }
    
    
    //MARK: - Functions
    func fetch() {
        startSkeletonAnimation()
        //enter all counts to be called before strting any api call to prevent being empty before all api calls starts
        for _ in CharacterSectionsEnum.allCases {
            group.enter()
        }
        group.notify(queue: .main, execute: {
            self.reloadTableView()
            self.hideSkeletonAnimation()
        })
        for currentType in CharacterSectionsEnum.allCases {
            switch currentType {
            case .Comics:
                CharacterDetailRepository.getComics(for: characterID) { [weak self] data in
                    self?.fillData(for: currentType, data: data)
                }
            case .Events:
                CharacterDetailRepository.getEvents(for: characterID) { [weak self] data in
                    self?.fillData(for: currentType, data: data)
                }
            case .Series:
                CharacterDetailRepository.getSeries(for: characterID) { [weak self] data in
                    self?.fillData(for: currentType, data: data)
                }
            case .Stories:
                CharacterDetailRepository.getStories(for: characterID) { [weak self] data in
                    self?.fillData(for: currentType, data: data)
                }

            }
        }
    }
    private func fillData(for type: CharacterSectionsEnum, data: [CollectionItemProtocol]){
        self.dataDictionary[type] = data
        self.group.leave()
    }
}

