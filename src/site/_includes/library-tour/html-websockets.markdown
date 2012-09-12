### WebSockets {#html-websockets}

A WebSocket allows your web app to exchange data with a server interactively&mdash;no
polling necessary.
A server creates the WebSocket and listens for requests on
a URL that starts with **ws://**&mdash;for example,
ws://127.0.0.1:1337/ws.
The data transmitted over a WebSocket can be
a string, a blob, or an
[ArrayBuffer](http://api.dartlang.org/html/ArrayBuffer.html).
Often, the data is a JSON-formatted string.

To use a WebSocket in your web app,
first create a [WebSocket](http://api.dartlang.org/html/WebSocket.html) object,
passing the WebSocket URL as an argument.

{% highlight dart %}
var webSocket = new WebSocket('ws://127.0.0.1:1337/ws');
{% endhighlight %}


#### Sending data

To send string data on the WebSocket, use the send() method.

{% highlight dart %}
sendMessage(String data) {
  if (webSocket.readyState == WebSocket.OPEN) {
    webSocket.send(data);
  } else {
    print('WebSocket not connected, message $data not sent');
  }
}
{% endhighlight %}


#### Receiving data

To receive data on the WebSocket,
register a listener for message events.

{% highlight dart %}
webSocket.on.message.add((e) {
  receivedMessage(e.data);
});
{% endhighlight %}

The message event handler receives a
[MessageEvent](http://api.dartlang.org/html/MessageEvent.html) object.
This object's `data` field has the data from the server.
Here's an example of decoding a JSON string sent on a WebSocket,
where the JSON string has two fields,
"from" and "content".

{% highlight dart %}
// Called from the message listener like this: receivedMessage(e.data)
receivedMessage(String data) {
  Map message = JSON.parse(data);
  if (message['from'] != null) {
    print('Message from ${message["from"]}: ${message["content"]}');
  }
}
{% endhighlight %}

#### Handling WebSocket events

[WebSocketEvents](http://api.dartlang.org/html/WebSocketEvents.html)
defines the WebSocket events your app can handle:
open, close, error, and (as shown above) message.
Here's an example of a method that
creates a WebSocket object
and handles message, open, close, and error events.

{% highlight dart %}
connectToWebSocket([int retrySeconds = 2]) {
  bool encounteredError = false;
  webSocket = new WebSocket(url);

  webSocket.on.message.add((e) {
    receivedMessage((e as MessageEvent).data);
  });

  webSocket.on.open.add((e) {
    print('Connected');
  });

  webSocket.on.close.add((e) {
    print('web socket closed, retrying in $retrySeconds seconds');
    if (!encounteredError) {
      window.setTimeout(() => connectToWebSocket(retrySeconds*2),
                                                 1000*retrySeconds);
    }
    encounteredError = true;
  });

  webSocket.on.error.add((e) {
    chatWindow.displayNotice('Error connecting to ws');
    if (!encounteredError) {
      window.setTimeout(() => connectToWebSocket(retrySeconds*2),
                                                 1000*retrySeconds);
    }
    encounteredError = true;
  });
}
{% endhighlight %}