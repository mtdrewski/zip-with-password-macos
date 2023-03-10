repeat
	set zip_password to text returned of (display dialog "Please enter password for the zip file" default answer "" with hidden answer)
	if (zip_password ≠ "") then
		exit repeat
	else
		set prompt_text to "Password cannot be empty. Please enter password for the zip file"
	end if
end repeat

tell application "Finder"
	set selected_items to selection
	set items_to_zip to ""
	repeat with each_item in selected_items
		set each_item_alias to each_item as alias
		set item_name to name of each_item_alias
		set item_name to quoted form of (item_name & "")
		set items_to_zip to items_to_zip & item_name & " "
	end repeat
	set first_item to (item 1 of selected_items) as alias
	set containing_folder to POSIX path of (container of first_item as alias)
	set zip_name to text returned of (display dialog "Enter the zip file name (without the .zip extension)" default answer "")
	set zip_file_name to quoted form of (zip_name & ".zip")
end tell

do shell script "cd '" & containing_folder & "'; zip -x .DS_Store -r0 -P '" & zip_password & "' " & zip_file_name & " " & items_to_zip