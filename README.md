# CSV formatter

Design a converter from a CSV file to a table of ASCII characters.
The first line of the file defines the column types.
The next lines are the data itself (separator - semicolon).

Types:

_int_ - integer (right alignment)

_string_ - a string, string data is beaten into words and displayed in a column.

_money_ - monetary unit, formatting 2 decimal places and separator of digits - space.

Source data (as an example):
```
int;string;money
1;aaa bbb ccc;1000.33
5;aaaa bbb;0.01
13;aa bbbb;10000.00
```

At the output of the script:

```
+-----------------+ 
| 1|aaa | 1 000,33| 
|  |bbb |         | 
|  |ccc |         | 
+--+----+---------+ 
| 5|aaaa|     0,01| 
|  |bbb |         | 
+--+----+---------+ 
|13|aa  |10 000,00| 
|  |bbbb|         | 
+--+----+---------+ 
```
## Run
Ruby script should be executive on your machine. There are two options:

Change file privileges by `chmod +x runner.rb` and run like `./runner.rb`
Run via interpeter `ruby runner.rb`
