#!/usr/bin/perl
use tigge;
use Data::Dumper;

my $info = tigge::read_info(@ARGV[0]);

open(out," > tigge_parameter.def");
print out <<"EOF";
# Automatically generated by $0, do not edit

EOF

my %x;

foreach my $n ( sort keys %{$info} )
{
	my $p = $info->{$n}->{'mars.param'};
	my $z = $info->{$n};

	if(exists $x{$p})
	{
		# Find differences
		my %z;
		my @z = keys %{$x{$p}};

		foreach my $k ( keys %{$z} )
		{
			$z{$k} = $z->{$k} if($x{$p}->{$k} eq $z->{$k});
		}

		$z = \%z;
	}

	$x{$p} = $z;

}

foreach my $k ( sort { $x{$a}->{tigge_name} cmp $x{$b}->{tigge_name} } keys %x )
{
	print out "# $x{$k}->{tigge_name} \n";
	print out "   '$k' = {\n";

	foreach my $m ( sort keys %{$x{$k}} )
	{

		next if($m =~ /\./);
		next if($m =~ /\_/);
		my $v = $x{$k}->{$m};
		next if($v =~ /#/);
		next if($v =~ /missing/i);

		print out "         $m = $v;\n";
	}

	print out "   }\n\n";
}

close out;
open(out," > tigge_short_name.def");
print out <<"EOF";
# Automatically generated by $0, do not edit

EOF

foreach my $k ( sort { $x{$a}->{'mars.abbreviation'} cmp $x{$b}->{tigge_name} } keys %x )
{
	#print "# $x{$k}->{tigge_name} \n";
	print out "   '$x{$k}->{'mars.abbreviation'}' = { parameter = $k; }\n";
}

close out;

open(out," > tigge_name.def");
print out <<"EOF";
# Automatically generated by $0, do not edit

EOF

foreach my $k ( sort { $x{$a}->{tigge_name} cmp $x{$b}->{tigge_name} } keys %x )
{
	print out "   '$x{$k}->{tigge_name}' = { parameter = $k; }\n";
}

close out;