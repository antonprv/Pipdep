# Pipdep
fast and lightweight alternative to poetry

Pros:
- It is a single bash script.
- The only package it relies upon is pipdeptree and if you don't have it, you can use the the script anyway! Pipdeptree will be installed automatically, but only if you use run dependency-tree-related commands.

Cons:
- None :)

How it works:
It runs pipdeptree to get dependency tree, and then filters out all default stuff, to only display things that you've personally installed.

What it does:
- Manages and updates different requirements.txt files
- Manages and updates dependency trees.

How to use it:
  

 	Default behavior with no command-line arguments:
		gets project dependencies and writes them to
		file called "pip_dependency_tree.txt"
  
	Arguments:
	  -h to display this message
	
	Dependencies-related:
	  -o to write dependency tree to the file with custom name
	  -s to show dependency tree in the terminal
	
	requirements.txt-related:
	  -r + name to generate requirements file
	  -a to append newly installed module with its dependencies to existing requirements.txt file
	  	(defaults to the <requirements.txt> file name, but you can customise it)
	  	(default output: <module_name>==<version>)
  		usage: -a <module_name> <requirements_file_name(optional)>
    
How to install it?
Simply save it somewhere and add the alias to the filee in your .bash_aliases or .bash_rc
I use it daily along these aliases:
	`(to activate virtual environment)`
alias psrc="source venv/bin/activate"

	`(to manage python versions)`
alias p3-7='~/.pyenv/versions/3.7.17/bin/python'
alias p3-9='~/.pyenv/versions/3.9.18/bin/python'
alias p3-12='~/.pyenv/versions/3.12.2/bin/python'
