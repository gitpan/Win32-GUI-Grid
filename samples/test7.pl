#! perl -w
#
# Test Basic Grid method
#
use strict;
use Win32::GUI;
use Win32::GUI::Grid;

# main Window
my $Window = new Win32::GUI::Window (
    -title    => "Win32::GUI::Grid test 5",
    -pos     => [100, 100],
    -size    => [400, 400],
    -name     => "Window",
) or die "new Window";

# Grid Window
my $Grid = new Win32::GUI::Grid (
    -parent  => $Window,
    -name    => "Grid",
    -pos     => [0, 0],
) or die "new Grid";

# Init Grid
$Grid->SetDefCellType(GVIT_NUMERIC);  # Preset Cell type before cell creation
$Grid->SetEditable(1);
$Grid->SetRows(10);
$Grid->SetColumns(10);
$Grid->SetFixedRows(1);
$Grid->SetFixedColumns(1);
$Grid->SetHeaderSort(1);

# Fill Grid
for my $row (0..$Grid->GetRows()) {
  for my $col (0..$Grid->GetColumns()) {
    if ($row == 0) {
      $Grid->SetCellText($row, $col,"Column : $col");
      if ($col != 0) {
        $Grid->SetSortFunction (sub { my ($e1, $e2) = @_; return (int($e1) - int ($e2)); }, $col);
      }
    }
    elsif ($col == 0) {
      $Grid->SetCellText($row, $col, "Row : $row");
    }
    else {
      $Grid->SetCellText($row, $col, $row*$col);
    }
  }
}

# Resize Grid Cell
$Grid->AutoSize();

# Event loop
$Window->Show();
Win32::GUI::Dialog();

# Main window event handler
sub Window_Terminate {

  return -1;
}

sub Window_Resize {

  my ($width, $height) = ($Window->GetClientRect)[2..3];
  $Grid->Resize ($width, $height);
}
