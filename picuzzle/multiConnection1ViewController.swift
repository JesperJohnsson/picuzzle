//
//  multiConnection1ViewController.swift
//  picuzzle
//
//  Created by dipt on 2016-12-06.
//  Copyright © 2016 Jesper Johnsson. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class multiconnection1ViewController: UIViewController,MCSessionDelegate,MCBrowserViewControllerDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    
        
        
        var peerID: MCPeerID!
    
        var mcSession: MCSession!
        var mcAdvertiserAssistant: MCAdvertiserAssistant!
        
        
        @IBOutlet weak var connectelr: UITextField!
        
        @IBOutlet weak var skickaTxt: UIButton!
    
        
    
        override func viewDidLoad() {
            super.viewDidLoad()
            self.navigationController?.navigationBar.isHidden=false
            // Do any additional setup after loading the view, typically from a nib.
            peerID = MCPeerID(displayName: UIDevice.current.name)
            mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .optional)
            mcSession.delegate = self
            title = "Connect"
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(multiconnection1ViewController.showConnectionPrompt))
            
            
        }
   
        
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
                print("Connected: \(peerID.displayName)")
                connectelr.text = "Connected"
                
                
            case MCSessionState.connecting:
                print("Connecting: \(peerID.displayName)")
                connectelr.text = "Connecting"
            case MCSessionState.notConnected:
                print("Not Connected: \(peerID.displayName)")
                
            }
        }
        func sendText(String: String) {
            if mcSession.connectedPeers.count > 0 {
                connectelr.text = "Skickade over"
                print("Funkar fan")
                
            }
        }
        func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
           
                  
                   
            }
    
        func startHosting(action: UIAlertAction!) {
            mcAdvertiserAssistant = MCAdvertiserAssistant(serviceType: "Connection", discoveryInfo: nil, session: mcSession)
            mcAdvertiserAssistant.start()
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
        
        
        
        
        
}
