#!/usr/bin/env bash
#####################################################################
# Set various system settings for MacOS                             #
#####################################################################

source $SCRIPTS_DIR/_utils.sh

e_message "Setting System Preferences"

# close any open System Settings panes
killall "System Settings" 2> /dev/null

e_pending "Setting basic system preferences"

# set finder sidebar icons to small
defaults write NSGlobalDomain "NSTableViewDefaultSizeMode" -int "1"

# remove delay when hovering over titlebar in finder
defaults write NSGlobalDomain "NSToolbarTitleViewRolloverDelay" -float "0"

# increase window resize speed
defaults write NSGlobalDomain "NSWindowResizeTime" -float "0.001"

# expand save dialog by default
defaults write NSGlobalDomain "NSNavPanelExpandedStateForSaveMode" -bool true
defaults write NSGlobalDomain "NSNavPanelExpandedStateForSaveMode2" -bool true

# expand print dialog by default
defaults write NSGlobalDomain "PMPrintingExpandedStateForPrint" -bool true
defaults write NSGlobalDomain "PMPrintingExpandedStateForPrint2" -bool true

# save to disk (not to iCloud) by default
defaults write NSGlobalDomain "NSDocumentSaveNewDocumentsToCloud" -bool false

# disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices "LSQuarantine" -bool false

# disable automatic termination of inactive apps
defaults write NSGlobalDomain "NSDisableAutomaticTermination" -bool true

# set help viewer windows to non-floating mode
defaults write com.apple.helpviewer "DevMode" -bool true

# reveal ip address, hostname, os version when clicking the clock in the login window
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# increase sound quality for Bluetooth headphones/headsets
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int "40"

### KEYBOARD/MOUSE ##################################################
e_pending "Setting keyboard/mouse preferences"

# disable automatic capitalization as it’s annoying when typing code
defaults write NSGlobalDomain "NSAutomaticCapitalizationEnabled" -bool false

# disable smart dashes as they’re annoying when typing code
defaults write NSGlobalDomain "NSAutomaticDashSubstitutionEnabled" -bool false

# disable automatic period substitution as it’s annoying when typing code
defaults write NSGlobalDomain "NSAutomaticPeriodSubstitutionEnabled" -bool false

# disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain "NSAutomaticQuoteSubstitutionEnabled" -bool false

# enable full keyboard access for all controls
defaults write NSGlobalDomain "AppleKeyboardUIMode" -int "3"

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain "ApplePressAndHoldEnabled" -bool false

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain "KeyRepeat" -int "1"
defaults write NSGlobalDomain "InitialKeyRepeat" -int "15"

# Set language and text formats
defaults write NSGlobalDomain "AppleLanguages" -array "en"
defaults write NSGlobalDomain "AppleLocale" -string "en_US@currency=USD"
defaults write NSGlobalDomain "AppleMeasurementUnits" -string "Inches"
defaults write NSGlobalDomain "AppleMetricUnits" -bool false

# set mouse tracking speed higer than the maximum
defaults write -g com.apple.mouse.scaling -float 7.0

### POWER MANAGEMENT ################################################
e_pending "Setting power management preferences"

# Enable lid wakeup
sudo pmset -a lidwake 1

# Sleep the display after 30 minutes while charging
sudo pmset -c displaysleep 30

# Sleep the display after 15 minutes on battery
sudo pmset -b displaysleep 15

# Disable machine sleep while charging
sudo pmset -c sleep 0

# Set machine sleep to 30 minutes on battery
sudo pmset -b sleep 30

# Set standby delay to 24 hours (default is 1 hour)
sudo pmset -a standbydelay 86400

# hibernation mode
sudo pmset -a hibernatemode 0

### SCREEN ##########################################################
e_pending "Setting screen preferences"

# save screenshots to the desktop
defaults write com.apple.screencapture "location" -string "${HOME}/Desktop"

# save screenshots in PNG format
defaults write com.apple.screencapture "type" -string "png"

# enable subpixel font rendering on non-Apple LCDs
defaults write NSGlobalDomain "AppleFontSmoothing" -int "1"

# enable HiDPI display modes (requires restart)
sudo defaults write /Library/Preferences/com.apple.windowserver "DisplayResolutionEnabled" -bool true

