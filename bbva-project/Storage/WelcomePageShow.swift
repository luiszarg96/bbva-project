import Foundation

class WelcomePageShowed{
    
    class func wasShowed()->Bool{
        
        let defaults = UserDefaults.standard
        return defaults.bool(forKey: "welcomePageShowed")
        
    }
    
    class func setFlagValue(){
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "welcomePageShowed")
    }
    
}
