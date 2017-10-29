//
//  ViewController.swift
//  Magneto1
//
//  Created by igmstu on 2/7/17.
//  Copyright © 2017 igmstu. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
   //IBOUTLETS: One for toolbar and other for trashcan
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var Trashcan: UIImageView!
    //Mark: Constants
    let wordSet = WordSets()
    let verticalspace:CGFloat = CGFloat(20.0)
    let horizontalspace:CGFloat = CGFloat(10.0)
    //Mark: IVARS
    var backgroundImage:UIImage?
    var positionx:CGFloat = 0.0
    var positiony:CGFloat = 0.0
    var changeheight:Bool = true
    var widthofscren:CGFloat!
    var prevcat:String = "welcome"
    var cat:String = MyAppData.shared.category
    var oldx:CGFloat!
    
       override func viewDidLoad() {
        super.viewDidLoad()
        let screenSize: CGRect = UIScreen.main.bounds
        //Mark: Some initilization of some ivars
        oldx = 0.0
        widthofscren = screenSize.width
        //Start off with beginning states, no saved data from previous states 
        //will load regular background, category but if not will load saved background, category
        placeWord(w:wordSet.getwordset(cat))
        backgroundImage = MyAppData.shared.img
        (self.view as! UIImageView).contentMode = .scaleAspectFill
        (self.view as! UIImageView).image = backgroundImage
        //Mark: Handle the toolbar & trashcan size depending on device
        switch UIDevice.current.userInterfaceIdiom{
        case .phone:
            toolBar.frame = CGRect(x: 0, y: view.frame.size.height-44, width: view.frame.size.width, height: 44)
            Trashcan.frame = CGRect(x: 7, y: view.frame.size.height-113, width: 56, height: 64)
            break
        case .pad:
            toolBar.frame = CGRect(x: 0, y: view.frame.size.height-64, width: view.frame.size.width, height: 64)
            Trashcan.frame = CGRect(x: 7, y: view.frame.size.height-153, width: 76, height: 84)
            break
        default:
            toolBar.frame = CGRect(x: 0, y: view.frame.size.height-44, width: view.frame.size.width, height: 44)
            Trashcan.frame = CGRect(x: 16, y: 614, width: 56, height: 64)
            break
        }

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
        
    }
    //MARK: - methods- 
    //Place words based on whatever string is passed
    func placeWord(w:[String])
    {

        clearWords()
        for word in w
        {
            let l = UILabel()
            l.backgroundColor = UIColor.white
            l.font = UIFont(name: "Didot", size: l.font.pointSize)
            l.text = word
            l.sizeToFit()
            l.frame.size.width = l.frame.size.width+20
            l.frame.size.height = l.frame.size.height+5
            l.textAlignment = NSTextAlignment.center
            //size of label
            //handle the font size and positioning on ipad mainly
            //had to force and increase space due to different font
            let xspace: CGFloat
            let yspace: CGFloat
            switch UIDevice.current.userInterfaceIdiom{
            case .phone:
                l.font = l.font.withSize(20)
                yspace = l.frame.size.height/2
                xspace = l.frame.size.width/2
                break
            case .pad:
                l.font = l.font.withSize(30)
                l.sizeToFit()
                l.frame.size.width = l.frame.size.width + 20
                l.frame.size.height = l.frame.size.height + 15
                yspace = l.frame.size.height/2 + 20
                xspace = l.frame.size.width/2 + 5
                break
            default:
                l.font = l.font.withSize(20)
                yspace = l.frame.size.height/2
                xspace = l.frame.size.width/2
                break
            }

            //check to see if we need to go to new row because of space
            positionx = positionx + horizontalspace + xspace + oldx
            
            if (positionx + xspace) > widthofscren
            {
                positionx = 0
                oldx = 0
                positionx = positionx + horizontalspace + xspace + oldx
                changeheight = true
                
            }
            //see if we need to vertically go to a new row
            if changeheight == true
            {
                positiony = positiony + verticalspace + yspace
                changeheight = false
            }
            l.center = CGPoint(x: positionx, y: positiony)
            oldx = xspace
            view.addSubview(l)
            let fireTime = DispatchTime.now() + .milliseconds(10)
            DispatchQueue.main.asyncAfter(deadline: fireTime){
                UIView.animate(withDuration: 0.6,
                           animations: {
                            l.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            },
                           completion: { _ in
                            UIView.animate(withDuration: 0.6) {
                                l.transform = CGAffineTransform.identity
                            }
            })
            }

            l.isUserInteractionEnabled = true
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(doPanGesture))
           
            l.addGestureRecognizer(panGesture)
            }//end of for loop
        
    }//end of placewords
    
    func clearWords(){
        //Remove the labels from view
        for v in view.subviews{
            if v is UILabel{
                v.removeFromSuperview()
            }
        }
    }
    //MARK: - helper method - Add photo based on category
        func addPhoto(cat:String){
        if(cat == "Heroic"){
            backgroundImage = UIImage(named: "backgroundknight.png")
            (self.view as! UIImageView).contentMode = .scaleAspectFill
            (self.view as! UIImageView).image = backgroundImage
            MyAppData.shared.img = backgroundImage!
        }
        else if(cat == "Knighthood"){
            backgroundImage = UIImage(named: "knighthood.png")
            (self.view as! UIImageView).contentMode = .scaleAspectFill
            (self.view as! UIImageView).image = backgroundImage
            MyAppData.shared.img = backgroundImage!
            
        }
        else if(cat == "War")
        {
            backgroundImage = UIImage(named: "war.png")
            (self.view as! UIImageView).contentMode = .scaleAspectFill
            (self.view as! UIImageView).image = backgroundImage
            MyAppData.shared.img = backgroundImage!
            
        }
        else if(cat == "Festival")
        {
            backgroundImage = UIImage(named: "festival.png")
            (self.view as! UIImageView).contentMode = .scaleAspectFill
            (self.view as! UIImageView).image = backgroundImage
            MyAppData.shared.img = backgroundImage!
            
        }
    }
    //MARK: -Helper method w/ imagePickerController -
    func imagePickerController(_ picker:UIImagePickerController, didFinishPickingMediaWithInfo info:[String:Any]){
        print("Finished picking")
        let image:UIImage = info[UIImagePickerControllerEditedImage] as! UIImage
        backgroundImage = image
        (self.view as! UIImageView).contentMode = .scaleAspectFill
        (self.view as! UIImageView).image = backgroundImage
        picker.dismiss(animated:true, completion:nil)
        MyAppData.shared.img = backgroundImage!
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("cancelled")
        picker.dismiss(animated:true, completion:nil)
    }
    //MARK: - GestureRecognizer - For dragging labels, contains animations, trashcan method, remove
    //labels
    func doPanGesture(panGesture:UIPanGestureRecognizer)
    {
        let label = panGesture.view as! UILabel
        let position = panGesture.location(in: view)
        label.center = position
        label.layer.borderWidth = 2.0
        label.layer.borderColor = UIColor.blue.cgColor
        //add border and animation when dragged
        if(panGesture.state == UIGestureRecognizerState.ended){
            label.layer.borderWidth = 1.0
            label.layer.borderColor = UIColor.white.cgColor
            
        }
        //if the label is close to the trashcan and the user lets go
        let x = label.center.x - self.Trashcan.center.x
        let y = label.center.y - self.Trashcan.center.y
        let xsquared = x * x
        let ysquared = y * y
        let distance = sqrt(xsquared+ysquared)
        if distance < CGFloat(55) && UIDevice.current.userInterfaceIdiom == .phone //phone
        {
            self.Trashcan.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 0.2).cgColor
            self.Trashcan.layer.cornerRadius = 5
            if panGesture.state == UIGestureRecognizerState.ended
            {
                label.removeFromSuperview()
                self.Trashcan.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 0.0).cgColor
            }
        }
        else if distance < CGFloat(80) && UIDevice.current.userInterfaceIdiom == .pad //ipad
        {
            self.Trashcan.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 0.2).cgColor
            self.Trashcan.layer.cornerRadius = 5
            if panGesture.state == UIGestureRecognizerState.ended
            {
                label.removeFromSuperview()
                self.Trashcan.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 0.0).cgColor
            }
        }
        else
        {
            self.Trashcan.layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0).cgColor
        }
        
        
        UIView.animate(withDuration: 0.6,
                       animations: {
                        label.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.6) {
                            label.transform = CGAffineTransform.identity
                        }
        })
        
    }

    //MARK: -Storyboard Action Methods-
    //Share pictures!!
    @IBAction func sharePic(_ sender: Any) {
        let image = self.view.takeSnapshot()
        let textToShare = "I dedicate thee a poem that will transcend the times!"
        let webSite = NSURL(string: "http://totallyawesome.com/")
        let objectsToShare:[AnyObject] = [textToShare as AnyObject, webSite!, image!]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities:nil)
        activityVC.excludedActivityTypes = [UIActivityType.print]
        //makes it that the app wont crash when it runs in ipad
        if UIDevice.current.userInterfaceIdiom == .pad {
            if activityVC.responds(to: #selector(getter: UIViewController.popoverPresentationController)) {
                activityVC.popoverPresentationController?.sourceView = view
            }
        }
        self.present(activityVC, animated:true, completion: nil)
    }
    //load photos from photolibrary!
        @IBAction func loadPhoto(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        //changed to select from photo library as a first choice instead of camera
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
            {
        imagePickerController.sourceType = .photoLibrary
            }
        else
            {
                imagePickerController.sourceType = .camera
            }
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        self.present(imagePickerController, animated:true, completion:{imageP in})
    }
       @IBAction func unwinding(segue:UIStoryboardSegue)
    {
            let themeVC = segue.source as! ThemeCategoryTVC
            MyAppData.shared.category = themeVC.selectedcategory
            let cat = MyAppData.shared.category
            //reset position values to starting state
            self.positionx = 0.0
            self.positiony = 0.0
            self.oldx = 0.0
            self.changeheight = true
            placeWord(w: wordSet.getwordset(cat))
            addPhoto(cat: cat)
      
    }
     //MARK: PRIVATE HELPER METHOD - hides status bar, put this in every view controller that you want status hidden
    override var prefersStatusBarHidden: Bool{
        return true
    }
}

