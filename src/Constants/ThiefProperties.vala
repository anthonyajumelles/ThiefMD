/*
 * Copyright (C) 2020 kmwallio
 * 
 * Modified September 6, 2020
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

namespace ThiefMD {
    public class ThiefProperties {
        public const string NAME = "ThiefMD";
        public const string URL = "https://thiefmd.com";
        public const string COPYRIGHT = "Copyright © 2020 kmwallio";
        public const string TAGLINE = "The Markdown editor worth stealing";
        public const string THIEF_MARK = "<span id='thiefmark'></span>";
        public const string VERSION = Build.VERSION;
        public const Gtk.License LICENSE_TYPE = Gtk.License.GPL_3_0;
        public const string[] GIANTS = {
            "Original Code:\nBased on <a href='https://github.com/lainsce/quilter'>Quilter</a>\nCopyright © 2017 Lains.\n<a href='https://github.com/lainsce/quilter/blob/master/LICENSE'>GNU General Public License v3.0</a>\n",
            "Font:\n<a href='https://github.com/iaolo/iA-Fonts'>iA Writer Duospace</a>\nCopyright © 2018 Information Architects Inc.\nwith Reserved Font Name \"iA Writer\"\n<a href='https://github.com/iaolo/iA-Fonts/blob/master/iA%20Writer%20Duospace/LICENSE.md'>SIL OPEN FONT LICENSE Version 1.1</a>\n",
            "Preview CSS:\n<a href='https://github.com/markdowncss'>Mash up of Splendor and Modest</a>\nCopyright © 2014-2015 John Otander.\n<a href='https://github.com/markdowncss/splendor/blob/master/LICENSE'>The MIT License (MIT)</a>\n",
            "Markdown Parsing:\n<a href='http://www.pell.portland.or.us/~orc/Code/discount/'>libmarkdown2</a>\nCopyright © 2007 David Loren Parsons.\n<a href='http://www.pell.portland.or.us/~orc/Code/discount/COPYRIGHT.html'>BSD-style License</a>\n",
            "Syntax Highlighting:\n<a href='https://highlightjs.org/'>highlight.js</a>\nCopyright © 2006 Ivan Sagalaev.\n<a href='https://github.com/highlightjs/highlight.js/blob/master/LICENSE'>BSD-3-Clause License</a>\n",
            "Math Rendering:\n<a href='https://katex.org/'>KaTeX</a>\nCopyright © 2013-2020 Khan Academy and other contributors.\n<a href='https://github.com/KaTeX/KaTeX/blob/master/LICENSE'>MIT License</a>\n",
            "XML Parsing:\n<a href='https://gitlab.gnome.org/GNOME/gxml/'>GXml</a>\n<a href='https://gitlab.gnome.org/GNOME/gxml/-/blob/master/COPYING'>GNU Lesser General Public License v2.1</a>\n",
        };
        public const string PREVIEW_TEXT = """# %s
The `markdown` editor worth stealing. *Focus* more on **writing**.
> It's the best thing since sliced bread
[ThiefMD](https://thiefmd.com)
""";
    }
}
