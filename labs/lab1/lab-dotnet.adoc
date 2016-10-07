= Lab 1 - Pushing a .NET Application

== Target the Environment

. Follow the instructions to link:../README.adoc[Get Environment Access]

== Push It!

. Change to the _DotNet-cf-sample-app_ sample application directory:
+
----
$ cd $BOOTCAMP_HOME/dotnet-cf-sample-app
----

. Push the application!
+
----
$ cf push
----

== Add a Database service

. Bind the mysql service you previously added to the Java application using the apps manager interface

Notice that the data is the same as the java app

. Make a change to the data by deleting from the java app -- notice the data is updated in the .NET app.


== View the .NET environment

. Go to the secret endpoint in your app: /?all=

You can see the Windows container and app environment variables


== On to the next Lab!
link:../../labs/lab2/README.adoc[Lab2 - Binding to Cloud Foundry Services]
