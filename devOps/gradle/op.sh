#generate wrappers
gradle wrapper --gradle-version 2.13
./gradlew build

#build only the subproject ABC
gradle :ABC:build
