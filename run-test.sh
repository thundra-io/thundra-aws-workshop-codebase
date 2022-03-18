if [ ! -f ./test/chromedriver ]; then
    echo "Chromedriver not found in test folder. Please download suitable version from https://chromedriver.storage.googleapis.com/index.html"
    exit 1
fi

export $(cat .env | sed 's/#.*//g' | xargs)

cd "./test"

mvn clean test
mvn clean

cd ..