ROOT=$PWD

echo "Start build web"
flutter build web --release
echo 'Finish build web'


echo 'Start copy'

if [ -d "$ROOT/release/web" ]; then
  rm -R  $ROOT/release/web
fi

mkdir -p $ROOT/release/web
cp -R $ROOT/build/web/ $ROOT/release/web
if [ -d "$ROOT/release/web/network_config.json" ]; then
  rm -R  $ROOT/release/web/network_config.json
fi

ran=$RANDOM
echo $ran


if [[ "$OSTYPE" == "linux"* ]] || [[ "$OSTYPE" == "msys" ]]; then
  sed -i 's|location.search):"#"+a|location.search):""+a|g' $ROOT/release/web/main.dart.js

  # перебор файлов для replace названия - чтобы не кэшировались скрипты, реплейс в скрипте main.js частей deferred
  cd $ROOT/release/web
  for x in main.dart.js*;do 
    newFileName=${x//main.dart.js/main.$ran.dart.js};
    sed -i 's/main\.dart\.js/main\.'$ran'\.dart\.js/g' $x;
    mv -i $x $newFileName;
  done
  cd $ROOT

  sed -i 's/main\.dart/main\.'$ran'\.dart/g' $ROOT/release/web/flutter_service_worker.js
  sed -i 's/main\.dart/main\.'$ran'\.dart/g' $ROOT/release/web/index.html
  sed -i 's/main\.dart/main\.'$ran'\.dart/g' $ROOT/release/web/main.$ran.dart.js
else
  sed -i '' 's|location.search):"#"+a|location.search):""+a|g' $ROOT/release/web/main.dart.js
  sed -i '' 's/main\.dart/main\.'$ran'\.dart/g' $ROOT/release/web/flutter_service_worker.js
  sed -i '' 's/main\.dart/main\.'$ran'\.dart/g' $ROOT/release/web/index.html
  cd $ROOT/release/web
  for x in main.dart.js*;do 
    newFileName=${x//main.dart.js/main.$ran.dart.js};
    mv -i $x $newFileName;
    sed -i '' 's/main\.dart/main\.'$ran'\.dart/g' $newFileName;
  done
  cd $ROOT
fi

echo 'Finish copy'
echo 'Awesome!'

cd $ROOT/release/web/
bash $ROOT/scripts/run_web.sh
cd $ROOT