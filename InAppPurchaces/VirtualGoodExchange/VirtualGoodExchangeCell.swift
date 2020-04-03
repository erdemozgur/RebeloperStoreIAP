//
//  VirtualGoodExchangeCell.swift
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

protocol VirtualGoodExchangeCellDelegate {
    func didTapButton(_ tag: Int, cell: D_ListCell<VirtualGoodPurchase>)
}

class VirtualGoodExchangeCell: D_ListCell<VirtualGoodPurchase> {
    
    // MARK:- Delegate
    var delegate: VirtualGoodExchangeCellDelegate?
    
    // MARK:- Item
    override var item: VirtualGoodPurchase! {
        didSet {
            // configure view with data
            titleLabel.text(item.title)
            descriptionLabel.text(item.description)
            
            imageView.setImage(from: item.imageUrl)
        }
    }
    
    // MARK:- Properties
    
    let buttonSize = CGSize(width: 110, height: 30)
    let imageViewSize = CGSize(width: 60, height: 60)
    
    // MARK:- Views
    
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    lazy var titleLabel = UILabel()
        .textAlignment(.left)
        .font(UIFont.boldSystemFont(ofSize: 18))
        .setMultiline()
    
    lazy var descriptionLabel = UILabel()
        .textAlignment(.left)
        .font(UIFont.systemFont(ofSize: 16))
        .text(D_Color.Xcode11.Light.gray2)
        .setMultiline()
    
    lazy var iapIdLabel = UILabel()
        .textAlignment(.left)
        .font(UIFont.systemFont(ofSize: 12))
        .setMultiline()
    
    lazy var button0 = UIButton()
        .text("EXCHANGE")
        .text(D_Color.Xcode11.Light.purple)
        .background(D_Color.Xcode11.Light.gray6)
        .font(UIFont.boldSystemFont(ofSize: 16))
        .corner(buttonSize.height / 2)
        .frame(buttonSize)
        .tag(0)
    
    let divider = UIView().setBackground(color: D_Color.Xcode11.Light.gray4).setHeight(0.4)
    
    // MARK:- Setup Views
    override func setupViews() {
        super.setupViews()
        // configure view layout
        Layoutless.stack(.vertical)(
            Layoutless.stack(.horizontal)(
                Layoutless.stack(.vertical)(
                    imageView.frame(imageViewSize).setCorner(10),
                    Spacer()
                ),
                Divider().horizontal(.normal),
                Layoutless.stack(.vertical)(
                    titleLabel,
                    descriptionLabel,
                    Divider().vertical(.extraSmall),
                    iapIdLabel,
                    Spacer()
                ),
                Divider().horizontal(.normal),
                Layoutless.stack(.vertical)(
                    Divider().vertical(.normal),
                    button0,
                    Spacer()
                )
            ),
            Spacer(),
            divider
            ).insetting(by: UIEdgeInsets(top: 12, left: 12, bottom: 0, right: 12)).fillingParent().layout(in: self)
        
    }
    
    // MARK:- Observe
    override func observe() {
        super.observe()
        button0.reactive.tap.observeNext { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.delegate?.didTapButton(strongSelf.button0.tag, cell: strongSelf)
            }.dispose(in: bag)
    }
    
    // MARK:- Bind
    override func bind() {
        super.bind()
    }
    
    // MARK:- Fetch Data Manually
    override func fetchData() {
        super.fetchData()
        // discouraged!!!
    }
    
}
