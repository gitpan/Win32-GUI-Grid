use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.

WriteMakefile(
    'NAME'         => 'Win32::GUI::Grid',
    'VERSION_FROM' => 'Grid.pm',
    'XS'           => { 'Grid.xs' => 'Grid.cpp' },
    'LIBS'         => ['Comctl32.lib Mfc42.lib Eafxis.lib'],   # e.g., '-lm'
    'DEFINE'       => '',     # e.g., '-DHAVE_SOMETHING'
    'INC'          => '',     # e.g., '-I/usr/include/other'
    'MYEXTLIB'     => './MFCGrid/Lib/MFCGrid.lib',
     ($] ge '5.005')
     ? (
      'AUTHOR'   => 'ROCHER Laurent (rocherl@club-internet.fr)',
      'ABSTRACT' => 'Add a Grid control to Win32::GUI (MFC Grid from CodeProject.com)',
     )
     : (),
);


sub MY::xs_c {
'

.xs.c:
    $(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) $(XSUBPP) $(XSPROTOARG) $(XSUBPPARGS) $*.xs > $*.c

.xs.cpp:
    $(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) $(XSUBPP) $(XSPROTOARG) $(XSUBPPARGS) $*.xs > $*.cpp

./MFCGrid/Lib/MFCGrid.lib: MFCGrid/makefile
    cd MFCGrid
    nmake
    cd ..

';
}

