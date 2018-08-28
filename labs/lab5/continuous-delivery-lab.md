= CF Workshop Continuous Delivery Lab

== Intro

This lab will guide you through building a *BASIC* continuous delivery pipeline using Jenkins and Cloud Foundry.

== Initial Setup

. Fork the Spring-Music repository. If you do not have a github account, you can skip this step and use my repository.

  `https://github.com/cloudfoundry-samples/spring-music.git`
  
. Edit the manifest.yml at the root of the forked spring-music repository. Change the *host* from ${random-word} to your initials. Jenkins does not like the special characters in the host field and will give an error.
  
. Login to your Jenkins instance at https://jenkins-0.sys.yourcompany.com/ with the same username and password that you use for CloudFoundry.


== Create the Build Job

. Click *New Item*, give it the name *spring-music* and select ``Build a free-style software project.'' Then click +OK+.

== Configure Git

. Under *Source Code Management*, select *Git*, and supply your repository URL (e.g. `https://github.com/<YOUR_GIT_USERNAME>/spring-music`). Leave credentials as *none*.

== Configure Gradle Build

. Select *Add Build Step* and then *Invoke Gradle Script*.

. Select *Use Grade Wrapper*.

. Check both *Make gradlew executable* and *From Root Build Script Directory*.

. In switches, enter `-Pbuildversion=$BUILD_NUMBER`.

. In tasks, enter `clean assemble`.

. In build file, enter `build.gradle`.

. Check *Force GRADLE_USER_HOME to use workspace.

. On "Build Triggers", select "Build when a change is pushed to GitHub"

== Execute Shell
[source,bash]
----
DEPLOYED_VERSION_CMD=$(CF_COLOR=false cf apps | grep 'mapUS.' | cut -d" " -f1)
export BUILD_VERSION="1.2"
export DEPLOYED_VERSION_CMD
echo DEPLOYED_VERSION_CMD
export ROUTE_VERSION="default"
echo "Deployed Version: $DEPLOYED_VERSION"
echo "Route Version: $ROUTE_VERSION"
export API=https://api.sys.yourcompany.com

wget -O cf.tgz https://cli.run.pivotal.io/stable?release=linux64-binary&version=6.13.0&source=github-rel
sleep 5
tar -zxvf ./cf.tgz

./cf api --skip-ssl-validation $API
./cf login -u <user> -p <password> -o <org> -s <space>

./cf push -f manifest.yml 
----


== Execute Build Job

. Select *Build Now*.

. Select the build in *Build History*, then select *Console Output*.

. Jenkins should build and push the app, then you can click the link at the bottom to see the running app.
