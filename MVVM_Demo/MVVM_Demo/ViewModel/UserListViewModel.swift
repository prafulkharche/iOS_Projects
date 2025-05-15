//
//  UserListViewModel.swift
//  MVVM_Demo
//
//  Created by Apple on 15/05/25.
//

import Foundation



class UserListViewModel{
    
    var users :[User] = []{
        didSet{
            onUserUpdate?()
        }
    }
    
    
    var onUserUpdate:(()-> Void)?
    
    func fetchUser()
    {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users")else {return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else{return}
            
            do{
                let decodeUsers = try JSONDecoder().decode([User].self, from: data)
                DispatchQueue.main.async{
                    self.users = decodeUsers
                }
            }
            catch
            {
                print("Decoding Error: \(error)")
            }
            
        }
        .resume()
    }
}
