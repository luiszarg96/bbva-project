
import UIKit

class LoginFormVC: UIViewController {

    @IBOutlet weak var documentTypeTextField: UITextField!
    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var olvidasteTuClaveBtn: UIButton!
    @IBOutlet weak var recordarCredencialesLbl: UILabel!
    @IBOutlet weak var recordarCredencialesSwitch: UISwitch!
    @IBOutlet weak var ingresarBtn: UIButton!
    @IBOutlet weak var tokenDigitalBtn: UIButton!
    
    var isNumeric:Bool = false
    var selectedDocumentType: String?
    var documentTypes = ["documento","tarjeta o cuenta"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        main()
    }
    
    func main(){
        
        //add custom style to screen
        screenStyler()
        
        //add custom style to form textfields
        customizeTextFields()
        
        //get user credentials
        getCredentials()
        
        //create a dropdown pickerview
        createPickerView()
        
        //create a button to dismiss pickerview
        dismissPickerView()
        

        
    }
       
    func getCredentials(){
        if CredentialStorage.existCredentials() {
            let (documentType,account,password) = CredentialStorage.getCredentials()
            
            //fill telxtfields with credentials
            documentTypeTextField.text = documentType
            accountTextField.text = account
            passwordTextField.text = password
            
        }else{
        }
    }
    
