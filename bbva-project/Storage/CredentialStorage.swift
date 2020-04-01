
import Foundation


class CredentialStorage{
    
    class func existCredentials() -> Bool{
        let defaults = UserDefaults.standard
        let documentType = defaults.string(forKey: "documentType")
        let account = defaults.string(forKey: "account")
        let password = defaults.string(forKey: "password")

        return documentType != nil && account != nil && password != nil
     
    }
    
    class func getCredentials() -> (String,String,String){
        let defaults = UserDefaults.standard
        let documentType = defaults.string(forKey: "documentType")
        let account = defaults.string(forKey: "account")
        let password = defaults.string(forKey: "password")

        return (documentType!,account!,password!)
    }

    class func saveCredentials(documentType:String,account:String,password:String) -> Void{
        //save credentials
        let defaults = UserDefaults.standard
        defaults.set(documentType, forKey: "documentType")
        defaults.set(account, forKey: "account")
        defaults.set(password, forKey: "password")
    }
    
    class func removeCredentials(){
        //save credentials
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "documentType")
        defaults.removeObject(forKey: "account")
        defaults.removeObject(forKey: "password")
    }

    
}
