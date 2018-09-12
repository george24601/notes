Because the standard project layout of a Java project defines only one test directory (src/test), we have no standard way to add integration tests to our Gradle build.

We can add our integration tests to the same directory than our unit tests. This is an awful idea because integration tests are typically a lot slower than unit tests.

We can create a new project and add our integration tests to that project. This makes no sense because it forces us to transform our project into a multi-project build. Also, if our project is already a multi-project build, we are screwed. We can of course add all integration tests to the same project or create new integration test project for each tested project, but it would be less painful to shoot ourselves in the foot.

Integration and unit tests must have different source directories. The src/integration-test/java directory must contain the source code of our integration tests and the src/test/java directory must contain the source code of our unit tests.

Integration and unit tests must have separate resource directories. The src/integration-test/resources directory must contain the resources of our integration tests. The src/test/resources directory must contain the resources of our unit tests.

If an integration test fails, our build must fail as well.
