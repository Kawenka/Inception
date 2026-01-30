docker run -it --rm \
  -e SQL_DATABASE=inception \
  -e SQL_USER=tonuser \
  -e SQL_PASSWORD=tonmdp \
  -e SQL_ROOT_PASSWORD=rootmdp \
  mariadb