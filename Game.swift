import Foundation

class Game{
    var teams: String
    var date: Date
    var arena: String
    
    init(teams: String, date: Date, arena: String){
        self.teams = teams
        self.date = date
        self.arena = arena
        
        var teams: String{
            get {
                return teams
            }
    }
        var date: Date{
            get {
                return date
            }
}
        var arena: String{
            get {
                return arena
            }
        }
}
}
