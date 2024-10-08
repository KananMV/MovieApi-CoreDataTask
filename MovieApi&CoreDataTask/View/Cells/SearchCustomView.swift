import UIKit
import SnapKit
class SearchCustomView: UIView {
    lazy var textFieldView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.addSubview(textField)
        view.addSubview(imageView)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(named: "lightGrayCustom")?.cgColor
        view.layer.cornerRadius = 8
        return view
    }()
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search Movie"
        textField.borderStyle = .none
        textField.rightViewMode = .always
        textField.returnKeyType = .search
        return textField
    }()
    let imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "magnifyingglass")
        image.tintColor = .black
        return image
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(textFieldView)
        setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    func setup(){
        textFieldView.snp.makeConstraints{make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        textField.snp.makeConstraints{make in
            make.leading.equalTo(imageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        imageView.snp.makeConstraints{make in
            make.centerY.equalTo(textField.snp.centerY)
            make.width.equalTo(20)
            make.height.equalTo(20)
            make.leading.equalToSuperview().offset(10)
        }
    }
}


