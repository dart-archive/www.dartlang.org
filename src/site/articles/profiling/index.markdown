--- 
layout: default
title: "Benchmarking Dart Applications"
description: "Learn how to benchmark your applications"
rel:
    author: john-mccutchan
has-permalinks: true
---

# {{ page.title }}
_Written by John McCutchan <br>
October 2012_

Programmers often create benchmarks which exercise an important algorithm in a
larger application. The point of the benchmark is to have an easy to run,
reproducible stress test of the performance sensitive algorithm.
The benchmark verifies that changes to the algorithm are indeed
improvements, and not regressions.

##Benchmarking Dart

Dart can go really fast, but you have to give the VM time to optimize your code.
Most benchmarks we've seen are short and to the point—so short that they don’t
trigger the VM’s optimizer. This isn’t an issue with real-world applications,
which execute long enough to be optimized. Read on to find out how to correctly
set up a Dart benchmark.

###Performing warm-ups

The Dart VM is designed to start running your application code immediately with
minimal startup time. In order to achieve this goal, code optimization is
delayed until a function becomes "hot". Code becomes hot when it has been run
numerous times.

To correctly benchmark Dart, you need to let Dart warm up. For Dart a warm-up is
a simple for loop:

{% highlight dart %}
// Warm-up
for (int i = 0; i < 2000; i++) {
    benchmarkCode();
}
{% endhighlight %}

After the warm-up the function is optimized. Now it’s time to measure the
performance:

{% highlight dart %}
var stopwatch = new Stopwatch();
stopwatch.start(); //Start timer.
benchmarkCode();
stopwatch.stop(); // Stop timer.
var elapsed = stopwatch.elapsedInUs(); // Get the microseconds.
{% endhighlight %}

The above code uses Dart’s
[Stopwatch](http://api.dartlang.org/docs/bleeding_edge/dart_core/Stopwatch.html)
class, which measures time with high precision and low overhead—exactly what you
need when profiling.

###Run in production mode with debugging disabled

The Dart VM can run in two modes: checked and production mode. Checked mode is
slower because the VM is checking types at runtime. Before benchmarking make
sure that your code runs without issue in checked mode. If checked mode finds an
issue, it will likely cause a performance drop in production mode. After making
sure your program is correct, you should run your benchmark in production mode
to get an accurate measurement of real world performance.

When executing from the command line checked mode is off by default and can be
turned on by passing the `--checked` command line flag. The editor has checked
mode on by default but can be turned off by going to the ‘Manage Launches’
window. It's important to **disable debugging** as well because that also has an
impact on run-time performance.

<div style="display:block; margin-left:auto; margin-right:auto"><img src="checkedmode.png" /></div>

##Summary

When benchmarking your application be sure to follow these three rules:

1. Perform a warm-up before measuring code performance.
1. Ensure the code does not raise any errors when run in checked mode.
1. Run your benchmark in production mode with debugging disabled.

If you follow these rules you will be able to accurately measure how fast your
code runs. Once you've sped up your application, share your secrets on the
[mailing list](https://groups.google.com/a/dartlang.org/forum/?fromgroups#!forum/misc).
Happy benchmarking!
