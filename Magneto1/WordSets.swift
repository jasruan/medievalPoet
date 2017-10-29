//
//  WordSets.swift
//  Magneto1
//
//  Created by Jasmine Ruan & Johnny Siu on 2/23/17.
//  Copyright © 2017 igmstu. All rights reserved.
//

import Foundation
//Class to store all word sets and such
class WordSets{
    //MARK: -ivars-
    var heroic:[String]
    var knightHood:[String]
    var war:[String]
    var festival:[String]
    var welcome:[String]
    var category:[String]
    init(){
        //MARK: -initialization-
        self.category = ["normal","heroic","knightHood","war","festival","welcome"]
        heroic = ["shiny", "brave", "stab", "slay", "curse", "thy", "grown", "tall", "horse", "I", "too", "the", "thee", "creed", "truth", "swear", "ultimate", "for", "head", "ache", "blood", "tear", "turn"]
        knightHood = ["helm", "sword", "joust", "to", "duel", "laugh", "haughty", "to", "death", "the", "end", "absolute", "flaunt", "cry", "you", "fair", "cruel", "loud", "queen", "king", "lord", "bless", "thee", "moment", "joy"]
        war = ["calvery","infantry","archers","plunder","pillage","blade","I","ally","group","Enemy","general","Mercenary","death","glory","surrender","victory","injustice","death","attack", "flag", "pride", "sunder", "drums"]
        festival = ["tournament","melee","champion","bets","feast","he","she","prince","I","joust","screamed","cheer","ing","maidens", "fare", "kinds","king","tears", "bard", "drink", "goblet", "drunk", "lying", "full"]
        welcome = ["Hello", "Please", "Select", "A", "Set", "Down","Below"]
    }
    //MARK: -helper methods- 
    func getwordset(_ wordsetwanted:String)->[String]
    {
        //Heroic","Knighthood","War","Festival"
        if(wordsetwanted == "Heroic")
        {
            return self.heroic
        }
        else if(wordsetwanted == "Knighthood")
        {
            return self.knightHood
        }
        else if(wordsetwanted == "War")
        {
            return self.war
        }
        else if(wordsetwanted == "Festival")
        {
            return self.festival
        }
        else
        {
            return self.welcome
        }
    }
    
}
