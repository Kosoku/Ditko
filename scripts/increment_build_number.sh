#!/bin/sh
# Set the build number to the current git commit count.
# If we're using the Dev scheme, then we'll suffix the build
# number with the current branch name, to make collisions
# far less likely across feature branches.
# Based on: http://w3facility.info/question/how-do-i-force-xcode-to-rebuild-the-info-plist-file-in-my-project-every-time-i-build-the-project/
#
git=`sh /etc/profile; which git`
appBuild=`"$git" rev-list --all |wc -l`
if [ $CONFIGURATION = "Debug" ]; then
branchName=`"$git" rev-parse --abbrev-ref HEAD`
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $appBuild-$branchName" "${TARGET_BUILD_DIR}/${INFOPLIST_PATH}"
else
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $appBuild" "${TARGET_BUILD_DIR}/${INFOPLIST_PATH}"
fi
echo "Updated ${TARGET_BUILD_DIR}/${INFOPLIST_PATH}"