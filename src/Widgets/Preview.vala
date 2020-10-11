/*
* Copyright (c) 2017 Lains
*
* Modified July 7, 2018 for ThiefMD
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 2 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*
*/

using WebKit;
using ThiefMD;
using ThiefMD.Controllers;

namespace ThiefMD.Widgets {
    public class Preview : WebKit.WebView {
        private static Preview? instance = null;
        public string html;
        public bool exporting = false;
        public bool print_only = false;
        public string? override_css = null;

        public Preview () {
            Object(user_content_manager: new UserContentManager());
            visible = true;
            vexpand = true;
            hexpand = true;
            var settingsweb = get_settings();
            settingsweb.enable_plugins = false;
            settingsweb.enable_page_cache = false;
            settingsweb.enable_developer_extras = false;
            settingsweb.javascript_can_open_windows_automatically = false;

            var settings = AppSettings.get_default ();
            settings.changed.connect (() => {
                if (this == instance) {
                    update_html_view (true, SheetManager.get_markdown ());
                }
            });
            connect_signals ();
        }

        public static void update_view () {
            PreviewWindow.update_preview_title ();
            get_instance ().update_html_view (true, SheetManager.get_markdown ());
        }

        public static Preview get_instance () {
            if (instance == null) {
                instance = new Widgets.Preview ();
            }

            return instance;
        }

        protected override bool context_menu (
            ContextMenu context_menu,
            Gdk.Event event,
            HitTestResult hit_test_result
        ) {
            return true;
        }

        private string set_stylesheet () {
            var settings = AppSettings.get_default ();
            return get_style_header (override_css != null ? override_css : settings.preview_css, override_css != null ? override_css : settings.print_css);
        }

        public string get_style_header (string preview_css = "", string print_css = "") {
            var settings = AppSettings.get_default ();
            var style = "";
            if (!exporting) {
                style += """<link rel="stylesheet" type="text/css" href='""";
                style += Build.PKGDATADIR + "/styles/highlight.css";
                style += "' />\n";
                style += """<link rel="stylesheet" type="text/css" href='""";
                style += Build.PKGDATADIR + "/styles/katex.min.css";
                style += "' />\n";
            } else {
                style += """<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/katex@0.12.0/dist/katex.min.css" integrity="sha384-AfEj0r4/OFrOo5t7NnNe46zW/tFgW6x/bCJG8FqQCEo3+Aro6EYUG4+cU+KJWu/X" crossorigin="anonymous">""";
            }

            // If typewriter scrolling is enabled, add padding to match editor

            style += "\n<style>\n";
            if (!print_only) {
                File css_file = null;
                if (preview_css == "modest-splendor") {
                    css_file = File.new_for_path (Path.build_filename(Build.PKGDATADIR, "styles", "preview.css"));
                } else if (preview_css != "") {
                    css_file = File.new_for_path (Path.build_filename(UserData.css_path, preview_css,"preview.css"));
                }
                if (css_file != null && css_file.query_exists ()) {
                    style = style + FileManager.get_file_contents (css_file.get_path ());
                }
            }

            if (exporting) {
                style += FileManager.get_file_contents (Build.PKGDATADIR + "/styles/highlight.css");
            } else {
                if (settings.typewriter_scrolling && override_css == null) {
                    style += ".markdown-body{padding-top:40%;padding-bottom:40%}\n";
                }
            }

            if (print_css == "modest-splendor") {
                style += ThiefProperties.PRINT_CSS.printf ("""content: " (" attr(href) ")";""");
            } else if (print_css != "") {
                File css_file = File.new_for_path (Path.build_filename(UserData.css_path, preview_css,"print.css"));
                if (css_file.query_exists ()) {
                    style += "@media print {\n";
                    style += FileManager.get_file_contents (css_file.get_path ());
                    style += "}";
                    if (print_only) {
                        style += FileManager.get_file_contents (css_file.get_path ());
                    }
                }
            } else {
                style += ThiefProperties.NO_CSS_CSS;
            }
            style += "\n</style>\n";

            return style;
        }

        private void connect_signals () {
            create.connect ((navigation_action) => {
                launch_browser (navigation_action.get_request().get_uri ());
                return (Gtk.Widget) null;
            });

            decide_policy.connect ((decision, type) => {
                switch (type) {
                    case WebKit.PolicyDecisionType.NEW_WINDOW_ACTION:
                        if (decision is WebKit.ResponsePolicyDecision) {
                            WebKit.ResponsePolicyDecision response_decision = (decision as WebKit.ResponsePolicyDecision);
                            if (response_decision != null && 
                                response_decision.request != null)
                            {
                                launch_browser (response_decision.request.get_uri ());
                            }
                        }
                    break;
                    case WebKit.PolicyDecisionType.RESPONSE:
                        if (decision is WebKit.ResponsePolicyDecision) {
                            var policy = (WebKit.ResponsePolicyDecision) decision;
                            launch_browser (policy.request.get_uri ());
                            return false;
                        }
                    break;
                }

                return true;
            });

            load_changed.connect ((event) => {
                if (event == WebKit.LoadEvent.FINISHED) {
                    var rectangle = get_window_properties ().get_geometry ();
                    set_size_request (rectangle.width, rectangle.height);
                }
            });
        }

