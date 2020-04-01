import UIKit

class WelcomePageVC: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var accederBtn: UIButton!
    
    let imagesArray = ["microsoftoken-1","micronovedadesabril01"]
    let titlesArray = ["Token Digital","Transferencias Múltiples"]
    let descriptionsArray = ["Es la forma mas rápida y segura de confirmar tus operaciones en la banca móvil o web BBVA. Con Token Dgital ya no necesitaras recordar nunguna clave ni esperar un SMS. Solo necesitas tu celular y la App BBVA","Enviá y solicitá dinero a uno o más contactos de tu celular sin la necesidad de tener el número de cuenta"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        main()
    }
    
    func main(){
       
        //show login if this screen was already showed
        showLogin()
        
        //asign this controller instance to scrollview delegate
        scrollView.delegate = self
        
        //enable pagination scrolling
        scrollView.isPagingEnabled = true
                
        //set number of pages
        pageControl.numberOfPages = titlesArray.count
        
        //add custom style to screen
        screenStyler()
        
        //fill the scrollView
        fillScrollView()

    }
    
    func showLogin(){
        if WelcomePageShowed.wasShowed() {
            let loginFormVC = self.storyboard?.instantiateViewController(withIdentifier: "loginFormID") as! LoginFormVC
            show(loginFormVC, sender: nil)
        }
    }
    
    func screenStyler(){
        //set background color
        self.view.backgroundColor = Styles.Colors.blueBg2
        
        //set the main button
        accederBtn.backgroundColor = Styles.Colors.greenButton1
        
        //set text color
        accederBtn.setTitleColor(.white, for: .normal)
        
        //customize navigation bar
        self.navigationController?.navigationBar.barTintColor = Styles.Colors.blueBg2
        
        
    }
    
    func fillScrollView(){
        //fill the scroll view
        for i in 0..<titlesArray.count{
            
            //position in X axis for new view container
            let posX = CGFloat(i)*self.view.bounds.size.width
            
            //view Container
            let viewTemp = UIView()
            viewTemp.contentMode = .scaleToFill
            viewTemp.frame = CGRect(x: posX, y: 0, width: view.frame.size.width, height: scrollView.frame.size.height)
            //viewTemp.backgroundColor = colorArray[i]
                                   
            //image
            let imageView = UIImageView()
            imageView.contentMode = .scaleToFill
            imageView.image = UIImage(named:imagesArray[i])
            //imageView.frame = CGRect(x: 0, y: 0, width: 250, height: 250)
            //let color = UIColor(red:0.18, green:0.64, blue:0.64, alpha:1.00)
            //imageView.layer.borderColor = color.cgColor
            //imageView.layer.borderWidth = 1.0
            
            //title
            let titleLbl = UILabel()
            titleLbl.sizeToFit()
            titleLbl.numberOfLines = 0
            titleLbl.textColor = UIColor.white
            titleLbl.text = titlesArray[i]
            titleLbl.textAlignment = NSTextAlignment.center
            titleLbl.font = Styles.Fonts.beltonBold
            //titleLbl.frame = CGRect(x: 0, y: 0, width: 200, height: 21)
            //titleLbl.layer.borderColor = color.cgColor
            //titleLbl.layer.borderWidth = 1.0
            
            //description
            let descriptionLbl = UILabel()
            descriptionLbl.sizeToFit()
            descriptionLbl.numberOfLines = 0
            descriptionLbl.textColor = UIColor.white
            descriptionLbl.textAlignment = NSTextAlignment.center
            descriptionLbl.text = descriptionsArray[i]
            descriptionLbl.font = Styles.Fonts.beltonLight
            //titleLbl.frame = CGRect(x: 0, y: 0, width: 200, height: 21)
            //descriptionLbl.layer.borderColor = color.cgColor
            //descriptionLbl.layer.borderWidth = 1.0
            
            
            //add subViews to container
            viewTemp.addSubview(titleLbl)
            viewTemp.addSubview(imageView)
            viewTemp.addSubview(descriptionLbl)
            
            //constraints
            imageView.translatesAutoresizingMaskIntoConstraints = false
            titleLbl.translatesAutoresizingMaskIntoConstraints = false
            descriptionLbl.translatesAutoresizingMaskIntoConstraints = false
            
            let constraints = [
                imageView.topAnchor.constraint(equalTo: viewTemp.topAnchor, constant: 25),
                imageView.widthAnchor.constraint(equalToConstant: CGFloat(100)),
                imageView.heightAnchor.constraint(equalToConstant: CGFloat(100)),
                imageView.centerXAnchor.constraint(equalTo: viewTemp.centerXAnchor),
                
                titleLbl.centerXAnchor.constraint(equalTo: viewTemp.centerXAnchor),
                titleLbl.widthAnchor.constraint(equalToConstant: CGFloat(300)),
                titleLbl.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 25),
                
                descriptionLbl.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 25),
                descriptionLbl.leadingAnchor.constraint(equalTo: viewTemp.leadingAnchor, constant: 20),
                descriptionLbl.trailingAnchor.constraint(equalTo: viewTemp.trailingAnchor, constant: -20)
                
            ]

            NSLayoutConstraint.activate(constraints)

            //add view to the scrollview
            scrollView.contentSize.width = view.frame.size.width*CGFloat(i+1)
            scrollView.addSubview(viewTemp)
        }
                       
    }
        
    @IBAction func accederBtnTapped(_ sender: Any) {
    
        if WelcomePageShowed.wasShowed() {
            print("show next screen")
            
        }else{
            print("change flag value")
            WelcomePageShowed.setFlagValue()
        }
    
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x/scrollView.frame.width
        pageControl.currentPage = Int(page)
    }


}