### FINDER ##########################################################
e_pending "Setting finder preferences"

# allow quitting via ⌘ + Q; doing so will also hide desktop icons
defaults write com.apple.finder "QuitMenuItem" -bool true

# disable window animations and Get Info animations
defaults write com.apple.finder "DisableAllAnimations" -bool true

# set Desktop as the default location for new Finder windows
defaults write com.apple.finder "NewWindowTarget" -string "PfHm"
defaults write com.apple.finder "NewWindowTargetPath" -string "file://${HOME}"

# show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder "ShowExternalHardDrivesOnDesktop" -bool true
defaults write com.apple.finder "ShowHardDrivesOnDesktop" -bool true
defaults write com.apple.finder "ShowMountedServersOnDesktop" -bool true
defaults write com.apple.finder "ShowRemovableMediaOnDesktop" -bool true

# show hidden files by default
defaults write com.apple.finder "AppleShowAllFiles" -bool true

# show all filename extensions
defaults write NSGlobalDomain "AppleShowAllExtensions" -bool true

# show status bar
defaults write com.apple.finder "ShowStatusBar" -bool true

# show path bar
defaults write com.apple.finder "ShowPathbar" -bool true

# display full POSIX path as Finder window title
defaults write com.apple.finder "_FXShowPosixPathInTitle" -bool true

# keep folders on top when sorting by name
defaults write com.apple.finder "_FXSortFoldersFirst" -bool true

# when performing a search, search the current folder by default
defaults write com.apple.finder "FXDefaultSearchScope" -string "SCcf"

# disable the warning when changing a file extension
defaults write com.apple.finder "FXEnableExtensionChangeWarning" -bool false

# enable spring loading for directories
defaults write NSGlobalDomain "com.apple.springing.enabled" -bool true

# remove the spring loading delay for directories
defaults write NSGlobalDomain "com.apple.springing.delay" -float "0"

# avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices "DSDontWriteNetworkStores" -bool true
defaults write com.apple.desktopservices "DSDontWriteUSBStores" -bool true

# disable disk image verification
defaults write com.apple.frameworks.diskimages "skip-verify" -bool true
defaults write com.apple.frameworks.diskimages "skip-verify-locked" -bool true
defaults write com.apple.frameworks.diskimages "skip-verify-remote" -bool true

# automatically open a new finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages "auto-open-ro-root" -bool true
defaults write com.apple.frameworks.diskimages "auto-open-rw-root" -bool true
defaults write com.apple.finder "OpenWindowForNewRemovableDisk" -bool true

# show item info near icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist

# enable snap-to-grid for icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# increase grid spacing for icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist

# increase the size of icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 64" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:iconSize 64" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:iconSize 64" ~/Library/Preferences/com.apple.finder.plist

# use list view in all Finder windows by default
defaults write com.apple.finder "FXPreferredViewStyle" -string "Nlsv"

# disable the warning before emptying the Trash
defaults write com.apple.finder "WarnOnEmptyTrash" -bool false

# enable AirDrop over Ethernet and on unsupported Macs running Lion
defaults write com.apple.NetworkBrowser "BrowseAllInterfaces" -bool true

# show the ~/Library folder
chflags nohidden ~/Library

# show the /Volumes folder
sudo chflags nohidden /Volumes

# expand the following File Info panes:
# “General”, “Open with”, and “Sharing & Permissions”
defaults write com.apple.finder "FXInfoPanesExpanded" -dict \
	General -bool true \
	OpenWith -bool true \
	Privileges -bool true

### DOCK AND DASHBOARD ##############################################
e_pending "Setting dock preferences"

# enable highlight hover effect for the grid view of a stack (Dock)
defaults write com.apple.dock "mouse-over-hilite-stack" -bool true

# set the icon size of Dock items to 64 pixels
defaults write com.apple.dock "tilesize" -int "64"

# change minimize/maximize window effect
defaults write com.apple.dock "mineffect" -string "genie"

# show indicator lights for open applications in the Dock
defaults write com.apple.dock "show-process-indicators" -bool true

# speed up Mission Control animations
defaults write com.apple.dock "expose-animation-duration" -float "0.1"

