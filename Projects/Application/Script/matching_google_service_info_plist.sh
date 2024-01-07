# Reference : https://y8k.me/article/914
# Filename
FIREBASE_INFO_PLIST=GoogleService-Info.plist
# File path for dev
FIREBASE_INFO_DEVELOP_PATH="${PROJECT_DIR}/Script/GoogleService-Info/GoogleService-Info-DevApp.plist"
# File path for production
FIREBASE_INFO_PRODUCTION_PATH="${PROJECT_DIR}/Script/GoogleService-Info/GoogleService-Info-App.plist"
# Target Destination Path
FIREBASE_INFO_DESTINATION_PATH="${PROJECT_DIR}/Resources/${FIREBASE_INFO_PLIST}"


# Copy selected GoogleService-Info.plist for builds depend on bundle identifier
echo "Run copying GoogleService-Info.plist"
if [ "${PRODUCT_BUNDLE_IDENTIFIER}" == "kr.minsone.dev-app" ]
then 
echo "Matched BundleId : ${PRODUCT_BUNDLE_IDENTIFIER}, then Using ${FIREBASE_INFO_DEVELOP_PATH}"
cp ${FIREBASE_INFO_DEVELOP_PATH} ${FIREBASE_INFO_DESTINATION_PATH}
elif [ "${PRODUCT_BUNDLE_IDENTIFIER}" == "kr.minsone.app" ]
then
echo "Matched BundleId : ${PRODUCT_BUNDLE_IDENTIFIER}, then Using ${FIREBASE_INFO_PRODUCTION_PATH}"
cp ${FIREBASE_INFO_PRODUCTION_PATH} ${FIREBASE_INFO_DESTINATION_PATH}
else
echo "Not matched BundleId. Then using Production GoogleService-Info.plist"
cp ${FIREBASE_INFO_PRODUCTION_PATH} ${FIREBASE_INFO_DESTINATION_PATH}
fi