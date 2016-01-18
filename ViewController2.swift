import UIKit

class ViewController2: UIViewController {
    
    @IBOutlet weak var txtFilname: UITextField!
   // @IBOutlet weak var txt: UILabel!
    
    
    
        @IBAction func saveBtn(sender: AnyObject) {
       NSUserDefaults.standardUserDefaults().setObject(txtFilname.text, forKey: "name")
            
             self.performSegueWithIdentifier("segueIdentifier2", sender: self)
        }
        
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if NSUserDefaults.standardUserDefaults().objectForKey("name") == nil {
            txtFilname.text = ""
            
            
        }
        else {
            var name = NSUserDefaults.standardUserDefaults().objectForKey("name") as! String
            
            txtFilname.text = name
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
