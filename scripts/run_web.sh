mkcert 0.0.0.0 flutter.sportsapi.ru localhost 127.0.0.1 ::1

mv 0.0.0.0+4.pem 0.0.0.0+4.pem
http-server -S -C 0.0.0.0+4.pem -o
mv  0.0.0.0+4-key.pem  key.pem
mv 0.0.0.0+4.pem cert.pem

http-server -S -C cert.pem -o -p 443
