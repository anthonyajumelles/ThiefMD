File for checking languages and making sure they don't break markdown formatting.

# Python

```python
friends = ['john', 'pat', 'gary', 'michael']
for i, name in enumerate(friends):
    print ("iteration {iteration} is {name}".format(iteration=i, name=name))
```

# JavaScript

```js
$(document).ready(function(){
  $("button").click(function(){
    $("p").hide();
  });
});
```

# Rust

```rust
fn factorial(i: u64) -> u64 {
    match i {
        0 => 1,
        n => n * factorial(n-1)
    }
}
```

# Bash

```bash
#!/bin/bash
echo "Printing text with newline"
echo -n "Printing text without newline"
echo -e "\nRemoving \t backslash \t characters\n"
echo -e `cat file.txt`
```

# Go

```go
package main
import "fmt"
func main() {
    fmt.Println("hello world")
}
```

# Java

```java
public class MyClass {
  public static void main(String[] args) {
    System.out.println("Hello World");
  }
}
```

# Vala

```vala
        private bool writecheck_scheduled = false;
        private void write_good_recheck () {
            if (writegood_limit.can_do_action () && writecheck_active) {
                writegood.recheck_all ();
            } else if (writecheck_active) {
                if (!writecheck_scheduled) {
                    writecheck_scheduled = true;
                    Timeout.add (1500, () => {
                        if (writecheck_active) {
                            writegood.recheck_all ();
                        }
                        writecheck_scheduled = false;
                        return false;
                    });
                }
            }
        }
```

# R

```r
sample(c("H","T"),10, replace = TRUE)
```

# HTML

```html
<div class=""></div>
```

# XML

```xml
<context id="code-block-c" class="no-spell-check" style-ref="markdown:code-block">
    <start>^```c$</start>
    <end>^```$</end>
    <include>
        <context ref="c:c"/>
    </include>
</context>
```

# MATLAB

```matlab
%Create a matrix X of 100 five-dimensional normal variables and a response vector Y from just two components of X, with small added noise.

X = randn(100,5)
r = [0;2;0;-3;0] % only two nonzero coefficients
Y = X*r + randn(100,1)*.1 % small added noise
```

# CSS

```css
.left {
  float: left; }

.right {
  float: right; }

.centered {
  margin: 0 auto 0 auto;
  text-align: center; }

.clearer {
  clear: both; }
```

# Lisp

```lisp
(defun hello ()
  (format t "Hello, World!~%"))
```

# Ruby

```rb
# Ruby code for sample() method 
# declaring array 
a = [18, 22, 33, nil, 5, 6] 
# declaring array 
b = [1, 4, 1, 1, 88, 9] 
# declaring array 
c = [18, 22, 50, 6] 
# sample method example 
puts "sample() method form : #{a.sample(2)}\n\n"
puts "sample() method form : #{b.sample(1)}\n\n"
puts "sample() method form : #{c.sample(3)}\n\n"
```

# Perl

```perl
#!/usr/bin/perl
#
# The traditional first program.
 
# Strict and warnings are recommended.
use strict;
use warnings;
 
# Print a message.
print "Hello, World!\n";
```

# PHP

```php
 <html>
 <head>
  <title>PHP Test</title>
 </head>
 <body>
 <?php echo '<p>Hello World</p>'; ?> 
 </body>
</html>
```

# Haskell

```hs
helloPerson :: String -> String
helloPerson name = "Hello" ++ " " ++ name ++ "!"

main :: IO ()
main = do
   putStrLn "Hello! What's your name?"
   name <- getLine
   let statement = helloPerson name
   putStrLn statement
```

# CPP

```cpp
// Your First C++ Program

#include <iostream>

int main() {
    std::cout << "Hello World!";
    return 0;
}
```

# End of file