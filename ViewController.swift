//
//  ViewController.swift
//  Matchdags
//
//  Created by Nicklas Thirus on 2016-12-16.
//  Copyright © 2016 Nicklas Thirus. All rights reserved.
//

import UIKit

var chosenTeam = 0
var pickerData = ["Brynäs IF", "Djurgårdens IF", "Frölunda HC", "Färjestad BK", "HV71", "Karlskrona HK", "Leksands IF", "Linköpings HC", "Luleå HF", "Malmö Redhawks", "Rögle BK", "Skellefteå AIK", "Växjö Lakers", "Örebro HK"]

var gameData = [Game]()
var selectedGame:Game!


class ViewController: UIViewController {
    
    
    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var nextGameLabel: UILabel!
    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var getStarted: UIImageView!
    
    @IBAction func settingsButton(_ sender: Any) {
        performSegue(withIdentifier: "segue", sender: self)
        //När visselpipan trycks, ladda vy 2.
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let filepath = Bundle.main.path(forResource: "schema_final", ofType: "txt") {
            do {
                let data = try String(contentsOfFile: filepath, encoding: .macOSRoman)
                let lines = data.components(separatedBy: "\n")
                for line in lines{
                    if(line != ""){
                    let gameInfo = line.components(separatedBy: ";")
                        let isoDate = gameInfo[1]
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm a"
                        let date = dateFormatter.date(from:isoDate)!
                        let calendar = Calendar.current
                        let components = calendar.dateComponents([.year, .month, .day, .hour], from: date)
                        let finalDate = calendar.date(from:components)
                    //print(gameInfo[0] + " " + gameInfo[1] + " " + gameInfo[2])
                        let getGame = Game(teams:gameInfo[0], date:finalDate!, arena:gameInfo[2])
                    gameData.append(getGame)
                    }
                }
            } catch {
                print(error)
            }
            
        }
        
        
        //User default kod = if let x = UserDefaults.standard.object(forKey: "chosenTeam") as? Int{
            //chosenTeam = x
            if(chosenTeam != 0){
                
                gameData.forEach{
                    let game = $0.teams
                    if(game.range(of:pickerData[chosenTeam-1]) != nil){
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
                        print(dateFormatter.date(from:$0.date))
                        //print("Sökt lag:" + pickerData[chosenTeam-1] + ". Match: " + $0.teams)
                    }
                }
                logoView.image = UIImage(named:String(chosenTeam))
                getStarted.image = nil
                nextGameLabel.text = "Nästa Match"
                
            }
        // User-default stop}
     
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

}

