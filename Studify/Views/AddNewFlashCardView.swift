//
//  TableViewTextFieldCellTableViewCell.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/20/24.
//

import UIKit

class AddNewFlashCardView: UIView {
    
    var activeTextField: UITextView?

    lazy var verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.backgroundColor = UIColor.systemBackground
        stack.spacing = 20
        return stack
    }()
    lazy var stackScrollView: UIScrollView = {
        let stackScrollView = UIScrollView()
        stackScrollView.translatesAutoresizingMaskIntoConstraints = false
        return stackScrollView
        
    }()
    
    lazy var frontStringlabel: UILabel = configureLabel(text: "Term:")
    lazy var backStringLabel: UILabel = configureLabel(text: "Definition:")
    lazy var frontStringTextField: UITextView = configureTextField(placeholder: "Enter Term")
    lazy var backStringTextField: UITextView = configureTextField(placeholder: "Enter Definition")
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension AddNewFlashCardView{
    private func setup(){
        addSubview(stackScrollView)
        verticalStack.addArrangedSubview(frontStringlabel)
        verticalStack.addArrangedSubview(frontStringTextField)
        verticalStack.addArrangedSubview(backStringLabel)
        verticalStack.addArrangedSubview(backStringTextField)
        stackScrollView.addSubview(verticalStack)
        setupConstraints()
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            
            stackScrollView.topAnchor.constraint(equalTo: topAnchor),
            stackScrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackScrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackScrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
           
            verticalStack.topAnchor.constraint(equalTo: stackScrollView.contentLayoutGuide.topAnchor),
            verticalStack.leadingAnchor.constraint(equalTo: stackScrollView.contentLayoutGuide.leadingAnchor, constant: 10),
            verticalStack.trailingAnchor.constraint(equalTo: stackScrollView.contentLayoutGuide.trailingAnchor, constant: -10),
            verticalStack.bottomAnchor.constraint(equalTo: stackScrollView.contentLayoutGuide.bottomAnchor, constant: -10),
            verticalStack.widthAnchor.constraint(equalTo: stackScrollView.frameLayoutGuide.widthAnchor, constant: -20)
        ])
    }
}

extension AddNewFlashCardView{
    private func configureTextField(placeholder: String) -> UITextView{
        let textView = UITextView()
        textView.font = UIFont(name: "HelveticaNeue", size: 12)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.cornerRadius = 2
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.isScrollEnabled = false // Start with no scrolling
        textView.text = placeholder
        textView.textColor = UIColor.lightGray
        textView.backgroundColor = UIColor.white
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 10)
        textView.textAlignment = .left
        textView.delegate = self
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissKeyboard))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexSpace, doneButton], animated: false)
        textView.inputAccessoryView = toolbar  // Set the toolbar as input accessory view
        return textView
    }
    
    private func configureLabel(text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.text = text
        return label
    }
}

extension AddNewFlashCardView: UITextViewDelegate {
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        let keyboardHeight = keyboardFrame.height
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        
        stackScrollView.contentInset = contentInsets
        stackScrollView.scrollIndicatorInsets = contentInsets
        
        if let activeField = self.activeTextField {
            let contentRect = stackScrollView.convert(activeField.frame, from: activeField.superview)
            stackScrollView.scrollRectToVisible(contentRect, animated: true)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        stackScrollView.contentInset = .zero
        stackScrollView.scrollIndicatorInsets = .zero
    }
    
    
    @objc func dismissKeyboard() {
        endEditing(true)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.activeTextField = textView  // Assuming `activeTextField` is a property of your view controller
        
        if textView.text == "Enter Term" || textView.text == "Enter Definition" {
            // Clear the placeholder text and update the style for user input
            textView.text = ""
            textView.textColor = UIColor.black
            textView.font = UIFont(name: "HelveticaNeue", size: 15)
        } else {
            textView.textColor = UIColor.black
            textView.font = UIFont(name: "HelveticaNeue", size: 15)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            
            textView.text = textView == frontStringTextField ? "Enter Term" : "Enter Definition"
            //textView.textColor = UIColor.darkGray // Placeholder color
            textView.textColor = UIColor.lightGray
            textView.font = UIFont(name: "HelveticaNeue", size: 12)
        }
        
        textView.textColor = UIColor.darkGray // Placeholder color
        textView.font = UIFont(name: "HelveticaNeue", size: 12)
    }
}
   


