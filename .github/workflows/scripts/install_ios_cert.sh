P12_PASSWORD=$1
CERTIFICATE_PATH=$4

KEYCHAIN_PASSWORD=abc123
KEYCHAIN_PATH=$RUNNER_TEMP/app-signing.keychain-db

security create-keychain -p $KEYCHAIN_PASSWORD $KEYCHAIN_PATH
security set-keychain-settings -lut 21600 $KEYCHAIN_PATH
security unlock-keychain -p $KEYCHAIN_PASSWORD $KEYCHAIN_PATH

security import $CERTIFICATE_PATH -P $P12_PASSWORD -A -t cert -f pkcs12 -k $KEYCHAIN_PATH
security set-key-partition-list -S apple-tool:,apple: -k $KEYCHAIN_PASSWORD $KEYCHAIN_PATH
security list-keychain -d user -s $KEYCHAIN_PATH