# don’t group windows by application in Mission Control
defaults write com.apple.dock "expose-group-by-app" -bool false

# don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock "mru-spaces" -bool false

# don’t show recent applications in Dock
defaults write com.apple.dock "show-recents" -bool false

### SAFARI ##########################################################
e_pending "Setting safari preferences"

# Privacy: don’t send search queries to Apple
defaults write com.apple.Safari "UniversalSearchEnabled" -bool false
defaults write com.apple.Safari "SuppressSearchSuggestions" -bool true

# press Tab to highlight each item on a web page
defaults write com.apple.Safari "WebKitTabToLinksPreferenceKey" -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks" -bool true

# show the full URL in the address bar (note: this still hides the scheme)
defaults write com.apple.Safari "ShowFullURLInSmartSearchField" -bool true

# prevent Safari from opening ‘safe’ files automatically after downloading
defaults write com.apple.Safari "AutoOpenSafeDownloads" -bool false

# hide Safari’s bookmarks bar by default
defaults write com.apple.Safari "ShowFavoritesBar" -bool false

# hide Safari’s sidebar in Top Sites
defaults write com.apple.Safari "ShowSidebarInTopSites" -bool false

# disable Safari’s thumbnail cache for History and Top Sites
defaults write com.apple.Safari "DebugSnapshotsUpdatePolicy" -int "2"

# enable Safari’s debug menu
defaults write com.apple.Safari "IncludeInternalDebugMenu" -bool true

# make Safari’s search banners default to Contains instead of Starts With
defaults write com.apple.Safari "FindOnPageMatchesWordStartsOnly" -bool false

# remove useless icons from Safari’s bookmarks bar
defaults write com.apple.Safari "ProxiesInBookmarksBar" "()"

# enable the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari "IncludeDevelopMenu" -bool true
defaults write com.apple.Safari "WebKitDeveloperExtrasEnabledPreferenceKey" -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true

# add a context menu item for showing the Web Inspector in web views
defaults write NSGlobalDomain "WebKitDeveloperExtras" -bool true

# enable continuous spellchecking
defaults write com.apple.Safari "WebContinuousSpellCheckingEnabled" -bool true
# disable auto-correct
defaults write com.apple.Safari "WebAutomaticSpellingCorrectionEnabled" -bool false

# warn about fraudulent websites
defaults write com.apple.Safari "WarnAboutFraudulentWebsites" -bool true

# disable Java
defaults write com.apple.Safari "WebKitJavaEnabled" -bool false
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled" -bool false
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabledForLocalFiles" -bool false

# enable “Do Not Track”
defaults write com.apple.Safari "SendDoNotTrackHTTPHeader" -bool true

# update extensions automatically
defaults write com.apple.Safari "InstallExtensionUpdatesAutomatically" -bool true

### MAIL ############################################################
e_pending "Setting mail preferences"

# Copy email addresses as `foo@example.com` instead of `Foo Bar <foo@example.com>` in Mail.app
defaults write com.apple.mail "AddressesIncludeNameOnPasteboard" -bool false

# Add the keyboard shortcut ⌘ + Enter to send an email in Mail.app
defaults write com.apple.mail "NSUserKeyEquivalents" -dict-add "Send" "@\U21a9"

# Display emails in threaded mode, sorted by date (newest at the top)
defaults write com.apple.mail "DraftsViewerAttributes" -dict-add "DisplayInThreadedMode" -string "yes"
defaults write com.apple.mail "DraftsViewerAttributes" -dict-add "SortedDescending" -string "yes"
defaults write com.apple.mail "DraftsViewerAttributes" -dict-add "SortOrder" -string "received-date"

### SPOTLIGHT #######################################################
e_pending "Setting spotlight preferences"

