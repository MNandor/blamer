#!/bin/bash

cd $(git rev-parse --show-toplevel)/.git/hooks

#!/bin/bash

if [ -f post-commit ]; then
	sed -e '/^# baser/!d' post-commit -e 's/^# baser: //'

else
	echo "post-commit file does not exist. Do you want to create it? (y/n)"
	read answer
	if [ "$answer" == "y" ]; then
		touch post-commit
		echo "post-commit file created"
	else
		exit
	fi
fi


if ! [ -x post-commit ]; then
	echo "post-commit file is not executable. Do you want to make it executable? (y/n)"
	read answer
	if [ "$answer" == "y" ]; then
		chmod +x post-commit
		echo "post-commit file is now executable"
	else
		echo "post-commit file is not executable"
	fi
fi

cd ../..


# Check if there are two or more branches in the repository
branches=$(git branch | wc -l)
if [ $branches -lt 2 ]; then
	echo "There is only one branch in the repository"
else
	echo "There are two or more branches in the repository. Please select two distinct branches:"
	git branch
	read -p "Enter the name of the first branch: " first_branch
	read -p "Enter the name of the second branch: " second_branch
	echo "You selected $first_branch as the first branch and $second_branch as the second branch"

	cd .git/hooks

	# Add the lines to the post-commit file
	echo "# baser: $first_branch > $second_branch" >> post-commit

	# Add rebase command to post-commit file for commits on first_branch
		echo "GIT_BRANCH=\$(git rev-parse --abbrev-ref HEAD)" >> post-commit
	echo "if [ \$GIT_BRANCH == \"$first_branch\" ]; then" >> post-commit
	echo "  git rebase $first_branch $second_branch" >> post-commit
	echo "  git checkout $first_branch" >> post-commit
	echo "fi" >> post-commit
fi
