# This project is for classifying files and store em
# in separate folders

# Step. Description
# 1:    Download and install Python enviroment for 
#       your OS at https://www.python.org/downloads/
# 2:    Download this file and name it as main.py
# 3:    Open your terminal or MSDOS and type 
#          python main.py

import os # file skimming
import shutil # file procesing

# Show path of current folder
path = os.getcwd() + "/"

# List file names in current path
file_list = os.listdir(path)

# Classify files
for file in file_list:
  file_path = path + file
  file_naming_info = os.path.splitext(file)
  file_extension = file_naming_info[1]
  
  # Create folder by file types
  folder_name = path + file_extension + "/"
  if not os.path.exists(folder_name):
    os.makedirs(folder_name)
    
  # Move file to correspodning file type
  shutil.move(file_path, folder_name + file)
