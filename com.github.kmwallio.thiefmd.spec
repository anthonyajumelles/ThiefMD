Name: com.github.kmwallio.thiefmd
Version: 0.1.0
Release: 1%{?dist}
Summary: The markdown editor worth stealing.
License: GPL-3.0+
URL: https://thiefmd.com

Source0: %{name}-%{version}.tar.xz
Source1: data/%{name}.appdata.xml

Requires: pandoc
BuildRequires: meson
BuildRequires: vala
BuildRequires: gcc
BuildRequires: pkgconfig(libmarkdown)
BuildRequires: pkgconfig(libxml-2.0)
BuildRequires: pkgconfig(gio-2.0)
BuildRequires: pkgconfig(gee-0.8)
BuildRequires: pkgconfig(glib-2.0)
BuildRequires: pkgconfig(gobject-2.0)
BuildRequires: pkgconfig(libarchive)
BuildRequires: pkgconfig(clutter-1.0)
BuildRequires: pkgconfig(gtksourceview-3.0)
BuildRequires: pkgconfig(gtk+-3.0)
BuildRequires: pkgconfig(gtkspell3-3.0)
BuildRequires: pkgconfig(webkit2gtk-4.0)

%description
Keep your Markdown managed. Write epic tales, keep a journal, or finally write that book report.
ThiefMD is a Markdown Editor providing an easy way to organize your markdown documents.

%package devel
Summary: Development files for %{name}
Requires: %{name}%{?_isa} = %{?epoch:%{epoch}:}{version}-%{release}

%description devel
Development files for %{name}.

%prep
%autosetup

%build
%meson
%meson_build

%install
%meson_install
rm -vf %{buildroot}%{_libdir}/libultheme.a

%check
%meson_test

%files
%{_bindir}/com.github.kmwallio.thiefmd
/usr/share/applications/com.github.kmwallio.thiefmd.desktop
/usr/share/com.github.kmwallio.thiefmd/scripts/auto-render.min.js
/usr/share/com.github.kmwallio.thiefmd/scripts/highlight.js
/usr/share/com.github.kmwallio.thiefmd/scripts/katex.min.js
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_AMS-Regular.ttf
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_AMS-Regular.woff
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_AMS-Regular.woff2
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_Caligraphic-Bold.ttf
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_Caligraphic-Bold.woff
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_Caligraphic-Bold.woff2
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_Caligraphic-Regular.ttf
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_Caligraphic-Regular.woff
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_Caligraphic-Regular.woff2
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_Fraktur-Bold.ttf
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_Fraktur-Bold.woff
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_Fraktur-Bold.woff2
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_Fraktur-Regular.ttf
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_Fraktur-Regular.woff
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_Fraktur-Regular.woff2
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_Main-Bold.ttf
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_Main-Bold.woff
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_Main-Bold.woff2
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_Main-BoldItalic.ttf
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_Main-BoldItalic.woff
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_Main-BoldItalic.woff2
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_Main-Italic.ttf
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_Main-Italic.woff
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_Main-Italic.woff2
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_Main-Regular.ttf
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_Main-Regular.woff
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_Main-Regular.woff2
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_Math-BoldItalic.ttf
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_Math-BoldItalic.woff
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_Math-BoldItalic.woff2
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_Math-Italic.ttf
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_Math-Italic.woff
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_Math-Italic.woff2
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_SansSerif-Bold.ttf
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_SansSerif-Bold.woff
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_SansSerif-Bold.woff2
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_SansSerif-Italic.ttf
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_SansSerif-Italic.woff
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_SansSerif-Italic.woff2
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_SansSerif-Regular.ttf
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_SansSerif-Regular.woff
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_SansSerif-Regular.woff2
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_Script-Regular.ttf
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_Script-Regular.woff
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_Script-Regular.woff2
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_Size1-Regular.ttf
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_Size1-Regular.woff
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_Size1-Regular.woff2
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_Size2-Regular.ttf
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_Size2-Regular.woff
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_Size2-Regular.woff2
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_Size3-Regular.ttf
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_Size3-Regular.woff
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_Size3-Regular.woff2
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_Size4-Regular.ttf
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_Size4-Regular.woff
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_Size4-Regular.woff2
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_Typewriter-Regular.ttf
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_Typewriter-Regular.woff
/usr/share/com.github.kmwallio.thiefmd/styles/fonts/KaTeX_Typewriter-Regular.woff2
/usr/share/com.github.kmwallio.thiefmd/styles/highlight.css
/usr/share/com.github.kmwallio.thiefmd/styles/katex.min.css
/usr/share/com.github.kmwallio.thiefmd/styles/preview.css
/usr/share/fonts/truetype/thiefmd/iAWriterDuospace-Regular.ttf
/usr/share/glib-2.0/schemas/com.github.kmwallio.thiefmd.gschema.xml
/usr/share/gtksourceview-4/styles/thiefmd.xml
/usr/share/icons/hicolor/128x128/apps/com.github.kmwallio.thiefmd.svg
/usr/share/icons/hicolor/48x48/apps/com.github.kmwallio.thiefmd.svg
/usr/share/icons/hicolor/64x64/apps/com.github.kmwallio.thiefmd.svg
/usr/share/icons/hicolor/symbolicxsymbolic/apps/com.github.kmwallio.thiefmd.svg
/usr/share/metainfo/com.github.kmwallio.thiefmd.appdata.xml
/usr/share/com.github.kmwallio.thiefmd/gtksourceview-4/language-specs/css.lang
/usr/share/com.github.kmwallio.thiefmd/gtksourceview-4/language-specs/def.lang
/usr/share/com.github.kmwallio.thiefmd/gtksourceview-4/language-specs/dtd.lang
/usr/share/com.github.kmwallio.thiefmd/gtksourceview-4/language-specs/dtl.lang
/usr/share/com.github.kmwallio.thiefmd/gtksourceview-4/language-specs/html.lang
/usr/share/com.github.kmwallio.thiefmd/gtksourceview-4/language-specs/javascript-expressions.lang
/usr/share/com.github.kmwallio.thiefmd/gtksourceview-4/language-specs/javascript-functions-classes.lang
/usr/share/com.github.kmwallio.thiefmd/gtksourceview-4/language-specs/javascript-literals.lang
/usr/share/com.github.kmwallio.thiefmd/gtksourceview-4/language-specs/javascript-modules.lang
/usr/share/com.github.kmwallio.thiefmd/gtksourceview-4/language-specs/javascript-statements.lang
/usr/share/com.github.kmwallio.thiefmd/gtksourceview-4/language-specs/javascript-values.lang
/usr/share/com.github.kmwallio.thiefmd/gtksourceview-4/language-specs/javascript.lang
/usr/share/com.github.kmwallio.thiefmd/gtksourceview-4/language-specs/jsdoc.lang
/usr/share/com.github.kmwallio.thiefmd/gtksourceview-4/language-specs/json.lang
/usr/share/com.github.kmwallio.thiefmd/gtksourceview-4/language-specs/language-specs.its
/usr/share/com.github.kmwallio.thiefmd/gtksourceview-4/language-specs/language-specs.pot
/usr/share/com.github.kmwallio.thiefmd/gtksourceview-4/language-specs/language.dtd
/usr/share/com.github.kmwallio.thiefmd/gtksourceview-4/language-specs/language.rng
/usr/share/com.github.kmwallio.thiefmd/gtksourceview-4/language-specs/language2.rng
/usr/share/com.github.kmwallio.thiefmd/gtksourceview-4/language-specs/latex.lang
/usr/share/com.github.kmwallio.thiefmd/gtksourceview-4/language-specs/markdown.lang
/usr/share/com.github.kmwallio.thiefmd/gtksourceview-4/language-specs/rst.lang
/usr/share/com.github.kmwallio.thiefmd/gtksourceview-4/language-specs/xml.lang
/usr/share/com.github.kmwallio.thiefmd/gtksourceview-4/language-specs/xslt.lang
/usr/share/com.github.kmwallio.thiefmd/gtksourceview-4/language-specs/yaml.lang
/usr/share/icons/hicolor/32x32/apps/com.github.kmwallio.thiefmd.svg

