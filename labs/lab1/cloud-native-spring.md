# Building a Spring Boot Application

## Create a Spring Boot Project

1. Browse to [https://start.spring.io]()

2. Generate a Maven Project with Spring Boot

3. Fill out the *Project metadata* fields as follows:
  *Group:*
    io.pivotal
  *Artifact:*
    cloud-native-spring

4. Click the _Generate Project_ button. Your browser will download a zip file.

5. Copy then unpack the downloaded zip file to *labs/lab01/cloud-native-spring*

    Your directory structure should now look like:  
    ```bash
    PCF-101-Workshop:
    ├── labs
    │   ├── lab01
    │   │   ├── cloud-native-spring
    ```

6. Import the project’s pom.xml into your editor/IDE of choice.

  *_STS Import Help:_*  
  Select File > Import… Then select Maven > Existing Maven Projects. On the Import Maven Projects page, browse to the /cloud-native-spring directory (e.g. PCF-Workshop-Dis/labs/lab01/cloud-native-spring)

## Add an Endpoint

1. Add an @RestController annotation to the class _io.pivotal.CloudNativeSpringApplication_ (/cloud-native-spring/src/main/java/io/pivotal/CloudNativeSpringApplication.java).


```java

package io.pivotal;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
public class CloudNativeSpringApplication {

    public static void main(String[] args) {
        SpringApplication.run(CloudNativeSpringApplication.class, args);
    }
}
```

2. Add the following request handler to the class _io.pivotal.CloudNativeSpringApplication (/cloud-native-spring/src/main/java/io/pivotal/CloudNativeSpringApplication.java).

```java
@RequestMapping("/")
public String hello() {
    return "Hello World!";
}
```
Completed:
```java
package io.pivotal;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
public class CloudNativeSpringApplication {

    public static void main(String[] args) {
        SpringApplication.run(CloudNativeSpringApplication.class, args);
    }

    @RequestMapping("/")
    public String hello() {
        return "Hello World!";
    }
}
```

## Run the _cloud-native-spring_ Application

1. In a terminal, change working directory to *PCF-101-Workshop/labs/lab01/cloud-native-spring*  
`$ cd /PCF-101-Workshop/labs/lab01/cloud-native-spring`

2. Run the application  
`$ mvn clean spring-boot:run`

3. You should see the application start up an embedded Apache Tomcat server on port 8080 (review terminal output):  
```
2015-10-02 13:26:59.264  INFO 44749 --- [lication.main()] s.b.c.e.t.TomcatEmbeddedServletContainer: Tomcat started on port(s): 8080 (http)
2015-10-02 13:26:59.267  INFO 44749 --- [lication.main()] io.pivotal.hello.CloudNativeSpringApplication: Started CloudNativeSpringApplication in 2.541 seconds (JVM running for 9.141)
```

4. Browse to http://localhost:8080

5. Stop the _cloud-native-spring_ application. In the terminal window: *Ctrl + C*

## Deploy _cloud-native-spring_ to Pivotal Cloud Foundry

1. Build the application  
```bash
$ mvn clean package
```

2. Create an application manifest in the root folder /cloud-native-spring  
`$ touch manifest.yml`

3. Add application metadata, using a text editor (of choice)
```yaml
---
applications:
- name: cloud-native-spring
  host: cloud-native-spring-${random-word}
  memory: 1G
  instances: 1
  path: ./target/cloud-native-spring-0.0.1-SNAPSHOT.jar
  buildpack: java_buildpack_offline
  env:
    JAVA_OPTS: -Djava.security.egd=file:///dev/urandom
```

4. Push application into Cloud Foundry  
`$ cf push -f manifest.yml`

5. Find the URL created for your app in the health status report. Browse to your app.

*Congratulations!* You’ve just completed your first Spring Boot application.

## On to the next Lab!
[Lab2 - Binding to Cloud Foundry Services](../../labs/lab2/README.md)
