#!/bin/bash

# Default values
show_all=false
top_entries=8

while getopts ":dna:" opt; do
  case $opt in
    d)
      show_all=true
      ;;
    n)
      top_entries=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

shift $((OPTIND - 1))
directories=("$@")

if [ ${#directories[@]} -eq 0 ]; then
  echo "Error: Please provide at least one directory to check disk usage."
  exit 1
fi

display_disk_usage() {
  directory=$1
  if $show_all; then
    du -ah "$directory" | sort -rh | head -n "$top_entries"
  else
    du -h --max-depth=1 "$directory" | sort -rh | head -n "$top_entries"
  fi
}

for dir in "${directories[@]}"; do
  echo -e "\nDisk usage for $dir:"
  display_disk_usage "$dir"
done
