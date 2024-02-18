mode: dictation
mode: command
not tag: user.homerow_search
and not tag: user.fluent_search_screen_search
-
settings():
	user.ocr_connect_tracker = 0
    
(eye | i) (hover | [cursor] move): user.move_cursor_to_gaze_point()
(eye | i) [left] (prod):
    user.move_cursor_to_gaze_point()
    mouse_click(0)
(eye | i) [left] double (prod):
    user.move_cursor_to_gaze_point()
    mouse_click(0)
    mouse_click(0)
(eye | i) right (prod):
    user.move_cursor_to_gaze_point()
    mouse_click(1)
(eye | i) middle (prod):
    user.move_cursor_to_gaze_point()
    mouse_click(2)
(eye | i) <user.modifiers> (prod):
    user.move_cursor_to_gaze_point()
    key("{modifiers}:down")
    mouse_click(0)
    key("{modifiers}:up")

(eye | i) scroll up:
    user.move_cursor_to_gaze_point(0, 40)
    user.mouse_scroll_up()
(eye | i) scroll up half:
    user.move_cursor_to_gaze_point(0, 40)
    user.mouse_scroll_up(0.5)
(eye | i) scroll down:
    user.move_cursor_to_gaze_point(0, -40)
    user.mouse_scroll_down()
(eye | i) scroll down half:
    user.move_cursor_to_gaze_point(0, -40)
    user.mouse_scroll_down(0.5)
(eye | i) scroll left:
    user.move_cursor_to_gaze_point(40, 0)
    user.mouse_scroll_left()
(eye | i) scroll left half:
    user.move_cursor_to_gaze_point(40, 0)
    user.mouse_scroll_left(0.5)
(eye | i) scroll right:
    user.move_cursor_to_gaze_point(-40, 0)
    user.mouse_scroll_right()
(eye | i) scroll right half:
    user.move_cursor_to_gaze_point(-40, 0)
    user.mouse_scroll_right(0.5)

# Debugging commands.
ocr show [text]: user.show_ocr_overlay("text")
ocr show [text] near <user.timestamped_prose>: user.show_ocr_overlay("text", timestamped_prose)
ocr show boxes: user.show_ocr_overlay("boxes")

# Commands that operate on text nearby where you're looking.
# Example: "hover seen apple" to hover the cursor over the word "apple".
(hover (seen | scene) | cursor move) <user.timestamped_prose>$: user.move_cursor_to_word(timestamped_prose)
[left] (prod | prod) <user.timestamped_prose>$:
    user.click_text(timestamped_prose)
^duke <user.timestamped_prose>$:
    user.double_click_text(timestamped_prose)
^ripple <user.timestamped_prose>$:
    user.triple_click_text(timestamped_prose)
^steel <user.timestamped_prose>$:
    user.triple_click_text(timestamped_prose)
    edit.copy()
^connie <user.timestamped_prose>$:
    user.right_click_text(timestamped_prose)
^<user.modifiers> connie <user.timestamped_prose>$:
    user.modifier_right_click_text(modifiers, timestamped_prose)
    
dragger <user.timestamped_prose>$: user.drag_text(timestamped_prose)

   
middle (prod) <user.timestamped_prose>$:
    user.middle_click_text(timestamped_prose)
<user.modifiers> (prod|grab) <user.timestamped_prose>$:
     user.modifier_click_text(modifiers, timestamped_prose)
(go before | pre (seen | scene)) <user.timestamped_prose>$: user.move_text_cursor_to_word(timestamped_prose, "before")
(go after | post (seen | scene)) <user.timestamped_prose>$: user.move_text_cursor_to_word(timestamped_prose, "after")
grab <user.prose_range>$:
    user.perform_ocr_action("select", "", prose_range)
# Examples: 
# "take seen apple" to select the word "apple".
# "copy seen apple through banana" to copy the phrase "apple pear banana".
# "copy all seen apple" to copy all text from the field containing the word "apple".
{user.ocr_actions} [{user.ocr_modifiers}] (seen | scene) <user.prose_range>$:
    user.perform_ocr_action(ocr_actions, ocr_modifiers or "", prose_range)
# Example: "replace apple with banana" to replace the word "apple" with the word "banana".
replace [{user.ocr_modifiers}] [seen | scene] <user.prose_range> with <user.prose>$:
    user.replace_text(ocr_modifiers or "", prose_range, prose)
go before <user.timestamped_prose> say <user.prose>$:
    user.insert_adjacent_to_text(timestamped_prose, "before", prose)
go after <user.timestamped_prose> say <user.prose>$:
    user.insert_adjacent_to_text(timestamped_prose, "after", prose)
phones [word] (seen | scene) <user.timestamped_prose>$:
    user.change_text_homophone(timestamped_prose)

ocr tracker on: user.connect_ocr_eye_tracker()
ocr tracker off: user.disconnect_ocr_eye_tracker()

# More commands are available for Talon Beta users! Simply switch to the "beta" branch.
