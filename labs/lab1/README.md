= Lab 1 - From Zero to Pushing Your First Application

== Target the Environment

. Follow the instructions to link:../README.adoc[Get Environment Access]

== Push It!

. Change to the _spring-cf-sample-app_ application directory:
+
----
$ cd $BOOTCAMP_HOME/spring-cf-sample-app
----

. Push the application!
+
----
$ cf push
----
+
You should see output similar to the following listing. Take a look at the listing callouts for a play-by-play of what's happening:
+
====
----
Using manifest file /Users/phopper/workspace/NBCU-PCF-Workshop-101/cf-spring-mvc-boot/manifest.yml <1>

Creating app workshop in org TELCO / space hopper as phopper@pivotal.io...
OK <2>

Creating route workshop-philologic-catchpolery.vert.fe.gopivotal.com...
OK <3>

Binding workshop-philologic-catchpolery.vert.fe.gopivotal.com to workshop...
OK <4>

Uploading workshop... <5>
Uploading app files from: /Users/phopper/workspace/NBCU-PCF-Workshop-101/cf-spring-mvc-boot/target/cf-spring-mvc-boot-0.0.1-SNAPSHOT.jar
Uploading 10.6M, 153 files
Done uploading               
OK

Starting app workshop in org TELCO / space hopper as phopper@pivotal.io... <6>
-----> Downloaded app package (27M)
-----> Java Buildpack Version: v3.1.1 (offline) | https://github.com/cloudfoundry/java-buildpack#7a538fb
-----> Downloading Open Jdk JRE 1.8.0_51 from https://download.run.pivotal.io/openjdk/trusty/x86_64/openjdk-1.8.0_51.tar.gz (found in cache)
       Expanding Open Jdk JRE to .java-buildpack/open_jdk_jre (1.5s) <7>
-----> Downloading Open JDK Like Memory Calculator 1.1.1_RELEASE from https://download.run.pivotal.io/memory-calculator/trusty/x86_64/memory-calculator-1.1.1_RELEASE (found in cache)
       Memory Settings: -Xss995K -Xmx382293K -Xms382293K -XX:MaxMetaspaceSize=64M -XX:MetaspaceSize=64M
-----> Downloading Spring Auto Reconfiguration 1.7.0_RELEASE from https://download.run.pivotal.io/auto-reconfiguration/auto-reconfiguration-1.7.0_RELEASE.jar (found in cache)

-----> Uploading droplet (72M) <8>

0 of 1 instances running, 1 starting
0 of 1 instances running, 1 starting
1 of 1 instances running

App started

OK

App workshop was started using this command `CALCULATED_MEMORY=$($PWD/.java-buildpack/open_jdk_jre/bin/java-buildpack-memory-calculator-1.1.1_RELEASE -memorySizes=metaspace:64m.. -memoryWeights=heap:75,metaspace:10,stack:5,native:10 -totMemory=$MEMORY_LIMIT) && SERVER_PORT=$PORT $PWD/.java-buildpack/open_jdk_jre/bin/java -cp $PWD/.:$PWD/.java-buildpack/spring_auto_reconfiguration/spring_auto_reconfiguration-1.7.0_RELEASE.jar -Djava.io.tmpdir=$TMPDIR -XX:OnOutOfMemoryError=$PWD/.java-buildpack/open_jdk_jre/bin/killjava.sh $CALCULATED_MEMORY -Djava.security.egd=file:///dev/urandom org.springframework.boot.loader.JarLauncher` <9>

Showing health and status for app workshop in org TELCO / space hopper as phopper@pivotal.io... <10>
OK

requested state: started
instances: 1/1
usage: 512M x 1 instances
urls: workshop-philologic-catchpolery.vert.fe.gopivotal.com
last uploaded: Thu Sep 24 20:15:27 UTC 2015
stack: cflinuxfs2
buildpack: java-buildpack=v3.1.1-offline-https://github.com/cloudfoundry/java-buildpack#7a538fb java-main java-opts open-jdk-like-jre=1.8.0_51 open-jdk-like-memory-calculator=1.1.1_RELEASE spring-auto-reconfiguration=1.7.0_RELEASE

     state     since                    cpu    memory           disk           details   
#0   running   2015-09-24 02:16:11 PM   2.4%   392.6M of 512M   151.6M of 1G 
----
<1> The CLI is using a manifest to provide necessary configuration details such as application name, memory to be allocated, and path to the application artifact.
Take a look at `manifest.yml` to see how.
<2> In most cases, the CLI indicates each Cloud Foundry API call as it happens.
In this case, the CLI has created an application record for _Workshop_ in your assigned space.
<3> All HTTP/HTTPS requests to applications will flow through Cloud Foundry's front-end router called http://docs.cloudfoundry.org/concepts/architecture/router.html[(Go)Router].
Here the CLI is creating a route with random word tokens inserted (again, see `manifest.yml` for a hint!) to prevent route collisions across the default `devcloudwest.inbcu.com` domain.
<4> Now the CLI is _binding_ the created route to the application.
Routes can actually be bound to multiple applications to support techniques such as http://www.mattstine.com/2013/07/10/blue-green-deployments-on-cloudfoundry[blue-green deployments].
<5> The CLI finally uploads the application bits to Pivotal Cloudfoundry. Notice that it's uploading _75 files_! This is because Cloud Foundry actually explodes a ZIP artifact before uploading it for caching purposes.
<6> Now we begin the staging process. The https://github.com/cloudfoundry/java-buildpack[Java Buildpack] is responsible for assembling the runtime components necessary to run the application.
<7> Here we see the version of the JRE that has been chosen and installed.
<8> The complete package of your application and all of its necessary runtime components is called a _droplet_.
Here the droplet is being uploaded to Pivotal Cloudfoundry's internal blobstore so that it can be easily copied to one or more _http://docs.cloudfoundry.org/concepts/architecture/execution-agent.html[Droplet Execution Agents (DEA's)]_ for execution.
<9> The CLI tells you exactly what command and argument set was used to start your application.
<10> Finally the CLI reports the current status of your application's health.
====

. Visit the application in your browser by hitting the route that was generated by the CLI:
+
image::lab-java.png[]

== Interact with App from CF CLI

. Get information about the currently deployed application using CLI apps command:
+
----
$ cf apps
----
+
Note the application name for next steps

. Get information about running instances, memory, CPU, and other statistics using CLI instances command
+
----
$ cf app <<app_name>>
----

. Stop the deployed application using the CLI
+
----
$ cf stop <<app_name>>
----

. Delete the deployed application using the CLI
+
----
$ cf delete <<app_name>>
----

Congratulations! You have pushed your first app into Cloud Foundry!

== On to the next Lab!
link:lab-ruby.adoc[Lab1 - Push a Ruby Application]