    func customizeTextFields(){
        
        //delegate to this instance
        documentTypeTextField.delegate = self
        accountTextField.delegate = self
        passwordTextField.delegate = self
        
        //change the background color
        documentTypeTextField.backgroundColor = Styles.Colors.blueBgTextField
        accountTextField.backgroundColor = Styles.Colors.blueBgTextField
        passwordTextField.backgroundColor = Styles.Colors.blueBgTextField
        
        //set placeholder default value and text color
        accountTextField.attributedPlaceholder = NSAttributedString(string: "numero de \(documentTypes[0])",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "clave de acceso",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
         
        //secure text entry for password textfield
        passwordTextField.isSecureTextEntry = true
                
        //default value for document type
        documentTypeTextField.text = documentTypes[0]
        
        //create arrow icon
        let arrowIcon = createIcon(imageName: "arrow-down", posX: -15, posY: 0, iconWidth: 40, iconHeight: 40, renderMode: UIImage.RenderingMode.alwaysTemplate.rawValue, color: UIColor.white)

        //add arrow button to textfield
        let selectDocumentBtn = UIButton(type: .custom)
        selectDocumentBtn.addSubview(arrowIcon)
        documentTypeTextField.rightView = selectDocumentBtn
        documentTypeTextField.rightViewMode = .unlessEditing
        
        //create keyboard icon
        let keyboardIcon = createIcon(imageName: "image-key", posX: -15, posY: -5, iconWidth: 40, iconHeight: 40, renderMode: UIImage.RenderingMode.alwaysOriginal.rawValue, color: UIColor.white)

        //add keyboard button to textfield
        let keyboardTypeBtn = UIButton(type: .custom)
        keyboardTypeBtn.addSubview(keyboardIcon) //add icon in th e button
        keyboardTypeBtn.addTarget(self, action: #selector(self.changeKeyboardType), for: .touchUpInside)
        accountTextField.rightView = keyboardTypeBtn
        accountTextField.rightViewMode = .unlessEditing
        
    }
    
    func createIcon(imageName:String,posX:Int,posY:Int,iconWidth:Int,iconHeight:Int,renderMode:Int, color:UIColor) -> UIImageView {
    
        let icon = UIImageView(frame: CGRect(x: posX, y: posY, width: iconWidth, height: iconHeight))
        icon.image = UIImage(named:imageName)
        icon.image = icon.image?.withRenderingMode(UIImage.RenderingMode(rawValue: renderMode)!)
        icon.tintColor = UIColor.white
        return icon
        
    }
    
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        documentTypeTextField.inputView = pickerView
    }

    func dismissPickerView() {
       let toolBar = UIToolbar()
       toolBar.sizeToFit()
       let button = UIBarButtonItem(title: "Done" , style: .plain, target: self, action: #selector(self.setPlaceHolder))
        
       toolBar.setItems([button], animated: true)
       toolBar.isUserInteractionEnabled = true
       documentTypeTextField.inputAccessoryView = toolBar
    }
    
    @objc func setPlaceHolder() {
        view.endEditing(true)
        
        //change placeHolder
        var placeHolder = ""
        if documentTypeTextField.text == documentTypes[0] {
            placeHolder = "numero de \(documentTypes[0])"
        }else{
            placeHolder = "numero de \(documentTypes[1])"
        }
        accountTextField.placeholder = placeHolder
    }
    
    @objc func changeKeyboardType(){
        if isNumeric {
            accountTextField.keyboardType = .default
            isNumeric = false
            accountTextField.reloadInputViews()
        }else{
            accountTextField.keyboardType = .numberPad
            isNumeric = true
            accountTextField.reloadInputViews()
        }
        
    }
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    @IBAction func accederBtnTapped(_ sender: Any) {
        
        if documentTypeTextField.text!.isEmpty || accountTextField.text!.isEmpty || passwordTextField.text!.isEmpty{
            //show alert
            let alert = UIAlertController(title: "Error", message: "Complete todos los campos", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        
        if recordarCredencialesSwitch.isOn {
            CredentialStorage.saveCredentials(documentType: documentTypeTextField.text!, account: accountTextField.text!, password: passwordTextField.text!)
        }else{
            CredentialStorage.removeCredentials()
        }
        
    }
    
}

extension LoginFormVC: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 //number of session
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return documentTypes.count // number of dropdown items
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return documentTypes[row] // dropdown item
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedDocumentType = documentTypes[row] // selected
        documentTypeTextField.text = selectedDocumentType
        
    }

}

extension LoginFormVC{
    
    func screenStyler(){
        //set background color
        self.view.backgroundColor = Styles.Colors.blueBg1
        
        //set button backgraund
        ingresarBtn.backgroundColor = Styles.Colors.greenButton1
        tokenDigitalBtn.backgroundColor = Styles.Colors.blueButton2
        
        //add token icon
        let icon = UIImage(named: "iconmenusoftoken")!
        let tintedImage = icon.withRenderingMode(.alwaysTemplate)
        tokenDigitalBtn.setImage(tintedImage, for: .normal)
        tokenDigitalBtn.tintColor = .white
        tokenDigitalBtn.imageView?.contentMode = .scaleAspectFit
        tokenDigitalBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        
        //custmize navigation bar
        let logo = UIImage(named: "logo_login")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView //add logo
        self.navigationController?.navigationBar.barTintColor = Styles.Colors.blueBg1 //change background color
        
        //hide back button
        self.navigationItem.setHidesBackButton(true, animated: true);
        
        //set constraints
        setConstraints()
        
    }
    
    func setConstraints(){
        documentTypeTextField.translatesAutoresizingMaskIntoConstraints = false
        accountTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        recordarCredencialesLbl.translatesAutoresizingMaskIntoConstraints = false
        recordarCredencialesSwitch.translatesAutoresizingMaskIntoConstraints = false
        ingresarBtn.translatesAutoresizingMaskIntoConstraints = false
        tokenDigitalBtn.translatesAutoresizingMaskIntoConstraints = false
        olvidasteTuClaveBtn.translatesAutoresizingMaskIntoConstraints = false
       
       let constraints =  [
        documentTypeTextField.heightAnchor.constraint(equalToConstant: 50),
        documentTypeTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        documentTypeTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        documentTypeTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height*0.1),
        
        accountTextField.heightAnchor.constraint(equalToConstant: 50),
        accountTextField!.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        accountTextField!.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        accountTextField.topAnchor.constraint(equalTo: documentTypeTextField.bottomAnchor, constant: 12),
        
        passwordTextField.heightAnchor.constraint(equalToConstant: 50),
        passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        passwordTextField.topAnchor.constraint(equalTo: accountTextField.bottomAnchor, constant: 12),
        
        recordarCredencialesLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        recordarCredencialesLbl.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
        
        recordarCredencialesSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        recordarCredencialesSwitch.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
        
        ingresarBtn.heightAnchor.constraint(equalToConstant: 50),
        ingresarBtn.widthAnchor.constraint(equalToConstant: 150),
        ingresarBtn.topAnchor.constraint(equalTo: recordarCredencialesLbl.bottomAnchor, constant: view.frame.height*0.05),
        ingresarBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        
        tokenDigitalBtn.heightAnchor.constraint(equalToConstant: 50),
        tokenDigitalBtn.widthAnchor.constraint(equalToConstant: 150),
        tokenDigitalBtn.topAnchor.constraint(equalTo: ingresarBtn.bottomAnchor, constant: view.frame.height*0.05),
        tokenDigitalBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        
        olvidasteTuClaveBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
        olvidasteTuClaveBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor)]
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
}
