<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>Document</title>
    </head>
    <body>
        @if($name == "Roger")
        <h1>Hello Admin {{ $name; }}</h1>
        @else 
        <h1>Hello {{ $name; }}</h1>
        @endif 
    </body>
</html>
