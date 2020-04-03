//
//  VirtualGoodExchangeViewController.swift
//  RebeloperStore5
//
//  Created by Alex Nagy on 02/08/2019.
//  Copyright © 2019 Alex Nagy. All rights reserved.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import DuckUI
import ReactiveKit
import Bond
import Layoutless

class VirtualGoodExchangeViewController: D_ListController<VirtualGoodExchangeCell, VirtualGoodPurchase> {
    
    // MARK:- Dependencies
    
    // MARK:- Properties
    
    let buttonSize = CGSize(width: 160, height: 30)
    
    // MARK:- Navigation Items
    
    // MARK:- Views
    
    lazy var button0 = UIButton()
        .text("GIVE 100 COINS")
        .text(D_Color.Xcode11.Light.purple)
        .background(D_Color.Xcode11.Light.gray6)
        .font(UIFont.boldSystemFont(ofSize: 16))
        .corner(buttonSize.height / 2)
        .frame(buttonSize)
    
    lazy var button1 = UIButton()
        .text("TAKE 50 COINS")
        .text(D_Color.Xcode11.Light.purple)
        .background(D_Color.Xcode11.Light.gray6)
        .font(UIFont.boldSystemFont(ofSize: 16))
        .corner(buttonSize.height / 2)
        .frame(buttonSize)
    
    lazy var button2 = UIButton()
        .text("GIVE 1 SHIELD")
        .text(D_Color.Xcode11.Light.purple)
        .background(D_Color.Xcode11.Light.gray6)
        .font(UIFont.boldSystemFont(ofSize: 16))
        .corner(buttonSize.height / 2)
        .frame(buttonSize)
    
    lazy var button3 = UIButton()
        .text("TAKE 1 SHIELD")
        .text(D_Color.Xcode11.Light.purple)
        .background(D_Color.Xcode11.Light.gray6)
        .font(UIFont.boldSystemFont(ofSize: 16))
        .corner(buttonSize.height / 2)
        .frame(buttonSize)
    
    lazy var button4 = UIButton()
        .text("GIVE 3 SWORDS")
        .text(D_Color.Xcode11.Light.purple)
        .background(D_Color.Xcode11.Light.gray6)
        .font(UIFont.boldSystemFont(ofSize: 16))
        .corner(buttonSize.height / 2)
        .frame(buttonSize)
    
    lazy var button5 = UIButton()
        .text("DELETE GEMS")
        .text(D_Color.Xcode11.Light.purple)
        .background(D_Color.Xcode11.Light.gray6)
        .font(UIFont.boldSystemFont(ofSize: 16))
        .corner(buttonSize.height / 2)
        .frame(buttonSize)
    
    lazy var button6 = UIButton()
        .text("CLEAR KEYCHAIN")
        .text(D_Color.Xcode11.Light.purple)
        .background(D_Color.Xcode11.Light.gray6)
        .font(UIFont.boldSystemFont(ofSize: 16))
        .corner(buttonSize.height / 2)
        .frame(buttonSize)
    
    lazy var button7 = UIButton()
        .text("RESET KEYCHAIN")
        .text(D_Color.Xcode11.Light.purple)
        .background(D_Color.Xcode11.Light.gray6)
        .font(UIFont.boldSystemFont(ofSize: 16))
        .corner(buttonSize.height / 2)
        .frame(buttonSize)
    
    lazy var button8 = UIButton()
        .text("LOG KEYCHAIN")
        .text(D_Color.Xcode11.Light.purple)
        .background(D_Color.Xcode11.Light.gray6)
        .font(UIFont.boldSystemFont(ofSize: 16))
        .corner(buttonSize.height / 2)
        .frame(buttonSize)
    
    let bottomViewDivider = UIView().setBackground(color: D_Color.Xcode11.Light.gray4).setHeight(0.4)
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        viewDidLoadSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // MARK:- Setup Navigation
    
    fileprivate func setupNavigation() {
        title = "Virtual Good Exchange"
    }
    
    // MARK:- View Did Load Setup
    