%post -p /sbin/ldconfig
%postun -p /sbin/ldconfig

%changelog
* Sat Oct 10 2020 kmwallio <mwallio@gmail.com> - 0.1.0
- Import DocX, ePUB, HTML, and more, just drag the file onto a library folder
- New Export Tool, change CSS, Page Size, and more
- Library Search and Editor Search
- Writing Statistics
* Mon Oct 05 2020 kmwallio <mwallio@gmail.com> - 0.0.12
- Update Dynamic CSS to include buttons and button hover
- Determine light/dark based on luminance of editor theme
- Add option to hide titles/go brandless
- Add link to new themes site with original ThiefMD themes
- Fix typos
* Thu Oct 01 2020 kmwallio <mwallio@gmail.com> - 0.0.11
- Write-Good support for writing suggestions
* Tue Sep 29 2020 kmwallio <mwallio@gmail.com> - 0.0.10
- Default to User's GTK Theme
- Certain well-known hidden folders persist between restarts
- Image path resolution for cover-image in ePub YAML front-matter
* Fri Sep 18 2020 kmwallio <mwallio@gmail.com> - 0.0.9
- This release is a bug fix release
- Fix bug when trying to export with no file selected
- Select first folder added to Library
- Show error when unable to export file
* Thu Sep 17 2020 kmwallio <mwallio@gmail.com> - 0.0.8
- Pandoc Export
- More PDF Export options
- Shortcut keys
- Better undo management
* Sun Sep 13 2020 kmwallio <mwallio@gmail.com> - 0.0.7
- Library Reordering
- Sheets Reordering
- Library Export
* Wed Sep 09 2020 kmwallio <mwallio@gmail.com> - 0.0.6
- Adding theme support
- Improve UI for About and Preferences
- Fix a bug in Editor only view
* Thu Sep 03 2020 kmwallio <mwallio@gmail.com> - 0.0.5
- Fix bug with () rendering
- Add Syntax Highlighting and KaTeX
* Wed Sep 02 2020 kmwallio <mwallio@gmail.com> - 0.0.4
- Drag and Drop Support for moving sheets in library
- Blogging centric features