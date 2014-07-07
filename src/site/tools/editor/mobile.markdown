---
layout: default
title: "Dart Web Apps on Android"
description: "How to set up and test a Dart app on an Android device"
header:
  css: ["editor.css"]
---

{% include toc.html %}
{% include breadcrumbs.html %}

# {{ page.title }}

You can launch and debug your web app on an Android device without first
compiling to JavaScript. To do so, you need Dart Editor and an app called
Dart Content Shell, which Dart Editor automatically installs on the Android
device. You can also set breakpoints in Dart Editor to debug your app
running in Dart Content Shell on Android, just as you would for
any other Dart app.

To configure your environment for mobile development, you first need:

* An Android device, such as a phone or tablet
* A USB cable to connect your Android device to your computer
* Chrome installed on your computer and on your Android device

For a more complete description of the requirements, see
[Remote Debugging on Android with Chrome](https://developer.chrome.com/devtools/docs/remote-debugging).

##  Step 1: Set up your computer {#set-up-computer}

[Download Dart Editor](/tools/download.html), which comes bundled with
the Android Debug Bridge (adb) and Dart Content Shell for Android.

## Step 2: Set up your Android device {#set-up-android-device}

Enable USB debugging on the device, as described in Step 1 of
[Set up remote debugging](https://developer.chrome.com/devtools/docs/remote-debugging#setting-up-device). (Return to this document after Step 1.)

## Step 3: Connect the device to your computer {#connect-the-devices}

Physically connect your Android device to your computer,
using the USB cable. Grant permission for USB debugging on the device,
as described in Step 3 of
[Connect your device via USB](https://developer.chrome.com/devtools/docs/remote-debugging#connect-device-via-usb).
(Return to this document after Step 3.)

## Step 4: Set up port forwarding {#set-up-port-forwarding}

Unless you are using a home network, you probably need to set up
port forwarding. If you are wondering what port forwarding is,
see [What is port forwarding and why might I need it?](#why-port-forwarding)

<aside class="alert alert-info" markdown="1">
**Note:** Chrome must run on both devices at all times while testing
your app on Android. Chrome passes the packets back and forth between the
devices, which is why you set up port forwarding in Chrome. (While it works
to set up port forwarding in Dartium, we do not recommend using
Dartium as your everyday browser.)
</aside>

  Check that the Recent Apps screen on your Android device shows that
  Chrome is running:

 <div class="step-details2" markdown="1">
 <img src="images/AndroidRecentApps.jpg" alt="the Recent Apps screen on an Android device showing that Chrome is running">
 </div>

To set up port forwarding:

* Launch Chrome on your Android device.
* Launch Chrome on your computer and navigate to `chrome://inspect/#devices`.

  You should see the following:

 <div class="step-details2" markdown="1">
 <img src="images/SetupPortForwarding.png" alt="the Chrome screen used for setting up port forwarding">
 </div>

* Check the **Discover USB devices** box.

* Click the **Port forwarding...** button to bring up the 
  **Port forwarding settings** dialog.

* If you don't already see 8080 in the dialog, enter `8080` for the port,
  and `localhost:8080` for the IP address and port.
  Press Enter to add this port to the list.

* Make sure the **Enable port forwarding** box is checked.
  The dialog should now look like the following:

 <div class="step-details2" markdown="1">
 <img src="images/PortForwardingSettings.png" alt="the Port forward settings dialog">
 </div>
  
* Click **Done**.

  Next to the name of the device, you should now see port 8080 listed:

 <div class="step-details" markdown="1">
 <img src="images/PortList.png" alt="Port 8080 showing on the Chrome port forwarding screen">
 </div>

  If the green dot and port number are absent, then Chrome on your Android
  device cannot communicate with Chrome on your computer.
  Make sure that Chrome is running on the Android device.

## Step 5: Launch your app on the Android device {#test-app-on-android}

The simplest way to test an app on your Android device is to right-click
the HTML file in Dart Editor to bring up the following context menu:

   <div class="step-details2" markdown="1">
   <img src="images/ContextRunMenu.png" alt="The three run options from the context menu">
   </div>

Click **Run on Mobile**.

Status is displayed in Dart Editor. After a moment, you should see the
app running in Dart Content Shell on the device.

Most of the time, this just works. If not, see [Problems?](#problems).

##  Step 6: Debug your app {#debug}

When your app is running on the Android device, you can set breakpoints
in Dart Editor just as you would to debug any Dart app.

You can debug the app if you see a "Remote" connection in the debugger
view (**Tools > Debugger**).
If the debugger view shows that remote is terminated, relaunch the app.

---

## Frequently Asked Questions (FAQ) {#faq}

Here are some frequently asked questions about running Dart web apps
in the content shell on Android:

### What apps are downloaded to my Android device? {#what-apps-downloaded}

On the first mobile launch of each Dart Editor session, two apps are
downloaded to your Android device:

* The Dart Content Shell, a streamlined version of Chromium that
  includes the Dart VM. During testing, your app runs in the content shell.

* A small connection test app, designed to detect problems accessing the
  web server. If any problems are detected, this app communicates back
  to Dart Editor.

### What is port forwarding and why might I need it? {#why-port-forwarding}

Unless you are working on a home network, you probably need port forwarding.

_Port forwarding_ is a communication mechanism that translates an address
(or port number) to a new destination. It is required when your computer
is behind a firewall, or your computer and your Android device are not
on the same WiFi network, or you are connected to a public
WiFi hotspot that does not allow cross device local communication.

The following diagram shows how port forwarding works. The Dart Content
Shell, a streamlined version of Chromium that includes the Dart VM,
issues a request. Chrome (running an Android) forwards the request to
Chrome (running on your computer), which forwards the request to port
8080. [pub serve](/tools/pub/) is listening to port 8080, and responds
with content.  This response is returned to Chrome on Android, which
passes the information to Dart Content Shell. The content shell renders
the response.

<div class="step-details2" markdown="1">
<img src="images/MobileDeployment.png" alt="diagram showing how port forwarding works">
</div>

### What is the difference between "Pub serve over USB" and "Embedded server over WiFi network"? {#what-pub-serve}

If you choose to configure your mobile launch manually in the
**Manage Launches** dialog, you will see a pull down menu in the
**Server** box. This menu provides two options:

* **Pub serve over USB**
: If you are behind a firewall, or using a public WiFi hotspot, or your
  computer and your Android device are not on the same WiFi
  network, select `Pub serve over USB` and set up port forwarding.
  Most developers will use this option.

* **Embedded server over WiFi network**
: If you are developing on a residential network without a firewall,
  for example, you can probably use the server that is embedded in Dart Editor.
  In this case, select **Embedded server over WiFi network**.
  It is not necessary to set up port forwarding.

##  Problems? {#problems}

If you are using port forwarding, make sure that Chrome is running on
both devices while testing your app. You set up port forwarding in Chrome
because Chrome is passing the packets between the devices.

If you have followed the steps and Dart Editor still cannot see your
Android device (reporting the message "No mobile found or USB development
not enabled on mobile"), try unplugging and plugging in the device again.

If you see one of the following dialogs in Dart Editor,
follow the directions to address the problem.
(The first dialog appears when an "Embedded server over WiFi
network" launch fails, and the second dialog appears when a "Pub serve over
USB" launch fails.)

<div class="step-details" markdown="1">
<img src="images/PubServeLaunchFailed.png" alt="Dialog that displays when a pub serve launch fails">
</div>

<div class="step-details" markdown="1">
<img src="images/EmbeddedServerLaunchFailed.png" alt="Dialog that displays when an embedded server launch fails">
</div>
