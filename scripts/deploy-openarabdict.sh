git clone https://github.com/aczwink/OpenArabDict.git
cd OpenArabDict

cd builder
npm ci
npm run compile
npm run build-db
az storage blob upload --file ./dist/dict.json --blob-url https://openarabdictdbstorage.blob.core.windows.net/dbstorage/dict.json --auth-mode login --overwrite
az storage blob upload --file ./dist/en.json --blob-url https://openarabdictdbstorage.blob.core.windows.net/dbstorage/en.json --auth-mode login --overwrite
cd ..

cd ..
rm -rf OpenArabDict

git clone https://github.com/aczwink/OpenArabDictViewer.git
cd OpenArabDictViewer

cd backend
npm ci
npm run build
cd ..

cd ..
rm -rf OpenArabDictViewer