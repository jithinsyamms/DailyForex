//
//  ForexListViewController.swift
//  DailyForex
//
//  Created by Jithin on 01/01/22.
//

import UIKit

class ForexListViewController: UIViewController {

    let IDENTIFIER = "ForexItemCell"
    
    @IBOutlet weak var forexListView: UITableView!
    private let forexDataModel = ForexDataModel()
    private var isLoading:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        forexDataModel.delegate = self
        forexDataModel.fetchForexData()
        isLoading = true
    }
    
    
    func setUpView(){
        forexListView.register(UINib.init(nibName: "ForexItemCell", bundle: nil), forCellReuseIdentifier: IDENTIFIER)
        forexListView.estimatedRowHeight = 150
        forexListView.rowHeight = UITableView.automaticDimension
        forexListView.tableFooterView = UIView(frame: CGRect.zero)
        forexListView.showsVerticalScrollIndicator = false
        
        let backgroundImage = UIImage(named: "Forex")
        let imageView = UIImageView(image: backgroundImage)
        forexListView.backgroundView = imageView
    }
}

extension ForexListViewController: ForexDataDelegate{
    func loadingStarted() {
        isLoading = true
        self.forexListView.reloadData()
    }
    
    func loadingFinished() {
        isLoading = false
        self.forexListView.reloadData()
    }
}

extension ForexListViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return isLoading ? 0 : forexDataModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return forexDataModel.sections[section]
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         let section = forexDataModel.sections[section]
         return forexDataModel.getForexItems(section: section).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = forexDataModel.sections[indexPath.section]
        let forexItem =  forexDataModel.getForexItems(section:section)[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: IDENTIFIER, for: indexPath) as! ForexItemCell
        cell.setData(forexItem:forexItem)
        return cell
    }
    
    
}

extension ForexListViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = UIColor.white
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        header.textLabel?.frame = header.bounds
        header.textLabel?.textAlignment = .left
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
}

