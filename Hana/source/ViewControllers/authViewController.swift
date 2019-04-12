//
//  authViewController.swift
//  Hana
//
//  Created by 김연준 on 11/04/2019.
//  Copyright © 2019 hanahnh. All rights reserved.
//

import GoogleSignIn
import Firebase
import FirebaseAuth
import FBSDKCoreKit
import FBSDKLoginKit
import MaterialComponents


class authViewController: BaseViewController, GIDSignInUIDelegate, GIDSignInDelegate {
  
  //MARK : UI
  let googleSignButton = MDCButton()
  let facebookSignButton = MDCButton()
  let logoImage = UIImage(named: "logo")
  var logoImageView = UIImageView()
  
 //MARK
  let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    GIDSignIn.sharedInstance().uiDelegate = self
    GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
    GIDSignIn.sharedInstance().delegate = self
    
    FBSDKSettings.setAppID("416188225876773")
    
    logoImage?.resized(newSize: CGSize(width: UIScreen.main.bounds.width, height: 150))
    logoImageView = UIImageView(image: logoImage)
    
    view.addSubview(logoImageView)
    view.addSubview(googleSignButton)
    view.addSubview(facebookSignButton)
  }
  
  override func customise() {
    super.customise()
    
    let gradient = CAGradientLayer()
    gradient.frame = view.bounds
    gradient.colors = [UIColor.appColor.PrimaryDark.cgColor, UIColor.appColor.defaultAndroidColor.cgColor]
    view.layer.insertSublayer(gradient, at: 0)

    googleSignButton.setTitle("SIGN IN WITH GOOGLE", for: .normal)
    googleSignButton.backgroundColor = UIColor.appColor.Accent
    googleSignButton.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 20)
    
    googleSignButton.rx.tap.subscribe(onNext: {
      GIDSignIn.sharedInstance().signIn()
    }).disposed(by: disposeBag)
    
    facebookSignButton.setTitle("SIGN IN WITH FACEBOOK", for: .normal)
    facebookSignButton.backgroundColor = UIColor.appColor.Accent
    facebookSignButton.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 20)
    
    facebookSignButton.rx.tap.subscribe(onNext: {
      self.fbLoginManager.logIn(withReadPermissions: ["email", "public_profile"], from: self) { (result, error) -> Void in
        if (error == nil){
          let fbloginresult : FBSDKLoginManagerLoginResult = result!
          if (result?.isCancelled)!{
            return
          }
          if(fbloginresult.grantedPermissions.contains("email")){
            self.getFBUserData()
          }
        }
      }
    }).disposed(by: disposeBag)
  }

  override func setupConstraints() {
    super.setupConstraints()
    logoImageView.snp.makeConstraints { (make) in
      make.top.equalToSuperview().offset(logoImage!.size.height)
      make.centerX.equalToSuperview()
    }
    
    googleSignButton.snp.makeConstraints { (make) in
      make.top.equalTo(logoImageView.snp_bottom).offset(logoImage!.size.height)
      make.leading.equalToSuperview().offset(5)
      make.trailing.equalToSuperview().offset(-5)
    }
    
    facebookSignButton.snp.makeConstraints { (make) in
      make.top.equalTo(googleSignButton.snp_bottom).offset(googleSignButton.frame.height)
      make.leading.equalToSuperview().offset(5)
      make.trailing.equalToSuperview().offset(-5)
    }
  }
  
  func getFBUserData(){
    if let current = FBSDKAccessToken.current() {
      let credential = FacebookAuthProvider.credential(withAccessToken: current.tokenString)
      Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
        if let error = error {
          // ...
          return
        }
        // User is signed in
        // ...
      }
    }
  }
  
  
  func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
    if let error = error {
      print(error)
      return
    }
    guard let authentication = user.authentication else { return }
    let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
    
//    Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
//      if let error = error {
//        print(error)
//        return
//      }
//      
//    }
  }
  
  func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
    // Perform any operations when the user disconnects from app here.
    // ...
  }

}


