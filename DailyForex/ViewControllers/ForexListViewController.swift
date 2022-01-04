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
    private var isLoading: Bool = false
    private var selectedItem: ForexItem!
    private var backgroundView: BackgroundView!
    private let refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        forexDataModel.delegate = self
        forexDataModel.fetchForexData()
        isLoading = true
    }

    func setUpView() {
        setNavigatiionBar()
        forexListView.register(UINib.init(nibName: "ForexItemCell", bundle: nil), forCellReuseIdentifier: IDENTIFIER)
        forexListView.estimatedRowHeight = 300
        forexListView.rowHeight = UITableView.automaticDimension
        forexListView.tableFooterView = UIView(frame: CGRect.zero)
        forexListView.showsVerticalScrollIndicator = false
        backgroundView = BackgroundView()
        forexListView.backgroundView = backgroundView
        setRefreshControl()
    }

    func setNavigatiionBar() {
        self.title = "NEWS_FEED".localized
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.8)
        self.navigationController?.navigationBar.standardAppearance = navBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }

    func setRefreshControl() {
        forexListView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshNewsFeed(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor.white
        let stringAttributes = [ NSAttributedString.Key.foregroundColor: UIColor.white,
                                 NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
        refreshControl.attributedTitle = NSAttributedString(string: "FETCHING_NEWS".localized,
                                                            attributes: stringAttributes)
    }

    @objc func refreshNewsFeed(_ sender: Any) {
        forexDataModel.fetchForexData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showForexDetail" {
            if let detailController = segue.destination as? ForexIemViewController {
                detailController.forexItem = selectedItem
            }
        }
    }
}

extension ForexListViewController: ForexDataDelegate {
    func loadingStarted() {
        isLoading = true
        self.forexListView.reloadData()
        backgroundView.setLoading()
    }

    func loadingFinished() {
        isLoading = false
        if forexDataModel.sections.count > 0 {
            backgroundView.setLoadingCompleted()
        }
        self.refreshControl.endRefreshing()
        if let headerView = Bundle.main.loadNibNamed("NewsHeaderCell", owner: nil, options: nil)?.first
            as? NewsHeaderCell, let floatingItem = forexDataModel.getFloatingNews() {
            headerView.setData(forexItem: floatingItem)
            headerView.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.headerNewsClicked))
            headerView.addGestureRecognizer(tap)
            self.forexListView.tableHeaderView = headerView
        }
        self.forexListView.reloadData()
    }

    func errorLoadingData() {
        backgroundView.setLoadingError()
    }

    @objc func headerNewsClicked() {
        selectedItem =  forexDataModel.getFloatingNews()
        performSegue(withIdentifier: "showForexDetail", sender: self)
    }

}

extension ForexListViewController: UITableViewDataSource {

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
        let forexItem =  forexDataModel.getForexItems(section: section)[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: IDENTIFIER, for: indexPath) as? ForexItemCell {
            cell.setData(forexItem: forexItem)
            return cell
        }
        return UITableViewCell()
    }
}

extension ForexListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let section = forexDataModel.sections[indexPath.section]
        selectedItem =  forexDataModel.getForexItems(section: section)[indexPath.row]
        performSegue(withIdentifier: "showForexDetail", sender: self)
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = UIColor.white
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        header.textLabel?.frame = header.bounds
        header.textLabel?.textAlignment = .left
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

}