    fileprivate func viewDidLoadSetup() {
        
        self.addBottomView(height: 260)
        self.view.addHomeIndicatorCover()
        
        setupBottomView()
        
        items = [
            // provide items for the collection view to load
            VirtualGoodPurchase(imageUrl: "Icon-1024", title: "Coins to Gems", description: "Exchanged 50 coins for 10 gems", virtualGood: VirtualGoodExchange.coin, forVirtualGood: VirtualGoodExchange.gem, amount: 50, forAmount: 10),
            
            VirtualGoodPurchase(imageUrl: "Icon-1024", title: "Coins to Diamonds", description: "Exchanged 150 coins for 10 diamonds", virtualGood: VirtualGoodExchange.coin, forVirtualGood: VirtualGoodExchange.diamond, amount: 150, forAmount: 10),
            
            VirtualGoodPurchase(imageUrl: "Icon-1024", title: "Gems to Diamonds", description: "Exchanged 50 gems for 10 diamonds", virtualGood: VirtualGoodExchange.gem, forVirtualGood: VirtualGoodExchange.diamond, amount: 50, forAmount: 10),
            
            VirtualGoodPurchase(imageUrl: "Icon-1024", title: "Shield", description: "Buy a shield for 100 coins", virtualGood: VirtualGoodExchange.coin, forVirtualGood: VirtualGoodExchange.shield, amount: 100, forAmount: 1),
            
            VirtualGoodPurchase(imageUrl: "Icon-1024", title: "Sword", description: "Buy a sword for 100 gems", virtualGood: VirtualGoodExchange.gem, forVirtualGood: VirtualGoodExchange.sword, amount: 100, forAmount: 1)
        ]
        
    }
    
    fileprivate func setupBottomView() {
        stack(.vertical)(
            bottomViewDivider.insetting(by: UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)),
            Spacer()
            ).fillingParent().layout(in: bottomView)
        
        stack(.horizontal, spacing: 20)(
            stack(.vertical, spacing: 10)(
                Divider().vertical(.normal),
                button0,
                button1,
                button2,
                button3,
                button4,
                button5,
                Spacer()
            ),
            stack(.vertical, spacing: 10)(
                Divider().vertical(.normal),
                button6,
                button7,
                button8,
                Spacer()
            )
        ).centeringInParent().layout(in: bottomView)
    }
    
    // MARK:- Setup Views
    override func setupViews() {
        super.setupViews()
    }
    
    // MARK:- Observe
    override func observe() {
        super.observe()
        
        // MARK:- GIVE 100 COINS
        button0.reactive.tap.observeNext {
            VirtualGoodExchange.change(virtualGood: VirtualGoodExchange.coin, amount: 100, completion: { (result) in
                switch result {
                case .success(let exchageResult):
                    self.showAlert(for: exchageResult)
                case .failure(let err):
                    D_AlertController.showAlert(style: .alert, title: "Error", message: err.localizedDescription)
                }
            })
            }.dispose(in: bag)
        
        // MARK:- TAKE 50 COINS
        button1.reactive.tap.observeNext {
            VirtualGoodExchange.change(virtualGood: VirtualGoodExchange.coin, amount: -50, completion: { (result) in
                switch result {
                case .success(let exchageResult):
                    self.showAlert(for: exchageResult)
                case .failure(let err):
                    D_AlertController.showAlert(style: .alert, title: "Error", message: err.localizedDescription)
                }
            })
            }.dispose(in: bag)
        
        // MARK:- GIVE 1 SHIELD
        button2.reactive.tap.observeNext {
            VirtualGoodExchange.change(virtualGood: VirtualGoodExchange.shield, amount: 1, completion: { (result) in
                switch result {
                case .success(let exchageResult):
                    self.showAlert(for: exchageResult)
                case .failure(let err):
                    D_AlertController.showAlert(style: .alert, title: "Error", message: err.localizedDescription)
                }
            })
            }.dispose(in: bag)
        
        // MARK:- TAKE 1 SHIELD
        button3.reactive.tap.observeNext {
            VirtualGoodExchange.change(virtualGood: VirtualGoodExchange.shield, amount: -1, completion: { (result) in
                switch result {
                case .success(let exchageResult):
                    self.showAlert(for: exchageResult)
                case .failure(let err):
                    D_AlertController.showAlert(style: .alert, title: "Error", message: err.localizedDescription)
                }
            })
            }.dispose(in: bag)
        
        // MARK:- GIVE 3 SWORDS
        button4.reactive.tap.observeNext {
            VirtualGoodExchange.change(virtualGood: VirtualGoodExchange.sword, amount: 3, completion: { (result) in
                switch result {
                case .success(let exchageResult):
                    self.showAlert(for: exchageResult)
                case .failure(let err):
                    D_AlertController.showAlert(style: .alert, title: "Error", message: err.localizedDescription)
                }
            })
            }.dispose(in: bag)
        
        // MARK:- DELETE GEMS
        button5.reactive.tap.observeNext {
            VirtualGoodExchange.delete(virtualGood: VirtualGoodExchange.gem, completion: { (success) in
                if success {
                    D_AlertController.showAlert(style: .alert, title: "Success", message: "Successfully deleted")
                } else {
                    D_AlertController.showAlert(style: .alert, title: "Error", message: "Failed to delete")
                }
            })
            }.dispose(in: bag)
        
        // MARK:- CLEAR KEYCHAIN
        button6.reactive.tap.observeNext {
            VirtualGoodExchange.clear(completion: { (success) in
                if success {
                    D_AlertController.showAlert(style: .alert, title: "Success", message: "Successfully cleared keychain")
                } else {
                    D_AlertController.showAlert(style: .alert, title: "Error", message: "Failed to clear keychain")
                }
            })
            }.dispose(in: bag)
        
        // MARK:- RESET KEYCHAIN
        button7.reactive.tap.observeNext {
            VirtualGoodExchange.reset()
            }.dispose(in: bag)
        
        // MARK:- LOG KEYCHAIN
        button8.reactive.tap.observeNext {
            VirtualGoodExchange.logKeychainCurrentState()
            }.dispose(in: bag)
    }
    
    // MARK:- Bind
    override func bind() {
        super.bind()
    }
    
    // MARK:- Fetch Data Manually
    override func fetchData() {
        super.fetchData()
    }
    
    override func setupCell(_ cell: VirtualGoodExchangeCell) {
        super.setupCell(cell)
        // set up your cell with custom behavior
        cell.delegate = self
    }
    
}

