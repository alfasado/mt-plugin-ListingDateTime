package ListingDateTime::Listing;
use strict;
use warnings;

use MT::Util qw( ts2epoch epoch2ts offset_time );

sub _log_created_at_raw {
    my $prop = shift;
    my ( $obj, $app, $opts ) = @_;
    my $ts   = $obj->created_on;
    my $blog = $opts->{blog};
    my $epoch = ts2epoch( undef, $ts, 1 );
    $epoch = offset_time( $epoch, $blog );
    return epoch2ts( $blog, $epoch, 1 );
}

sub _log_created_at_html {
    my $prop = shift;
    my ( $obj, $app, $opts ) = @_;
    my $ts          = $prop->raw(@_) or return '';
    my $date_format = '%Y/%m/%d %H:%M:%S';
    my $blog        = $opts->{blog};
    my $date = MT::Util::format_ts( $date_format,
                                    $ts,
                                    $blog,
                                    $app->user ? $app->user->preferred_language : undef );
     $date =~ s! !<br>!;
     return $date;
}

sub _log_created_at_sort {
    my $prop = shift;
    my ( $terms, $args, $opts ) = @_;
    $args->{sort} = 'created_on';
    return;
}

sub _entry_publish_at_raw {
    my $prop = shift;
    my ( $obj, $app, $opts ) = @_;
    my $ts   = $obj->authored_on;
    my $blog = $opts->{blog};
    my $epoch = ts2epoch( undef, $ts, 1 );
    return epoch2ts( $blog, $epoch, 1 );
}

sub _entry_publish_at_html {
    my $prop = shift;
    my ( $obj, $app, $opts ) = @_;
    my $ts          = $prop->raw(@_) or return '';
    my $date_format = '%Y/%m/%d %H:%M:%S';
    my $blog        = $opts->{blog};
    my $date = MT::Util::format_ts( $date_format,
                                    $ts,
                                    $blog,
                                    $app->user ? $app->user->preferred_language : undef );
     $date =~ s! !<br>!;
     return $date;
}

sub _entry_publish_at_sort {
    my $prop = shift;
    my ( $terms, $args, $opts ) = @_;
    $args->{sort} = 'authored_on';
    return;
}

1;
