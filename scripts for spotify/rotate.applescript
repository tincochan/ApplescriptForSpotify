tell application "System Events"
	set desktopList to a reference to every desktop
	if ((count desktopList) > 1) then
		set displayList to {}
		repeat with x from 1 to (count desktopList)
        		set end of displayList to display name of item x of desktopList
    		end repeat
		set targetDisplay to choose from list displayList with prompt "Select a Display to rotate:" default items item 1 of displayList
	else
		set targetDisplay to display name of item 1 of desktopList
	end if
end tell

set targetRot to "90°"

tell application "System Preferences"
	activate
	set current pane to pane "com.apple.preference.displays"
	tell application "System Events"
		tell process "System Preferences"
			tell window targetDisplay
				set oldval to value of pop up button "Rotation:" of tab group 1
				if oldval is not equal to targetRot then
					click pop up button "Rotation:" of tab group 1
					click menu item targetRot of menu of pop up button "Rotation:" of tab group 1
					delay 2
					click button "Confirm" of sheet 1
				end if
			end tell
		end tell
	end tell
end tell

tell application "System Preferences"
	quit
end tell
