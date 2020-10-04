//
//  DetailJokeViewController.swift
//  JnAPICucknorris
//
//  Created by Jonatan on 03/10/2020.
//

import UIKit

// MARK: - Attendees View Controller
//
class DetailJokeViewController: UIViewController {
    
    // MARK: - IBOutlets
    //
    @IBOutlet weak var carga: UIActivityIndicatorView!
    @IBOutlet weak var detialtext: UILabel!
    @IBOutlet weak var valueJoke: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var imageJoke: UIImageView!
    
    // MARK: - Variables And Properties
    //
    var categoria : String?
    var custonName : String?
    
    // MARK: - View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        carga.startAnimating()
        loadJoke(categorie: categoria!)
        self.navigationItem.title = categoria!.firstUppercased
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Functions
    //
    
    func loadJoke(categorie: String){
        
        APICall.fetchRandomWithCagetorieJSON(typecateg: categoria,namecustom: custonName){ (res) in
            switch res{
            case .success(let joke):
                DispatchQueue.main.async {
                    
                    self.valueJoke.text =  joke.value
                    self.idLabel.text = "Id: " + joke.id
                    self.DateLabel.text = "Date: " + String(joke.created_at.prefix(upTo: joke.created_at.index(joke.created_at.startIndex, offsetBy: 10)))
                    
                    let data = try? Data(contentsOf: URL(string: joke.icon_url)!)
                    self.imageJoke.image = UIImage(data: data!)
                    
                    print(joke.value)
                    
                    self.carga.stopAnimating()
                    self.carga.hidesWhenStopped = true
                }
                
            case .failure(let err):
                DispatchQueue.main.async {
                    self.valueJoke.text = "Problemas al cargar chiste"
                    print(err)
                    self.carga.stopAnimating()
                    self.carga.hidesWhenStopped = true
                }
                
            }
        }}
    
    // MARK: - IBActions
    //
    @IBAction func botonRandom(_ sender: Any) {
        loadJoke(categorie: categoria!)
    }
}

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */


