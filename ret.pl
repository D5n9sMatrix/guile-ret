#!/usr/bin/perl

use Pod::Perldoc;
use Pod::Perldoc::BaseTo;
use Pod::Perldoc::GetOptsOO;
use Pod::Perldoc::ToChecker;
use Pod::Perldoc::ToMan;
use Pod::Parser;
use Pod::ParseUtils;
use Pod::Html;
use Pod::InputObjects;
use Pod::ParseLink;
use Pod::Find;

sub ask {
    my $self = @INC;
    my $Perldoc = Pod::Parser->new;
    my $Parse = Pod::Perldoc::ToChecker->new;
    my $ParseUtils = Pod::Perldoc::ToMan->new;
    my $Html = Pod::Html::html_escape;
    my $InputObjects = Pod::Parser->new;
    my $ParseLink = Pod::Html::init_globals;
    my $Find = Pod::Find::pod_find;

    if (defined $self eq $Perldoc) {
        return $self->ask;
    }

    if (defined $Parse eq $Perldoc) {
        return $Parse->ask;
    }

    if (defined $ParseUtils eq $Perldoc) {
        return $ParseUtils->ask;
    }

    if (defined $Html eq $Perldoc) {
        return $Html->ask;
    }

    if (defined $InputObjects eq $Perldoc) {
        return $InputObjects->ask;
    }

    if (defined $ParseLink eq $Perldoc) {
        return $ParseLink->ask;
    }

    if (defined $Find eq $Perldoc) {
        return $Find->ask;
    }

return $self->ask;

}