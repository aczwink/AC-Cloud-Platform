#should be fixed: GET VALUES BACKEND_DOMAINNAME = FRONTEND_IP, STORAGE_ACCOUNT_KEY AND STORAGE_ACCOUNT_NAME

mkdir _tmp
cd _tmp

git clone https://github.com/aczwink/OpenArabicMusicDB.git
cd OpenArabicMusicDB
cd builder

npm ci
npm run compile
npm run build-db

az storage directory create \
  --account-name "$STORAGE_ACCOUNT_NAME" \
  --account-key "$STORAGE_ACCOUNT_KEY" \
  --share-name app-arabicmusicencyclopedia \
  --name backend

az storage file upload \
  --account-name "$STORAGE_ACCOUNT_NAME" \
  --account-key "$STORAGE_ACCOUNT_KEY" \
  --share-name app-arabicmusicencyclopedia \
  --source ./dist/db.json \
  --path backend/db.json

cd ..
cd ..

git clone https://github.com/aczwink/ArabicMusicEncyclopedia.git
cd ArabicMusicEncyclopedia

cd backend
npm ci
npm run build
cd ..

cd frontend

npm ci
npm run generate-api-and-theme
npm run create-release-pkg
echo "window.process = { env: { AME_BACKEND_HOSTNAME: \"$BACKEND_DOMAINNAME\", AME_BACKEND_PORT: 8080, AME_BACKEND_PROTOCOL: \"http\" } };" >> ./dist/env.js

az storage directory create \
  --account-name "$STORAGE_ACCOUNT_NAME" \
  --account-key "$STORAGE_ACCOUNT_KEY" \
  --share-name app-arabicmusicencyclopedia \
  --name frontend

az storage file upload-batch \
  --account-name "$STORAGE_ACCOUNT_NAME" \
  --account-key "$STORAGE_ACCOUNT_KEY" \
  --source ./dist \
  --destination app-arabicmusicencyclopedia/frontend

cd ..

cd ..

cd ..
rm -rf _tmp