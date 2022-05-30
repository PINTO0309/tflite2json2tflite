# tflite2json2tflite
Convert tflite to JSON and make it editable in the IDE. It also converts the edited JSON back to tflite binary.

# Usage sample
## 1. Docker run
```bash
docker run --rm -it -v `pwd`:/home/user/workdir
```
## 2. tflite to JSON
```bash
./flatc -t \
--strict-json \
--defaults-json \
-o workdir \
./schema.fbs -- workdir/model_float32.tflite
```
## 3. JSON edit
```bash
sed -i -e 's/Placeholder/input/g' workdir/model_float32.json
sed -i -e 's/fusion\/fusion_3\/BiasAdd/output/g' workdir/model_float32.json
```
## 4. JSON to tflite
```bash
./flatc \
-o workdir \
-b ./schema.fbs workdir/model_float32.json

rm workdir/model_float32.json
```