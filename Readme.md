More expressive error creation
==============================

For Node.js only ATM.

Usage:

``` javascript
  Error2 = require("error2");

  Error2();
  Error2(data);
  Error2(message);
  Error2(name, data);
  Error2(name, message);
  Error2(name, message, data);
```

where

``` javascript
  typeof name     === "string"
  typeof message  === "string"
  typeof data     === "object"
```

`data` object can contain `name` and `message` properties, which will therfore be used.

Please consult [test cases](test/Error2.coffee) for more funny and informative examples of use.
