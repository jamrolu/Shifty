//
//  PrefShortcutsViewController.swift
//  Shifty
//
//  Created by Nate Thompson on 11/10/17.
//

import Cocoa
import MASPreferences
import MASShortcut

@objcMembers
class PrefShortcutsViewController: NSViewController, MASPreferencesViewController {
    
    let statusMenuController = (NSApplication.shared.delegate as? AppDelegate)?.statusMenu.delegate as? StatusMenuController
    
    override var nibName: NSNib.Name {
        get { return NSNib.Name("PrefShortcutsViewController") }
    }
    
    var viewIdentifier: String = "PrefShortcutsViewController"
    
    var toolbarItemImage: NSImage? {
        get { return NSImage(named: .computer)! }
    }
    
    var toolbarItemLabel: String? {
        get {
            view.layoutSubtreeIfNeeded()
            return "Shortcuts"
        }
    }
    
    var hasResizableWidth = false
    var hasResizableHeight = false
    
    @IBOutlet weak var toggleNightShiftShortcut: MASShortcutView!
    @IBOutlet weak var incrementColorTempShortcut: MASShortcutView!
    @IBOutlet weak var decrementColorTempShortcut: MASShortcutView!
    @IBOutlet weak var disableAppShortcut: MASShortcutView!
    @IBOutlet weak var disableHourShortcut: MASShortcutView!
    @IBOutlet weak var disableCustomShortcut: MASShortcutView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toggleNightShiftShortcut.associatedUserDefaultsKey = Keys.toggleNightShiftShortcut
        incrementColorTempShortcut.associatedUserDefaultsKey = Keys.incrementColorTempShortcut
        decrementColorTempShortcut.associatedUserDefaultsKey = Keys.decrementColorTempShortcut
        disableAppShortcut.associatedUserDefaultsKey = Keys.disableAppShortcut
        disableHourShortcut.associatedUserDefaultsKey = Keys.disableHourShortcut
        disableCustomShortcut.associatedUserDefaultsKey = Keys.disableCustomShortcut
        
        MASShortcutBinder.shared().bindShortcut(withDefaultsKey: Keys.toggleNightShiftShortcut) {
            self.statusMenuController?.power(self)
        }
        
        MASShortcutBinder.shared().bindShortcut(withDefaultsKey: Keys.incrementColorTempShortcut) {
            BLClient.setStrength(BLClient.strength + 0.1, commit: true)
        }
        
        MASShortcutBinder.shared().bindShortcut(withDefaultsKey: Keys.decrementColorTempShortcut) {
            BLClient.setStrength(BLClient.strength - 0.1, commit: true)
        }
        
        MASShortcutBinder.shared().bindShortcut(withDefaultsKey: Keys.disableAppShortcut) {
            self.statusMenuController?.disableForApp(self)
        }
        
        MASShortcutBinder.shared().bindShortcut(withDefaultsKey: Keys.disableHourShortcut) {
            self.statusMenuController?.disableHour(self)
        }
        
        MASShortcutBinder.shared().bindShortcut(withDefaultsKey: Keys.disableCustomShortcut) {
            self.statusMenuController?.disableCustomTime(self)
        }
    }
    
}
