git clone https://github.com/aczwink/KungFuWiki.git
cd KungFuWiki

npm i
npm run build

cd dist/out
cp ../../../../integration/node-webserver/package.json ./
npm i
#TODO: do a webpack bundle!
zip -r ./azure.zip .
az webapp deploy --resource-group dev-rg-kungfudoc --name devackungfudoc --src-path ./azure.zip
cd ../..

cd ..
rm -rf ./KungFuWiki