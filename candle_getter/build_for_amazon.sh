rm /build/*

cd /code
python3 -m pip install --target /build/python/ -r requirements.txt
cd /build
zip -r /build/candle_getter_layer.zip python

cd /code/
zip -r /build/candle_getter_package.zip *.py *.yml .env
