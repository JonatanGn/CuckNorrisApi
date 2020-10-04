//
//  ViewController.swift
//  JnAPICucknorris
//
//  Created by Jonatan on 03/10/2020.
//

import UIKit
//
// MARK: - View Controller
//
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    //
    
    // MARK: - IBOutlets
    //
    @IBOutlet weak var switchName: UISwitch!
    @IBOutlet weak var tabla: UITableView!
    //
    
    // MARK: - Variables And Properties
    //
    var nameCustom : String = ""
    var lista: [String] = []{
        didSet{
            DispatchQueue.main.async {
                self.tabla.reloadData()
            }
        }
    }
    //
    // MARK: - View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        tabla.delegate = self
        tabla.dataSource = self
        load()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc = segue.destination as! DetailJokeViewController
        vc.categoria = lista[tabla.indexPathForSelectedRow!.row]
        vc.custonName = self.nameCustom
        
    }
    //
    // MARK: - Table View
    //
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lista.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CategoriesTVCell
        
        cell.prepareCell(with: lista[indexPath.row])
        
        return cell
    }
    //
    // MARK: - Instance Methods
    //
    
    func load()  {
        APICall.fetchCategoriesJSON{ (res) in
            switch res{
            case .success(let lista):
                self.lista = lista
                lista.forEach({(lista) in
                                print(lista)}                )
            case .failure(let err):
                print(err)
            }
        }}
    //
    // MARK: - IBActions
    //
    @IBAction func nameChanged(_ sender: UISwitch) {
        
        switch sender.isOn {
        case true:
            
            let alert = UIAlertController(title: "Input your name custom",
                                          message: "",
                                          preferredStyle: .alert)
            
            let submitAction = UIAlertAction(title: "Submit", style: .default, handler: { (action) -> Void in
                
                // Get 1st TextField's text
                let textField = alert.textFields![0]
                if textField.text != ""{
                    self.nameCustom = textField.text!
                    print(self.nameCustom)
                }else{
                    self.switchName.setOn(false, animated: true)
                    
                }
            })
            
            alert.addTextField { (textField: UITextField) in
                textField.keyboardAppearance = .dark
                textField.keyboardType = .default
                textField.autocorrectionType = .default
                //textField.placeholder = "Type something here"
                textField.clearButtonMode = .whileEditing
            }
            
            let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in
                
                self.switchName.setOn(false, animated: true)
                
            })
            
            
            alert.addAction(submitAction)
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
        case false:
            print("nada")
            
        }
        
    }
    
    
    
}







