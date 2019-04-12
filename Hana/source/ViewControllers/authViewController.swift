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


class authViewController: BaseViewController, GIDSignInUIDelegate, GIDSignInDelegate, FBSDKLoginButtonDelegate {
  let googleSignButton = GIDSignInButton()
  let facebookSignButton = FBSDKLoginButton()
  let logoImage = UIImage(named: "logo")
  var logoImageView = UIImageView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    GIDSignIn.sharedInstance().uiDelegate = self
    GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
    GIDSignIn.sharedInstance().delegate = self
    facebookSignButton.delegate = self
    logoImage?.resized(newSize: CGSize(width: UIScreen.main.bounds.width, height: 150))
    logoImageView = UIImageView(image: logoImage)
    
    view.addSubview(logoImageView)
    view.addSubview(googleSignButton)
    view.addSubview(facebookSignButton)
  }

  override func setupConstraints() {
    super.setupConstraints()
    logoImageView.snp.makeConstraints { (make) in
//      make.center.equalTo()
    }
//    logoImageView.snp.makeConstraints { (make) in
//      make.center.equalToSuperview()
//    }
    
    googleSignButton.snp.makeConstraints { (make) in
      make.top.equalTo(logoImageView.snp_bottom)
      make.leading.equalToSuperview()
    }
  }
  
  func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
    if let error = error {
      print(error.localizedDescription)
      return
    }
  }
  
  func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
    
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


