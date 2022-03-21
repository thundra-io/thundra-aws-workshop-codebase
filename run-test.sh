#!/bin/bash -ex

if [ ! -f ./test/chromedriver ]; then
    echo "Couldn't find the ChromeDriver in the test folder."
    echo "Please download suitable version from https://chromedriver.storage.googleapis.com/index.html"
    echo "Find out your Chrome version by visiting chrome://settings/help"
    exit 1
fi

export $(cat .env | sed 's/#.*//g' | xargs)

pushd ./test

mvn clean install

popd
