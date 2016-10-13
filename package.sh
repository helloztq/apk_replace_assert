#!/bin/bash

KEYSTORE_NAME=./gow.keystore  #签名文件
KEYSTORE_ALIAS=gow
KEYSTORE_STOREPASS=oxgame_601
KEYSTORE_KEYPASS=oxgame_601

INPUT_APK=./input.apk       #源apk
META_INF=./META-INF         #将里面的文件清空
ASSETS=./assets             #重新打包的资源
# LIBS=./lib

OUTPUT=./output/
UNSIGNED=./output/input.apk
SIGNED=./output/Signed.apk
OPT=./output/output.apk

cp $INPUT_APK $OUTPUT

jar -uf $UNSIGNED $META_INF
jar -uf $UNSIGNED $ASSETS
# jar -uf $UNSIGNED $LIBS
echo Replace OK!

jarsigner -sigalg MD5withRSA -digestalg SHA1 -keystore $KEYSTORE_NAME -storepass $KEYSTORE_STOREPASS -keypass $KEYSTORE_KEYPASS -signedjar $SIGNED $UNSIGNED $KEYSTORE_ALIAS
echo Signe OK!

rm -r $OPT
zipalign 4 $SIGNED $OPT
echo Zipalign ok!

# rm -r $UNSIGNED
# rm -r $SIGNED
echo Operate OK!
