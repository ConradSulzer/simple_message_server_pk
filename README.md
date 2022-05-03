# MessageServer

Simple endpoint that takes in a GET request with `queue` and `message` query params and prints the message to the terminal IF at least one second has passed since the last time a message was printed from the given queue.

```
GET http://localhost:4000/receive-message/?queue=sandwiches&message=rueben

> rueben
```

Includes testing to prove message are only printed once per second per queue.
