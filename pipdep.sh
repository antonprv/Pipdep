#!/bin/bash

get_dependencies() {
    dependencies=$(pip show $1 | grep Requires | cut -d ':' -f 2)
    for dependency in $dependencies; do
	    dep_name=$(echo $dependency | cut -d ' ' -f 2)
	    if pip show "$dep_name" &>/dev/null; then
		    dep_version=$(pip show $dep_name | grep Version | cut -d ' ' -f 2)
		    echo "$dep_name==$dep_version" >> $2
	    else
		    echo ""$dep_name" is not installed. Skipping..."
	    fi
    done
}

# Easily generate requirements file
if [ "$1" = "-r" ]; then
	pipdeptree | grep -P '^\w+' > "$2"
elif [ "$1" = "-s" ]; then
	pipdeptree
elif [ "$1" = "-a" ]; then
	
	if [ $# -ne 3 ]; then
		echo "Usage: $2 <module_name> $3 <requirements_file_name(optional)>"
    exit 1
	fi
	module_name="$2"
	
	if [ -z "$3" ]; then
		requirements_file="requirements.txt"
	else
		requirements_file="$3"
	fi

	module_version=$(pip show "$module_name" | grep Version | cut -d ' ' -f 2)
	echo "$module_name"=="$module_version" >> "$requirements_file"
	get_dependencies $module_name $requirements_file

elif [ "$1" = "-h" ]; then
	echo "default behavior with no arguments: "
	echo "	gets project dependencies and writes them to"
	echo "	file called <pip_dependency_tree.txt>"
	echo ""
	echo ""
	echo "Arguments:"
	echo "-h to display this message"
	echo ""
	echo "dependencies-related:"
	echo "-o to write dependency tree to the file with custom name"
	echo "-s to show dependency tree in the terminal"
	echo ""
	echo "requirements.txt-related:"
	echo "-r + name to generate requirements file"
	echo "-a to append newly installed module with its dependencies to existing requirements.txt file"
	echo "	(defaults to the <requirements.txt> file name, but you can customise it)"
	echo "	(default output: <module_name>==<version>)"
	echo "		usage: -a <module_name> <requirements_file_name(optional)>"
else

	if [ "$1" = "-o" ]; then
		output_file="$2"
	else
	# Set the output filename
		output_file="pip_dependency_tree.txt"
	fi

# Check if pipdeptree is installed
if ! command -v pipdeptree >/dev/null 2>&1; then
  echo "pipdeptree is not installed. Installing..."
  # Install pipdeptree using pip
  pip install pipdeptree >/dev/null 2>&1 || exit 1
fi

# -p option specifies sitepackages directory. Output is saved to file.
pipdeptree | tee | grep -vE "(^python|^(distutils|setuptools|wheel|pip|virtualenv|venv))" > "$output_file"

# Print confirmation message (optional)
# You can comment out this line if you don't want any confirmation message
echo "Dependency tree saved to: $output_file"

fi
