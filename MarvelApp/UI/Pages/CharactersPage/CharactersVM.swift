//
//  CharactersVM.swift
//  MarvelApp
//
//  Created by Ali Merhie on 1/21/23.
//

import Foundation

class CharactersVM: BaseVM {
//MARK: - Properties
    var characters = [CharacterModel]() {
        didSet {
            guard characters.isEmpty else {return}
            showEmptyTableView()
        }
    }
    var numberOfItems: Int {
        return characters.count
    }
    
//MARK: - Bindings
    @Action var endLoading
    @Action var reloadTableView
    @Action var showEmptyTableView
    @SubjectAction<(totalCount: Int,currentCount: Int)> var updatePagination
    @SubjectAction<(Bool, IndexPath)> var updateRow
    @SubjectAction<CharacterModel> var navigateToDetails

//MARK: - Functions
    func fetch(page: Int = 0) {
        if characters.isEmpty {
            startSkeletonAnimation()
        }
        ServiceLayer.request(router: CharactersAPI.allCharacters(page: page, limit: 20), model: CharacterModel.self) { result in
            switch result {
                case .success(let data):
                let newCharacters = data.data?.results ?? []
                    if page == 0 {
                        self.characters = newCharacters
                    }else {
                        self.characters.append(contentsOf: newCharacters)
                    }
                    self.reloadTableView()//don't add to didSet
                self.updatePagination((data.data?.total ?? 0, self.characters.count))
                case .failure:
                    break
            }
            self.endLoading()
            self.hideSkeletonAnimation()
        }
    }
    func getItem(at indexPath: IndexPath) -> CharacterModel{
        return characters[indexPath.row]
    }
    func didSelectRow(at indexPath: IndexPath){
        let item = characters[indexPath.row]
        navigateToDetails(item)

    }
    func updated(at indexPath: IndexPath?, using customer: CharacterModel?) {
        guard let customer = customer, let indexPath = indexPath else {
            reloadTableView()
            return
        }
        characters[indexPath.row] = customer
        reloadTableView()
    }
}
