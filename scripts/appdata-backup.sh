#!/bin/bash

# Configuration variables
source_folder1="/appdata"
source_folder2="/ssd/appdata"  # Add the path to the additional folder
destination_folder="/mergerfs/backups/appdata-backups"
exclusion_list=()  # You can update this list if needed for either folder
max_zip_files=3

# Get the current date in the format: YYYY-MM-DD
current_date=$(date +'%Y-%m-%d')
zip_filename1="backup_appdata_${current_date}.zip"  # Update the name for the first backup
zip_filename2="backup_anotherfolder_${current_date}.zip"  # Update the name for the second backup
temp_folder1="/tmp/backup_temp_appdata_${current_date}"  # Update the name for the first backup
temp_folder2="/tmp/backup_temp_anotherfolder_${current_date}"  # Update the name for the second backup

# Ensure that the destination folder exists, creating it if necessary
if [ ! -d "$destination_folder" ]; then
    mkdir -p "$destination_folder"
fi

# Copy the source folders to temporary locations
cp -r "$source_folder1" "$temp_folder1"
cp -r "$source_folder2" "$temp_folder2"

# Exclude specified files/folders from the temporary folders
for item in "${exclusion_list[@]}"; do
    if [ -e "$temp_folder1/$item" ]; then
        rm -r "$temp_folder1/$item"
    fi
    if [ -e "$temp_folder2/$item" ]; then
        rm -r "$temp_folder2/$item"
    fi
done

# Create zip files with the copied folder contents
zip -rq "$destination_folder/$zip_filename1" "$temp_folder1"
zip -rq "$destination_folder/$zip_filename2" "$temp_folder2"

# Change ownership of the zip files to abc:abc
chown abc:abc "$destination_folder/$zip_filename1"
chown abc:abc "$destination_folder/$zip_filename2"

# Clean up the temporary folders
rm -r "$temp_folder1"
rm -r "$temp_folder2"

# Delete older zip files if there are more than three
zip_file_count=$(ls -1 "$destination_folder"/*.zip 2>/dev/null | wc -l)
if [ "$zip_file_count" -gt "$max_zip_files" ]; then
    files_to_delete=$((zip_file_count - max_zip_files))
    oldest_files=($(ls -t "$destination_folder"/*.zip | tail -n $files_to_delete))
    for file in "${oldest_files[@]}"; do
        rm "$file"
    done
fi