        private void launch_browser (string url) {
            if (!url.contains ("/embed/")) {
                try {
                    AppInfo.launch_default_for_uri (url, null);
                } catch (Error e) {
                    warning ("No app to handle urls: %s", e.message);
                }
                stop_loading ();
            }
        }

        private bool get_preview_markdown (string raw_mk, out string processed_mk) {
            var settings = AppSettings.get_default ();
            if (!exporting || settings.export_resolve_paths) {
                processed_mk = Pandoc.resolve_paths (raw_mk);
            } else {
                processed_mk = raw_mk;
            }
            processed_mk = FileManager.get_yamlless_markdown(processed_mk, 0, true, true, false);

            var mkd = new Markdown.Document.from_gfm_string (processed_mk.data, 0x00200000 + 0x00004000 + 0x02000000 + 0x01000000 + 0x04000000 + 0x00400000 + 0x10000000 + 0x40000000);
            mkd.compile (0x00200000 + 0x00004000 + 0x02000000 + 0x01000000 + 0x00400000 + 0x04000000 + 0x40000000 + 0x10000000);
            mkd.get_document (out processed_mk);

            return (processed_mk.chomp () != "");
        }

        private string get_javascript (bool use_thief_mark) {
            var settings = AppSettings.get_default ();
            string script = "";

            // If typewriter scrolling is enabled, add padding to match editor
            bool typewriter_active = settings.typewriter_scrolling;

            // Find our ThiefMark and move it to the same position of the cursor
            if (use_thief_mark) {
                script = """<script>
                const element = document.getElementById('thiefmark');
                const textOnTop = element.offsetTop;
                const middle = textOnTop - (window.innerHeight * %f);
                window.scrollTo(0, middle);
                </script>""".printf((typewriter_active) ? Constants.TYPEWRITER_POSITION : SheetManager.get_cursor_position ());
            }

            // Default preview javascript
            script += """<script>
            renderMathInElement(document.body,
                {
                    delimeters: [
                        {left: "$$", right: "$$", display: true},
                        {left: "$", right: "$", display: false},
                        {left: "\\(", right: "\\)", display: false},
                        {left: "\\[", right: "\\]", display: true}
                    ]
                });
            </script>
            <script>hljs.initHighlightingOnLoad();</script>""";

            return script;
        }

        private string get_javascript_header () {
            string script;

            if (!exporting) {
                script = "<script src='";
                script += Build.PKGDATADIR + "/scripts/highlight.js";
                script += "'></script>\n";
                script += """<script src='""";
                script += Build.PKGDATADIR + "/scripts/katex.min.js";
                script += "'></script>";
                script += "<script src='";
                script += Build.PKGDATADIR + "/scripts/auto-render.min.js";
                script += "'></script>";
            } else {
                script = """
                <script defer src="https://cdn.jsdelivr.net/npm/katex@0.12.0/dist/katex.min.js" integrity="sha384-g7c+Jr9ZivxKLnZTDUhnkOnsh30B4H0rpLUpJ4jAIKs4fnJI+sEnkvrMWph2EDg4" crossorigin="anonymous"></script>
                <script defer src="https://cdn.jsdelivr.net/npm/katex@0.12.0/dist/contrib/auto-render.min.js" integrity="sha384-mll67QQFJfxn0IYznZYonOWZ644AWYC+Pt2cHqMaRhXVrursRwvLnLaebdGIlYNa" crossorigin="anonymous" onload="renderMathInElement(document.body);"></script>
                <script src="https://cdn.jsdelivr.net/gh/highlightjs/cdn-release@10.2.1/build/highlight.min.js"></script>
                """;
            }

            return script;
        }

        public void update_html_view (bool use_thief_mark = true, string markdown = "") {
            string stylesheet = set_stylesheet ();
            string markdown_res = "";
            get_preview_markdown (markdown, out markdown_res);
            string script = get_javascript (use_thief_mark);
            string headerscript = get_javascript_header ();
            html = """
            <!doctype html>
            <html>
                <head>
                    <meta charset=utf-8>
                    %s
                    %s
                </head>
                <body>
                    <div class=markdown-body>
                        %s
                    </div>
                    %s
                </body>
            </html>""".printf(stylesheet, headerscript, markdown_res, script);
            adjust_thief_mark (use_thief_mark);
            this.load_html (html, "file:///");
        }

        private void adjust_thief_mark (bool use_thief_mark) {
            if (use_thief_mark) {
                html = html.replace (ThiefProperties.THIEF_MARK_CONST, ThiefProperties.THIEF_MARK);
            } else {
                html = html.replace (ThiefProperties.THIEF_MARK_CONST, "");
            }
        }
    }
}
