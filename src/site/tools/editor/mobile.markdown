---
layout: default
title: "Dart Web Apps on Android"
description: "How to set up and test a Dart app on an Android device"
header:
  css: ["editor.css"]
---

{% include breadcrumbs.html %}

# {{ page.title }}

<h4>Contents</h4>
<ol class="toc">
  <li> <a href="#set-up-development-machine">Step 1:
       Set up your development machine</a> </li>
  <li> <a href="#set-up-android-device">Step 2: Set up your Android
       device</a></li>
  <li> <a href="#connect-the-devices">Step 3: Connect and configure the
       devices</a></li>
  <li> <a href="#set-up-port-forwarding">Step 4: Set up port forwarding</a></li>
  <li> <a href="#test-app-on-android">Step 5: Launch your app on the
       Android device</a></li>
  <li> <a href="#notes">Notes</a></li>
  <li> <a href="#debug">Debug</a></li>
  <li> <a href="#problems">Problems?</a></li>
</ol>

The ability to launch your web app from Dart Editor on an Android
device, is introduced in Dart 1.5. You can set breakpoints in Dart
Editor to debug your Dart web app running in the Dart Content Shell
on Android, just as you would for any other Dart app.

To configure your environment for mobile development, you need:

* An Android phone or tablet.
* A USB cable to connect the Android device to your development machine.
* Chrome installed on your development machine and on your Android device.

For a more complete description of the requirements, see
[Remote Debugging Chrome on Android](https://developer.chrome.com/devtools/docs/remote-debugging).

##  Step 1: Set up your development machine {#set-up-development-machine}

[Download Dart Editor](/tools/download.html), which comes bundled with
the Android Debug Bridge (adb) and the Dart Content Shell for Android.

## Step 2: Set up your Android device {#set-up-android-device}

Enable USB debugging on the device, as described in
[Setting up your device](https://developer.chrome.com/devtools/docs/remote-debugging#setting-up-device).

## Step 3: Connect and configure the devices {#connect-the-devices}

Physically connect the Android device to your development machine,
using the USB cable, as described in [Connect your
device](https://developer.chrome.com/devtools/docs/remote-debugging#connect-device-via-usb).

## Step 4: Set up port forwarding {#set-up-port-forwarding}

The following diagram shows how port forwarding works: The Dart content
shell, a streamlined version of Chromium that includes the Dart VM,
issues a request. Chrome forwards the request to [pub serve](/tools/pub/),
which responds with content.
This response is returned to the device and rendered.

<div class="step-details2" markdown="1">
<img src="images/MobileDeployment.png" alt="diagram showing how port forwarding works">
</div>

To set up port forwarding:

* Launch Chrome on the Android device.
* Launch Chrome on your computer and navigate to `chrome://inspect/#devices`.

  You should see the following:

 <div class="step-details2" markdown="1">
 <img src="images/SetupPortForwarding.png" alt="the Chrome screen used for setting up port forwarding">
 </div>

* Check the `Discover USB devices` box.

* Click the `Port forwarding...` button to bring up the 
  `Port forwarding settings` dialog.

* If it is not already there, enter `8080` for the port,
  and `localhost:8080` for the IP address and port.
  Press Enter to add this port to the list.

* Make sure the `Enable port forwarding` box is checked.
  The dialog should now look like the following:

 <div class="step-details2" markdown="1">
 <img src="images/PortForwardingSettings.png" alt="the Port forward settings dialog">
 </div>
  
* Click `Done`.

  Next to the name of the device, you should now see port 8080 listed:

 <div class="step-details" markdown="1">
 <img src="images/PortList.png" alt="Port 8080 showing on the Chrome port forwarding screen">
 </div>

  If the green dot and port number are absent, then Chrome on the Android
  device cannot communicate with Chrome on the developer machine.
  Please make sure that Chrome is running in the foreground on the
  Android device.

## Step 5: Launch your app on the Android device {#test-app-on-android}

The simplest way to test an app on the Android device is to right
click on the HTML file in Dart Editor to bring up the following
context menu:

   <div class="step-details2" markdown="1">
   <img src="images/ContextRunMenu.png" alt="The three run options from the context menu">
   </div>

Click **Run on Mobile**.

Status is displayed in Dart Editor. After a moment, you should see the
app running in the Dart content shell on the device.

Most of the time, this just works. If not, see [Problems?](#problems).

---

## Notes {#notes}

On the first mobile launch of each Dart Editor session, two apps are
downloaded to your Android device:

* The Dart Content Shell, a streamlined version of Chromium that
  includes the Dart VM. During testing, your app runs in the content shell.

* A small connection test app, designed to detect problems accessing the
  web server. If any problems are detected, this app communicates back
  to Dart Editor.

If you choose to configure your mobile launch manually in the
**Manage Launches** dialog, you will see a pull down menu in the
**Server** box. This menu provides two options:

* **Pub serve over USB**
: If you are behind a firewall, or using a public wifi hotspot, or your
  development machine and your Android device are not on the same wifi
  network, select `Pub serve over USB` and set up port forwarding.
  Most developers will use this option.

* **Embedded server over WiFi network**
: If you are developing on a residential network without a firewall,
  for example, you can probably use the server that is embedded in Dart Editor.
  In this case, select **Embedded server over WiFi network**.
  It is not necessary to set up port forwarding.

##  Debug {#debug}

When the app is running on the Android device, you can set breakpoints
in Dart Editor just as you would to debug any Dart app.

You can debug the app if you see a "Remote" connection in the debugger
view (**Tools > Debugger**).
If the debugger view shows that remote is terminated,
you will need to relaunch the app.

##  Problems? {#problems}

If you have followed the steps and Dart Editor still cannot see your
Android device (reporting "No mobile found or USB development not enabled
on mobile"), try unplugging and plugging in the device again.

If you launch your web application on the Android device and the device
can't load the web page from the local server running on the development
machine, then the browser on the device will be blank, and you will see
one of the following dialogs. Follow the directions specified in the
dialog to address the problem.

<div class="step-details" markdown="1">
<img src="images/PubServeLaunchFailed.png" alt="Dialog that displays when a pub serve launch fails">
</div>

<div class="step-details" markdown="1">
<img src="images/EmbeddedServerLaunchFailed.png" alt="Dialog that displays when an embedded server launch fails">
</div>
