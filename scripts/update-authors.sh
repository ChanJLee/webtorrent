#!/bin/sh
# Update AUTHORS.md based on git history.

git log --reverse --format='%aN (%aE)' | perl -we '
BEGIN {
  %seen = (), @authors = ();
}
while (<>) {
  next if $seen{$_};
  next if /(support\@greenkeeper.io)/;
  next if /(badger\@gitter.im)/;
  next if /(y.ciabaud\@free.fr)/;
  next if /(DiegoRBaquero\@users.noreply.github.com)/;
  next if /(grunjol\@users.noreply.github.com)/;
  $seen{$_} = push @authors, "- ", $_;
}
END {
  print "# Authors\n\n";
  print "#### Ordered by first contribution.\n\n";
  print @authors, "\n";
  print "#### Generated by scripts/update-authors.sh.\n";
}
' > AUTHORS.md
