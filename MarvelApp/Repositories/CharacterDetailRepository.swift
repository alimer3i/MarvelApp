//
//  CharacterDetailRepository.swift
//  MarvelApp
//
//  Created by Ali Merhie on 1/22/23.
//

import Foundation

class CharacterDetailRepository {
    
    class func getComics(for characterID: Int ,completion: @escaping ([CollectionItemProtocol]) -> ()){
        
        let savedData = RealmHelper.shared.getDataBy(characterID: characterID, model: ComicModel.self)
        if !savedData.isEmpty{
            completion(savedData)
            return
        }
        ServiceLayer.request(router: CharactersAPI.comics(characterID: characterID), model: ComicModel.self) { result in
            switch result {
            case .success(let data):
                var currentData = data.data?.results ?? []
                completion(currentData)
                
                for item in currentData {
                    item.characterID = characterID
                }
                RealmHelper.shared.save(data:currentData, model: ComicModel.self)
            case .failure:
                completion([])
                break
            }
        }
    }
    class func getEvents(for characterID: Int ,completion: @escaping ([CollectionItemProtocol]) -> ()){
        let savedData = RealmHelper.shared.getDataBy(characterID: characterID, model: EventModel.self)
        if !savedData.isEmpty{
            completion(savedData)
            return
        }
        ServiceLayer.request(router: CharactersAPI.events(characterID: characterID), model: EventModel.self) { result in
            switch result {
            case .success(let data):
                let currentData = data.data?.results ?? []
                completion(currentData)
                for item in currentData {
                    item.characterID = characterID
                }
                RealmHelper.shared.save(data:currentData, model: EventModel.self)
            case .failure:
                completion([])
                break
            }
        }
    }
    class func getSeries(for characterID: Int ,completion: @escaping ([CollectionItemProtocol]) -> ()){
        let savedData = RealmHelper.shared.getDataBy(characterID: characterID, model: SeriesModel.self)
        if !savedData.isEmpty{
            completion(savedData)
            return
        }
        ServiceLayer.request(router: CharactersAPI.series(characterID: characterID), model: SeriesModel.self) { result in
            switch result {
            case .success(let data):
                let currentData = data.data?.results ?? []
                completion(currentData)
                for item in currentData {
                    item.characterID = characterID
                }
                RealmHelper.shared.save(data:currentData, model: SeriesModel.self)
            case .failure:
                completion([])
                break
            }
        }
    }
    class func getStories(for characterID: Int ,completion: @escaping ([CollectionItemProtocol]) -> ()){
        let savedData = RealmHelper.shared.getDataBy(characterID: characterID, model: StoryModel.self)
        if !savedData.isEmpty{
            completion(savedData)
            return
        }
        ServiceLayer.request(router: CharactersAPI.stories(characterID: characterID), model: StoryModel.self) { result in
            switch result {
            case .success(let data):
                let currentData = data.data?.results ?? []
                completion(currentData)
                for item in currentData {
                    item.characterID = characterID
                }
                RealmHelper.shared.save(data:currentData, model: StoryModel.self)
            case .failure:
                completion([])
                break
            }
        }
    }
}