# configure spotlight search results
defaults write com.apple.spotlight orderedItems -array \
        '{"enabled" = 1;"name" = "APPLICATIONS";}' \
        '{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
        '{"enabled" = 1;"name" = "DIRECTORIES";}' \
        '{"enabled" = 1;"name" = "PDF";}' \
        '{"enabled" = 1;"name" = "FONTS";}' \
        '{"enabled" = 1;"name" = "DOCUMENTS";}' \
        '{"enabled" = 1;"name" = "MESSAGES";}' \
        '{"enabled" = 1;"name" = "CONTACT";}' \
        '{"enabled" = 0;"name" = "EVENT_TODO";}' \
        '{"enabled" = 1;"name" = "IMAGES";}' \
        '{"enabled" = 0;"name" = "BOOKMARKS";}' \
        '{"enabled" = 0;"name" = "MUSIC";}' \
        '{"enabled" = 0;"name" = "MOVIES";}' \
        '{"enabled" = 0;"name" = "PRESENTATIONS";}' \
        '{"enabled" = 0;"name" = "SPREADSHEETS";}' \
        '{"enabled" = 0;"name" = "SOURCE";}' \
        '{"enabled" = 1;"name" = "MENU_DEFINITION";}' \
        '{"enabled" = 0;"name" = "MENU_OTHER";}' \
        '{"enabled" = 1;"name" = "MENU_CONVERSION";}' \
        '{"enabled" = 1;"name" = "MENU_EXPRESSION";}' \
        '{"enabled" = 0;"name" = "MENU_WEBSEARCH";}' \
        '{"enabled" = 0;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}'

# load new settings before rebuilding the index
killall mds > /dev/null 2>&1
# make sure indexing is enabled for the main volume
sudo mdutil -i on / > /dev/null
# rebuild the index from scratch
sudo mdutil -E / > /dev/null

### TERMINAL ########################################################
e_pending "Setting terminal/iterm preferences"

# only use UTF-8 in Terminal.app
defaults write com.apple.terminal "StringEncodings" -array 4

# enable Secure Keyboard Entry in Terminal.app
defaults write com.apple.terminal "SecureKeyboardEntry" -bool true

# disable the annoying line marks
defaults write com.apple.Terminal "ShowLineMarks" -int "0"

# don’t display the annoying prompt when quitting iTerm
defaults write com.googlecode.iterm2 "PromptOnQuit" -bool false

# add profile to iTerm
mkdir -p ~/Library/Application\ Support/iTerm2/DynamicProfiles
cp $BASE_DIR/configs/iterm-profile.json ~/Library/Application\ Support/iTerm2/DynamicProfiles/
defaults write com.googlecode.iterm2 "Default Bookmark Guid" -string "770EF310-C50E-49E6-A00F-4B7FCF5BF56C"

# use minimal theme
defaults write com.googlecode.iterm2 "TabStyleWithAutomaticOption" -int "5"
defaults write com.googlecode.iterm2 "HideTab" -int "0"
defaults write com.googlecode.iterm2 "TabViewType" -int "0"
defaults write com.googlecode.iterm2 "StretchTabsToFillBar" -int "1"
defaults write com.googlecode.iterm2 "StatusBarPosition" -int "1"
defaults write com.googlecode.iterm2 "ShowFullScreenTabBar" -int "1"
defaults write com.googlecode.iterm2 "UseBorder" -int "0"

### TYPORA ##########################################################
if has_app "Typora"; then
	e_pending "Setting typora preferences"
	defaults write abnerworks.Typora "theme" -string "Github"
	defaults write abnerworks.Typora "send_usage_info" -bool false
	defaults write abnerworks.Typora "use_seamless_window" -bool true
fi

### TIME MACHINE ####################################################
e_pending "Setting time machine preferences"

# prevent Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine "DoNotOfferNewDisksForBackup" -bool true

# disable local Time Machine backups
# hash tmutil &> /dev/null && sudo tmutil disable

### ACTIVITY MONITOR ################################################
e_pending "Setting activity monitor preferences"

# show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor "OpenMainWindow" -bool true

# visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor "IconType" -int "5"

# show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor "ShowCategory" -int "0"

# sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor "SortColumn" -string "CPUUsage"
defaults write com.apple.ActivityMonitor "SortDirection" -int "0"

### TEXTEDIT ########################################################
e_pending "Setting textedit preferences"

# use plain text mode for new TextEdit documents
defaults write com.apple.TextEdit "RichText" -int "0"

# open and save files as UTF-8 in TextEdit
defaults write com.apple.TextEdit "PlainTextEncoding" -int "4"
defaults write com.apple.TextEdit "PlainTextEncodingForWrite" -int "4"

