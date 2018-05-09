# iou-web Docker

This repository will contains the data for build and run a docker container with iou-web in order to run cisco IOU simulations ( based on Andrea Dainese iou-web repository https://github.com/dainok/iou-web)

```
docker build -t iou-web .
docker container run -it -d --name iou-web --hostname iou-web -p 80:80 -p 2001-2019:2001-2019 iou-web
docker container exec -it iou-web bash
```

# to do

fix libcrypto symlinks

# disclaimer

this repository does not contain any material owned by cisco (eg. iol images or any codes that will allows this container to run iol images)