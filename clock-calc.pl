#!/usr/bin/perl

use 5.10.0;
use warnings;
use strict;
use POSIX 'floor';

use constant RELATIVE => 0;
use constant ABSOLUTE => 1;

sub hrmin
# This constructor does the right wrapping and carrying for
# out-of-range (negative or above-the-maximum) values.
   {my ($hour, $min, $absolute) = @_;
    {
        hour => ($hour + floor($min / 60)) % 24,
        min => $min % 60,
        absolute => $absolute == ABSOLUTE};}

sub display_hrmin
   {my $item = shift;
    if ($item->{absolute})
       {sprintf '%d:%02d %s',
            $item->{hour} == 0
              ? 12
              : $item->{hour} > 12
              ? $item->{hour} - 12
              : $item->{hour},
            $item->{min},
            $item->{hour} > 11 ? 'pm' : 'am'}
     else
       {join ' ',
            ($item->{hour} == 0 ? () : (sprintf '%d h', $item->{hour})),
            ($item->{min} == 0 ? () : (sprintf '%d min', $item->{min}))
          or '0'}}

sub parse_time
   {my $str = lc shift;
    $str =~ s/\A\s+//;
    $str =~ s/\s+\z//;
    given ($str)
       {when ('midnight') {hrmin 0, 0, ABSOLUTE}
        when ('noon') {hrmin 12, 0, ABSOLUTE}
        when ('now')
           {my ($sec, $min, $hr) = localtime;
            hrmin $hr, $min + ($sec >= 30), ABSOLUTE}
        when ('0') {hrmin 0, 0, RELATIVE}
        when (/\A(\d+)\s+h/) {hrmin $1, 0, RELATIVE}
        when (/\A(\d+)\s+m(?:\Z|s|in)/) {hrmin 0, $1, RELATIVE}
        when (/\A(\d+)(?::(\d+))?(?:\s+(am|pm))?/)
           {my ($hour, $min, $ampm) = ($1, $2 // 0, $3);
            $hour =
                $hour eq '12'
              ? defined $ampm && $ampm eq 'am'
                ? 0
                : 12
              : defined $ampm && $ampm eq 'pm'
                ? $hour + 12
                : $hour;
            hrmin $hour, $min, ABSOLUTE;}
        default
           {die "No parse: $_"}}}

sub eval_time_expr
   {my $str = shift;
    my $sum = hrmin 0, 0, RELATIVE;
    while ($str =~ /(?:\A|\s*([-+])\s*)([^-+]+)/g)
       {my ($sign, $val) = ($1 // '+', parse_time $2);
        $sign = $sign eq '+' ? 1 : -1;
        $sum = hrmin
            $sum->{hour} + $sign * $val->{hour},
            $sum->{min} + $sign * $val->{min},
            $sum->{absolute} && $val->{absolute} && $sign == -1
              ? RELATIVE
              : $sum->{absolute} || $val->{absolute}
              ? ABSOLUTE
              : RELATIVE;}
    $sum;}

# --------------------------------------------------

unless (caller)
   {say display_hrmin eval_time_expr join ' ', @ARGV;}
