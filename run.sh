#!/bin/sh

echo "Enter Old Email address: "
read OLD_EMAIL
echo "Enter new Email Address: "
read CORRECT_EMAIL
echo "Enter new user name (First name + Last Name): "
read CORRECT_NAME

env_filter="
OLD_EMAIL=\"$OLD_EMAIL\"
CORRECT_NAME=\"$CORRECT_NAME\"
CORRECT_EMAIL=\"$CORRECT_EMAIL\"
if [ \"\$GIT_COMMITTER_EMAIL\" = \"\$OLD_EMAIL\" ]
then
    export GIT_COMMITTER_NAME=\"\$CORRECT_NAME\"
    export GIT_COMMITTER_EMAIL=\"\$CORRECT_EMAIL\"
fi
if [ \"\$GIT_AUTHOR_EMAIL\" = \"\$OLD_EMAIL\" ]
then
    export GIT_AUTHOR_NAME=\"\$CORRECT_NAME\"
    export GIT_AUTHOR_EMAIL=\"\$CORRECT_EMAIL\"
fi
"

git filter-branch --env-filter "$env_filter" --tag-name-filter cat -- --branches --tags

rm -rf .git/refs/original/refs/*/*
