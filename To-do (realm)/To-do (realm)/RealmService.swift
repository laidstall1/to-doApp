//  Realm Service.swift
//  To-do (realm)
//
//  Created by mac on 26/05/2021.
//
import RealmSwift
import Foundation

private let realm = try? Realm()

internal func saveTask(task newTask: String, category: ToDoListItem) {
    realm!.beginWrite()
    
    category.item = newTask
    
    realm!.add(category)
    try? realm?.commitWrite()
}

internal func updateTask(task newTask: String, category: ToDoListItem) {
    do {
        try realm?.write {
            category.item = newTask
            realm?.add(category)
        }
    } catch {
        print(error)
    }
}

internal func deleteTask(at category: ToDoListItem) {
    realm?.beginWrite()
    
    realm?.delete(category)
    
    try! realm?.commitWrite()
}
