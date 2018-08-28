# Spring Cloud Services Lab

*Fortune Teller* is a very basic application composed of two services:

[Fortune Service](fortune-teller-fortune-service) - serves up random Chinese fortune cookie fortunes
[Fortune UI] - presents a UI that consumes the fortune service

It leverages libraries and services from Spring Cloud and Netflix OSS to compose the system.

Fortune Teller is deployable to any Cloud Foundry environment utilizing the service components that have been packaged with the project.
However, it is most easily deployed to Pivotal Cloud Foundry environments that have installed the https://network.pivotal.io/products/p-spring-cloud-services[Spring Cloud Services] package.

## Building
Using Maven, build and package the application:
```
$ cd spring-cloud-services-app
$ mvn package
```
Maven will automatically download all of _Fortune Teller_'s dependencies. This may take a few moments.


## Deploying to Pivotal Cloud Foundry with Spring Cloud Services

. Run `scripts/create_services_pcf.sh` to create the services that you need:
+
----
$ ./scripts/create_services_pcf.sh
Creating service fortune-db in org microservices / space fortune-teller as admin...
OK
Creating service config-service in org microservices / space fortune-teller as admin...
OK
Creating service service-registry in org microservices / space fortune-teller as admin...
OK
Creating service circuit-breaker in org microservices / space fortune-teller as admin...
OK
----

. In the Pivotal Cloud Foundry Apps Manager console, click on the *Manage* link for the *Config Server*. Once the service is initialized and the web form appears, paste the URL of this repository (https://github.com/bbertka/PCF-Workshop-Dis) into the *Git URI* field and "spring-cloud-services-app/configuration" into the *Search Paths* field. Then click *Submit*.

. Also click on the *Manage* links for the *Service Registry* and *Circuit Breaker*. Make sure the services are finished initializing before you proceed.

. Edit the `manifest-pcf.yml` file to specify the Cloud Foundry target the apps are being pushed to, replacing the URL in `CF_TARGET: https://api.cf.deepsouthcloud.com` with the API endpoint for your Cloud Foundry deployment.

. Push the microservices:

+
----
$ cf push
----
+
This will push the fortunes service and the ui application and bind all of the services.


## Testing the Application

. In a browser, access the fortunes-ui application at the route that was created for you:
+
image:docs/images/fortunes_1.png[]

. Now, in another browser tab, access the Hystrix Dashboard at the route that was created for you.
Enter the route for the UI application and click the ``Monitor Stream.''
+
NOTE: On Pivotal Cloud Foundry, you can access a pre-configured Hystrix Dashboard by clicking on the *Manage* link for *Circuit Breaker Dashboard*. You will *NOT* need to paste in the route.
+
image:docs/images/fortunes_2.png[]

. Access the fortunes-ui and show that the circuit breaker is registering successful requests.
+
image:docs/images/fortunes_3.png[]

. Stop the fortunes application:
+
----
$ cf stop fortunes
----

. Access the fortunes-ui and see that the ``fallback fortune'' is being returned.
+
image:docs/images/fortunes_4.png[]

. Access the fortunes-ui and show that the circuit breaker is registering short-circuited requests.
+
image:docs/images/fortunes_5.png[]

. Start the fortunes application:
+
----
$ cf start fortunes
----

. Continue to access the fortunes-ui and watch the dashboard.
After the fortunes service has re-registered with Eureka and the fortunes-ui load balancer caches are refreshed, you will see the circuit breaker recover.
You should then start getting random fortunes again!
