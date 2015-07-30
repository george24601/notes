#display detailed failure
sudo ./gradlew test -i

gradle dependencies --configuration testCompile

#use test filtering
sudo ./gradlew test --tests *IT -i
