git=$(sh /etc/profile; which git)
bundleVersion=$("$git" log --pretty=oneline HEAD^@ |wc -l)
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $bundleVersion" "ios/Runner/Info.plist"

echo "Updated build number in ios/Runner/Info.plist to $bundleVersion"
