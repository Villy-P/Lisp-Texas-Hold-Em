import pyautogui

screenWidth, screenHeight = pyautogui.size()
pyautogui.click(screenHeight - 50, screenWidth / 2)
pyautogui.write('C:\SBCL\sbcl.exe')
pyautogui.press('enter')
pyautogui.write('(require "asdf")')
pyautogui.press('enter')
pyautogui.write('(asdf:load-asd (merge-pathnames "project.asd" (uiop:getcwd)))')
pyautogui.press('enter')
pyautogui.write('(asdf:load-system :project)')
pyautogui.press('enter')