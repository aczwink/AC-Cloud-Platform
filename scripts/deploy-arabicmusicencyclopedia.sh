git clone https://github.com/aczwink/OpenArabicMusicDB.git
cd OpenArabicMusicDB

cd builder
npm ci
cd ..

cd ..
rm -rf OpenArabicMusicDB

git clone https://github.com/aczwink/ArabicMusicEncyclopedia.git
cd ArabicMusicEncyclopedia

cd backend
npm ci
npm run build-release-package
cd ..

cd ..
rm -rf ArabicMusicEncyclopedia