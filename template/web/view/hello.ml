open Tyxml

let%html page =
  {|
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
      <link href="/assets/reset.css" rel="stylesheet">
      <link href="/assets/styles.css" rel="stylesheet">
      <title>Hello world!</title>
  </head>
  <body>
    <img class="logo" alt="Sihl Logo" src="/assets/logo.png">
  </body>
</html>
|}
;;