extension VirtualGoodExchangeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.width
        return .init(width: width, height: 90)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        log.ln("Did tap row: \(indexPath.row)")/
    }
}

extension VirtualGoodExchangeViewController: VirtualGoodExchangeCellDelegate {
    open func didTapButton(_ tag: Int, cell: D_ListCell<VirtualGoodPurchase>) {
        guard let item = cell.item else { return }
        log.ln("Did tap button with tag: \(tag) in cell with item: \(item)")/
        
        switch tag {
        case 0:
            // MARK: - EXCHANGE
            log.ln("Exchange started...")/
            VirtualGoodExchange.exchange(virtualGood: item.virtualGood, amount: item.amount, forVirtualGood: item.forVirtualGood, forAmount: item.forAmount) { (result) in
                switch result {
                case .success(let exchageResult):
                    self.showAlert(for: exchageResult)
                case .failure(let err):
                    D_AlertController.showAlert(style: .alert, title: "Error", message: err.localizedDescription)
                }
            }
        default:
            log.warning("No such button tag")/
        }
    }
    
    func showAlert(for exchageResult: ExchangeResult) {
        switch exchageResult {
        case .insuficientFunds:
            D_AlertController.showAlert(style: .alert, title: "Error", message: "Insufficient Funds")
        case .nonConsumableIsOnlyOneItem:
            D_AlertController.showAlert(style: .alert, title: "Error", message: "You have only one item to change")
        case .nonConsumableAlreadyBought:
            D_AlertController.showAlert(style: .alert, title: "Error", message: "Item already bought")
        case .success:
            D_AlertController.showAlert(style: .alert, title: "Success", message: "Successfully exchanged")
        case .failure:
            D_AlertController.showAlert(style: .alert, title: "Error", message: "Failed to exchange")
        }
    }
}

