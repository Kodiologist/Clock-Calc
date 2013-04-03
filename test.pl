#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
BEGIN {require 'clock-calc.pl';}

sub f
   {display_hrmin parse_time $_[0]};

is f('noon'), '12:00 pm';
is f('midnight'), '12:00 am';
is f('4 h'), '4 h';
is f('13 hours'), '13 h';
is f('5 minute'), '5 min';
is f('123 m'), '2 h 3 min';
is f('2 pm'), '2:00 pm';
is f('0:00'), '12:00 am';
is f('23:59'), '11:59 pm';
is f('2:00 AM'), '2:00 am';

sub g
   {display_hrmin eval_time_expr $_[0]};

is g('5 min'), '5 min';
is g('5 min + 6 min'), '11 min';
is g('noon + 5 minutes'), '12:05 pm';
is g('2 pm + 1 hour'),  '3:00 pm';
is g('2 pm + 2 h + 13 m'),  '4:13 pm';
is g('2:15 - 5 minutes'), '2:10 am';
is g('2:15 - 20 minutes'), '1:55 am';
is g('noon - 5 minutes'), '11:55 am';
is g('midnight - 5 minutes'), '11:55 pm';
is g('2:15 - 20 m + 20 m + 30 m + 30 m - 1 h'), '2:15 am';
is g('2:15 - 1:00'), '1 h 15 min';

# From the README
is g('2:30 pm - 10:53 am'), '3 h 37 min';
is g('midnight + 100 minutes'), '1:40 am';
is g('1:40 am - 200 minutes'), '10:20 pm';
is g('noon - 45 m - 30 m - 1 h'), '9:45 am';

done_testing;