### APP STORE #######################################################
e_pending "Setting app store preferences"

# enable the automatic update check
defaults write com.apple.SoftwareUpdate "AutomaticCheckEnabled" -bool true

# check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate "ScheduleFrequency" -int "1"

# download newly available updates in background
defaults write com.apple.SoftwareUpdate "AutomaticDownload" -int "1"

# install System data files & security updates
defaults write com.apple.SoftwareUpdate "CriticalUpdateInstall" -int "1"

# turn on app auto-update
defaults write com.apple.commerce "AutoUpdate" -bool true

# allow the App Store to reboot machine on macOS updates
defaults write com.apple.commerce "AutoUpdateRestartRequired" -bool true

### PHOTOS ##########################################################
e_pending "Setting photos preferences"

# prevent Photos from opening automatically when devices are plugged in
defaults -currentHost write com.apple.ImageCapture "disableHotPlug" -bool true

### MESSAGES ########################################################
e_pending "Setting messages preferences"

# disable smart quotes as it’s annoying for messages that contain code
defaults write com.apple.messageshelper.MessageController "SOInputLineSettings" -dict-add "automaticQuoteSubstitutionEnabled" -bool false

### CHROME ##########################################################
e_pending "Setting chrome preferences"

# disable the all too sensitive backswipe on trackpads
defaults write com.google.Chrome "AppleEnableSwipeNavigateWithScrolls" -bool false
defaults write com.google.Chrome.canary "AppleEnableSwipeNavigateWithScrolls" -bool false

# disable the all too sensitive backswipe on Magic Mouse
defaults write com.google.Chrome "AppleEnableMouseSwipeNavigateWithScrolls" -bool false
defaults write com.google.Chrome.canary "AppleEnableMouseSwipeNavigateWithScrolls" -bool false

# expand the print dialog by default
defaults write com.google.Chrome "PMPrintingExpandedStateForPrint2" -bool true
defaults write com.google.Chrome.canary "PMPrintingExpandedStateForPrint2" -bool true

### MENU BAR ########################################################
e_pending "Setting menubar preferences"

# use digital clock
defaults write com.apple.menuextra.clock "IsAnalog" -bool false

# set clock format
defaults write com.apple.menuextra.clock "DateFormat" -string "EEE MMM d h:mm:ss a"

# update various clock options to match the above format
defaults write com.apple.menuextra.clock "ShowDayOfWeek" -bool true
defaults write com.apple.menuextra.clock "ShowDate" -int "1"
defaults write -g "AppleICUForce12HourTime" -bool true
defaults write com.apple.menuextra.clock "Show24Hour" -bool false
defaults write com.apple.menuextra.clock "ShowSeconds" -bool true
defaults write com.apple.menuextra.clock "ShowAMPM" -bool true
defaults write com.apple.menuextra.clock "FlashDateSeparators" -bool false

# show battery percentage
defaults write com.apple.menuextra.battery "ShowPercent" -string "yes"
defaults -currentHost write com.apple.controlcenter "BatteryShowPercentage" -bool true

# show certain icons in the menu bar
defaults -currentHost write com.apple.controlcenter.plist "Bluetooth" -int "2"
defaults -currentHost write com.apple.controlcenter.plist "NowPlaying" -int "18"
defaults -currentHost write com.apple.controlcenter.plist "ScreenMirroring" -int "18"
defaults -currentHost write com.apple.controlcenter.plist "Sound" -int "18"
defaults -currentHost write com.apple.controlcenter.plist "FocusModes" -int "18"


### RESTART APPLICATIONS ############################################
e_pending "All preferences set, restarting applications"

for app in "Activity Monitor" \
	"Address Book" \
	"Calendar" \
	"cfprefsd" \
	"Contacts" \
	"Dock" \
	"Finder" \
	"Mail" \
	"Messages" \
	"Opera" \
	"Photos" \
	"Safari" \
	"SystemUIServer" \
  "ControlCenter" \
	"iCal"; do
	e_pending "Restarting ${app}"
	killall "${app}" &> /dev/null
done


### DONE ############################################################

e_success "Completed setting MacOS preferences"
