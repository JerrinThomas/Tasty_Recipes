//
//  SearchViewController.swift
//  SearchTabbar
//
//  Created by user204823 on 3/22/22.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate,  UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableSearchResults.delegate = self
        self.tableSearchResults.dataSource = self
        
        
        tableSearchResults.rowHeight = 70.0
        
        tableSearchResults.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTableViewCell")
        
        getRandomMeals()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
        
        inputSearch.clearButtonMode = .whileEditing
        
        let searchImage:UIImageView = UIImageView(image: UIImage(named: "search24"))
        searchImage.tintColor = UIColor.darkGray
        
               
        inputSearch.leftView = searchImage
        inputSearch.leftViewMode = UITextField.ViewMode.always


        inputSearch.leftView?.widthAnchor.constraint(equalToConstant: 25.0).isActive = true
        inputSearch.leftView?.heightAnchor.constraint(equalToConstant: 25.0).isActive = true
        
        
        tableSearchResults.reloadData()
        


    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchArray.isEmpty{
            return 1
        } else{
        return searchArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if searchArray.isEmpty{
            let cell = UITableViewCell()
            cell.selectionStyle = .none
            tableSearchResults.isScrollEnabled = false
            cell.textLabel?.text = "No Results...."
            cell.textLabel?.textColor = UIColor.gray
            print("No Results....")
            return cell
        }else{
        let cell = tableSearchResults.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
            cell.selectionStyle = .gray
        tableSearchResults.isScrollEnabled = true
        cell.imageDish.layer.cornerRadius = 5.0
            
        cell.imageDish.loadFrom(URLAddress: searchArray[indexPath.row].strMealThumb ?? "https://www.themealdb.com/images/media/meals/u55lbp1585564013.jpg")

        cell.labelDishCategory.text = searchArray[indexPath.row].strCategory
            
        cell.labelDishName.text = searchArray[indexPath.row].strMeal
        
        return cell
        }
    }
    
      
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerV = UIView()
        headerV.backgroundColor = UIColor.clear
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.size.width, height: 30))
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        label.backgroundColor  = UIColor.white
        if inputSearch.text == "" {
            label.text = "  Top Recipes"
        } else{
            label.text = "  Results"
        }
        headerV.addSubview(label)
        return headerV
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath," is clicked")
        return
    }
    
    func getRandomMeals() {
        searchArray = []
        for _ in 1...3{
            Requests.randomMeal { results in
                self.searchArray.append(contentsOf: results)
                DispatchQueue.main.async {
                    self.tableSearchResults.reloadData()
                }
            }
        }
    }
    
    func getSearchMeals(name:String) {
        searchArray = []
        Requests.getSearchResult(name: name, completionHandler: { (results) in
            self.searchArray.append(contentsOf: results)
            DispatchQueue.main.async {
                self.tableSearchResults.reloadData()
            }
        })
    }
    
    @IBAction func searchChanged(_ sender: Any) {
        if inputSearch.text == "" {
            getRandomMeals()
        } else {
            getSearchMeals(name: inputSearch.text ?? "a")
        }
    }
    
    var searchArray = [Search]()
    
    @IBOutlet weak var inputSearch: UITextField!
    
    @IBOutlet weak var tableSearchResults: UITableView!
    
    
}

extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                        self?.image = loadedImage
                }
            }
        }
    }
}
