mkdir _tmp
cd _tmp

git clone https://github.com/aczwink/OpenArabicMusicDB.git
cd OpenArabicMusicDB
cd builder

npm ci
npm run compile
npm run build-db

az storage file upload \
  --account-name "$STORAGE_ACCOUNT_NAME" \
  --account-key "$STORAGE_ACCOUNT_KEY" \
  --share-name app-arabicmusicencyclopedia \
  --source ./dist/db.json \
  --path backend/db.json

cd ..
cd ..

cd ..
rm -rf _tmp