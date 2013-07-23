# A simple Perl script to convert OmniFocus Export to HTML to WikiMedia format

$curfile = $ARGV[0];

open (INPUT, $curfile);

local $/ = undef;

$lines = <INPUT>;

close (INPUT);

# Folders to H1
$lines =~ s/<tr class="omnifocus-folder">.*?<td style="" class="level-0 wrap"><img class="folder" \/>([^<]*)<\/td>.*?<td><\/td><td><\/td><td><\/td><td><\/td><td><\/td><td><\/td><td><\/td><\/tr>/=$1=/gis;

# Projects to H2
$lines =~ s/<tr class="omnifocus-project">.*?<td style="" class="level-1 wrap"><img class="project[-active]*" \/>([^<]*)<\/td>.*?<td><\/td><td><\/td><td><\/td><td><\/td><td><\/td><td><\/td><td><\/td><\/tr>/==$1==/gis;

# Strip notes
$lines =~ s/<tr class="omnifocus-note">.*?<\/tr>//gis;

# Levels to top level bullets - should be improved but I was getting weird indentation
$lines =~ s/<td[^>]*class="level-1[^"]*"[^>]*>(.*?)<\/td>/* $1/gis;
$lines =~ s/<td[^>]*class="level-2[^"]*"[^>]*>(.*?)<\/td>/* $1/gis;
$lines =~ s/<td[^>]*class="level-3[^"]*"[^>]*>(.*?)<\/td>/* $1/gis;

# Clean up remaining tags
$lines =~ s/<td>(.*?)<\/td>//gis;
$lines =~ s/<tr[^>]*>(.*?)<\/tr>/$1/gis;
$lines =~ s/<head[^>]*>(.*?)<\/head>//gis;
$lines =~ s/<![^>]*>//gis;
$lines =~ s/<html[^>]*>(.*?)<\/html>/$1/gis;
$lines =~ s/<body[^>]*>(.*?)<\/body>/$1/gis;
$lines =~ s/<table[^>]*>(.*?)<\/table>/$1/gis;
$lines =~ s/<p\/>//gis;
$lines =~ s/<p[^>]*>([^<]*?)<\/p>//gis;

# Clean up line breaks
$lines =~ s/\n */\n/gis;
$lines =~ s/\n\t/\n/gis;
$lines =~ s/\n\n\n\n\n/\n/gis;
$lines =~ s/\n\n\n\n/\n/gis;
$lines =~ s/\n\n\n/\n/gis;
$lines =~ s/\n\n/\n/gis;

# Escape remaining angle brackets
$lines =~ s/</&lt;/gis;
$lines =~ s/>/&gt;/gis;

print $lines;