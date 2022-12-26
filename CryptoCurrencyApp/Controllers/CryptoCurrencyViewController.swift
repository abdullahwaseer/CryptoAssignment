//
//  ViewController.swift
//  CryptoCurrencyApp
//
//  Created by Abdullah Waseer on 20/12/2022.
//

import UIKit
import Combine

class CryptoCurrencyViewController: UIViewController {

    var viewModel: CryptoCurrencyViewModel!
    private var subscriptions = Set<AnyCancellable>()

    private lazy var tableView: UITableView = { [weak self] in
            
        let tableWidth: CGFloat = self?.view.frame.width ?? 0
        let tableHeight: CGFloat = self?.view.frame.height ?? 0
        
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: tableWidth, height: tableHeight))
        tableView.delegate = self
        tableView.rowHeight = 80
        
        return tableView
    }()
    
    private lazy var refreshControl: PullToRefreshControl = PullToRefreshControl {
        self.fetchCryptoCurrencies(onRefresh: true)
    }
    
    private var tableCellClassName : String { String(describing: CryptoCurrencyTableViewCell.self) }
    
    private lazy var dataSource: UITableViewDiffableDataSource<Int, CryptoCurrencyTableViewCellViewModel> = {
        .init(tableView: tableView) { (tableView, indexPath, cellViewModel) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: self.tableCellClassName, for: indexPath) as? CryptoCurrencyTableViewCell
            cell?.prepare(with: cellViewModel)
            cell?.selectionStyle = .none
            return cell
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configureUI()
        prepareViewModel()
    }
    
    func configureUI() {
        
        self.title = "Crypto Currencies"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20.0)]

        self.view.addSubview(tableView)
        tableView.add(refreshControl)
        tableView.register(CryptoCurrencyTableViewCell.self, forCellReuseIdentifier: tableCellClassName)
    }
    
    func prepareViewModel() {
        viewModel.$errorMessage.compactMap { $0 }.sink(receiveValue: { error in
            self.showAlertWith(message: error.localizedDescription)
            }).store(in: &subscriptions)
        
        viewModel.$currencies.compactMap { $0 }.sink { [weak self] currencies in
            self?.didUpdateDataSource()
        }.store(in: &subscriptions)
        
        viewModel.fetchCryptoCurrencies()
    }
    
    private func didUpdateDataSource() {
        self.refreshControl.endRefreshing()

        DispatchQueue.main.async {
            self.setItems(self.viewModel.dataSource)
        }
    }
    
    func fetchCryptoCurrencies(onRefresh: Bool = false) {
        refreshControl.programaticallyBeginRefreshing(in: tableView)
        viewModel.fetchCryptoCurrencies()
    }
    
    private func setItems(_ newItems: [CryptoCurrencyTableViewCellViewModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, CryptoCurrencyTableViewCellViewModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(newItems, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

extension CryptoCurrencyViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let title = dataSource.snapshot().sectionIdentifiers.last {
            let items = dataSource.snapshot().numberOfItems(inSection: title)
            if items == indexPath.row + 1 {
                viewModel.fetchMoreCryptoCurrencies()
            }
        }
    }
}


extension CryptoCurrencyViewController {
    
    func showAlertWith(title: String = "", message: String) {
        
        let title = title.localized
        let message = message.localized
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "OK".localized, style: .cancel) { _ in
        }
        alertController.addAction(confirmAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
