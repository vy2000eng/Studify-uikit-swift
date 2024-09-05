//
//  SubjectModel.swift
//  Studify
//
//  Created by VladyslavYatsuta on 5/26/24.
//

import Foundation
//struct Subject: Identifiable{
//    let id: UUID
//    var title: String
//    let map: MindMap
//    var flashcards: [FlashCard]
//    
//
//    init(id: UUID = UUID(), title: String, map: MindMap, flashcards: [FlashCard]) {
//        self.id = id
//        self.title = title
//        self.map = map
//        self.flashcards = flashcards
//    }
// }
//
//
//
//
//
////extension Subject{
////    struct FlashCard:Identifiable{
////        let id:UUID
////        let front:String
////        let back:String
////
////        init(id: UUID = UUID(), front: String, back: String) {
////            self.id = id
////            self.front = front
////            self.back = back
////        }
////
////    }
////}
//
//
//extension Subject{
//    
//    static var houseMap = MindMap(title: "House")
//    static var restaruantMap = MindMap(title:"TGI Fridays")
//    static var bedRoomMap = MindMap(title:"Bedroom")
//    
//    
//    
//    static var cs_arr = [
//            FlashCard(front: "lexer", back: "recognizes some set of Regular languages"),
//            FlashCard(front: "Parser", back: "breaks source code into small sections of character strings called tokens"),
//            FlashCard(front: "Semantic Anylzer", back: "it uses syntax tree and symbol table to check whether the given program is semantically                                                      consistent with language definition.")
//            ]
//
//    
//    static var chem_arr = [
//            FlashCard(front: "alkali metals", back: "he metals in the first periodic table column, minus hydrogen"),
//            FlashCard(front: "allotropes", back: "all the different forms elements can exist in"),
//            FlashCard(front: "alloy", back: "imetal mixtures with multiple elements"),
//            FlashCard(front: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", back: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
//
//            ]
//    static var trig_arr = [
//            FlashCard(front: "sin", back: "sine"),
//            FlashCard(front: "cos", back: "cosioe"),
//            FlashCard(front: "tan", back: "tangent"),
//            FlashCard(front: "cos", back: "cosecant"),
//            FlashCard(front: "sec", back: "secant"),
//            FlashCard(front: "cot", back: "cotangent"),
//            FlashCard(front: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", back: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
//
//
//    ]
//
//    static var lit_arr = [
//        FlashCard(front: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", back: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
//
//            FlashCard(front: " Crime and Punishment", back: "Fyodor Dostoevsky"),
//            FlashCard(front: "Pushkin", back: "The captains daughter"),
//            FlashCard(front: "The Death of Ivan Ilyich ppppppppppppppppppppppppppppp", back: "Tolstoy")
//            ]
//    
//
//
//    
//    //    FlashCardArr( [
////        FlashCard(front: "lexer", back: "recognizes some set of Regular languages"),
////        FlashCard(front: "Parser", back: "breaks source code into small sections of character strings called tokens"),
////        FlashCard(front: "Semantic Anylzer", back: "it uses syntax tree and symbol table to check whether the given program is semantically                                                      consistent with language definition.")
////    ])
//    
//    static var sampleData = [
//        Subject(title: "Chemisty", map:houseMap, flashcards: chem_arr),
//        Subject(title: "Literature", map: restaruantMap, flashcards:lit_arr ),
//        Subject(title: "Trig", map:  bedRoomMap, flashcards: trig_arr),
//        Subject(title: "Compilers", map: houseMap, flashcards: cs_arr)
//
//        
//        
//        
////        Subject(title: "Chemistry"),map:housemap,
////        Subject(title: "English"),
////        Subject(title: "Trig"),
////        Subject(title: "Psych")
//    ]
//}
