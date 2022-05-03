# MessageServer

Simple endpoint that takes in a GET request with `queue` and `message` query params. A queue will be started for each unique value received for `queue`. Messages sent to a queue are printed to the terminal at a rate of one per second.

```
GET http://localhost:4000/receive-message/?queue=sandwiches&message=reuben

> reuben
```


