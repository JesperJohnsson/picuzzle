//
//  ChooseModeViewController.swift
//  picuzzle
//
//  Created by Jesper Johnsson on 2016-11-28.
//  Copyright © 2016 Jesper Johnsson. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class ChooseModeViewController: UIViewController, MCSessionDelegate,MCBrowserViewControllerDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var peerID: MCPeerID!
    var mcSession: MCSession!
    var mcAdvertiserAssistant: MCAdvertiserAssistant!
    
    var messageCl: Message!
    
    @IBOutlet weak var timeAttackBtn: UIButton!
    @IBOutlet weak var timeTrialBtn: UIButton!
    @IBOutlet weak var multiplayerLocalBtn: UIButton!
    @IBOutlet weak var multiplayerOnlineBtn: UIButton!
    
    @IBAction func multiOnlineAction(_ sender: Any) {
        self.showConnectionPrompt()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        peerID = MCPeerID(displayName: UIDevice.current.name)
        mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .optional)
        mcSession.delegate = self
        self.messageCl = Message()

    }
    
    /* START SESSION */
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL, withError error: Error?) {
        
    }
    
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)
    }
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case MCSessionState.connected:
            print("Connecteds: \(peerID.displayName)")
            self.messageCl.setMessage(message: "Evert")
            //performSegue(withIdentifier: "Lobby", sender: nil)
        case MCSessionState.connecting:
            print("Connecting: \(peerID.displayName)")
        case MCSessionState.notConnected:
            print("Not Connected: \(peerID.displayName)")
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        
        //let dictionary: [String: AnyObject] = ["data": data as AnyObject, "fromPeer": peerID]
        
        let dictionary: Dictionary? = NSKeyedUnarchiver.unarchiveObject(with: data) as! [String : Any]
        print(dictionary)
        
        print(dictionary)
        if (data != nil) {
            DispatchQueue.main.async { [unowned self] in
                // do something with the image
                print(data)
            }
        }
    }
    
    func startHosting(action: UIAlertAction!) {
        mcAdvertiserAssistant = MCAdvertiserAssistant(serviceType: "Connection", discoveryInfo: nil, session: mcSession)
        mcAdvertiserAssistant.start()
        performSegue(withIdentifier: "Lobby", sender: nil)
    }
    
    func joinSession(action: UIAlertAction!) {
        let mcBrowser = MCBrowserViewController(serviceType: "Connection", session: mcSession)
        mcBrowser.delegate = self
        present(mcBrowser, animated: true)
    }
    func showConnectionPrompt(){
        let ac = UIAlertController(title: "Connect to athoers", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Host a session",style: .default,handler:startHosting))
        ac.addAction(UIAlertAction(title: "Join a session",style: .default,handler:joinSession))
        ac.addAction(UIAlertAction(title: "Cancel",style: .cancel, handler:nil))
        present(ac,animated:true,completion: nil)
    }
    
    /* END SESSION */
    
    @IBAction func timeAttackBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "GameViewController", sender: "Time Attack")
    }
    
    @IBAction func timeTrialBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "GameViewController", sender: "Time Trial")
    }
    
    @IBAction func multiplayerLocalBtnPressed(_ sender: Any) {
    }
    
    @IBAction func multiplayerOnlineBtnPressed(_ sender: Any) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? GameViewController {
            
            if let mode = sender as? String {
                destination.selectedMode = mode
            }
        }
        if let destination = segue.destination as? LobbyViewController {
            destination.peerID = self.peerID
            destination.mcSession = self.mcSession
            destination.mcAdvertiserAssistant = self.mcAdvertiserAssistant
            destination.messageCl = self.messageCl
            destination.test = "dasd"
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showNavigation()
    }
    
    func showNavigation() {
        self.navigationController?.navigationBar.isHidden = false
    }
}
