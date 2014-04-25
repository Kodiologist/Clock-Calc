Clock-Calc lets you quickly do arithmetic with clock times on the command line::

    $ ./clock-calc.pl 2:30 pm - 10:53 am
    3 h 37 min
    $ ./clock-calc.pl 10:53 - now     # Assuming it's 10:37 am
    16 min
    $ ./clock-calc.pl midnight + 100 minutes
    1:40 am
    $ ./clock-calc.pl 1:40 am - 200 minutes
    10:20 pm
    $ ./clock-calc.pl noon - 45 m - 30 m - 1 h
    9:45 am

See the tests for more examples. One missing feature that's worth pointing out is parentheses. But since there are only two operators, you don't really need parentheses.

Perl 5.10 or greater is required. The tests use the Perl module Test::More.

What's the point? Can't you just do this kind of thing in your head?
====================================================================

Yes, but it's easier to fix bugs in programs than in my mental-arithmetic skills. Remember, `laziness is the first great virtue of a programmer`__.

..
__ http://perldoc.perl.org/perlglossary.html#laziness

License
============================================================

This program is copyright 2013, 2014 Kodi Arfer.

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the `GNU General Public License`_ for more details.

.. _`GNU General Public License`: http://www.gnu.org/licenses/
