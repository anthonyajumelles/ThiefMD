/*
 * Copyright (C) 2020 kmwallio
 * 
 * Modified September 8, 2020
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

using ThiefMD;
using ThiefMD.Controllers;
using Gtk;
using Gdk;

namespace ThiefMD.Widgets {
    public class CssSelector : Gtk.Box {
        private string css_type;
        private Gtk.FlowBox app_box;
        private Gee.LinkedList<Gtk.Widget> wids;
        public CssSelector (string what) {
            css_type = what;
            wids = new Gee.LinkedList<Gtk.Widget> ();
            build_ui ();
        }

        public void build_ui () {
            app_box = new Gtk.FlowBox ();
            app_box.margin = 6;
            app_box.max_children_per_line = 3;
            app_box.homogeneous = true;
            app_box.expand = false;

            var preview_box = new Gtk.ScrolledWindow (null, null);
            preview_box.add (app_box);
            preview_box.hexpand = true;
            preview_box.vexpand = true;

            var none = new CssPreview ("", css_type == "print");
            var modest_splendor = new CssPreview ("modest-splendor", css_type == "print");
            app_box.add (none);
            app_box.add (modest_splendor);

            load_css ();

            add (preview_box);
        }

        public void refresh () {
            while (!wids.is_empty) {
                app_box.remove (wids.poll ());
            }

            load_css ();
            show_all ();
        }

        public static Gee.LinkedList<string> list_css (string css_type = "print") {
            Gee.LinkedList<string> styles = new Gee.LinkedList<string> ();
            styles.add ("None");
            styles.add ("modest-splendor");
            try {
                Dir css_dir = Dir.open (UserData.css_path, 0);

                string? theme_pkg = "";
                while ((theme_pkg = css_dir.read_name ()) != null) {
                    string path = Path.build_filename (UserData.css_path, theme_pkg);
                    if (!theme_pkg.has_prefix (".") && FileUtils.test(path, FileTest.IS_DIR)) {
                        File print_css = File.new_for_path (Path.build_filename (UserData.css_path, theme_pkg, "print.css"));
                        File preview_css = File.new_for_path (Path.build_filename (UserData.css_path, theme_pkg, "preview.css"));
                        if (css_type == "print" && print_css.query_exists ()) {
                            styles.add (theme_pkg);
                        } else if (css_type == "preview" && preview_css.query_exists ()) {
                            styles.add (theme_pkg);
                        }
                    }
                }
            } catch (Error e) {
                warning ("Error loading css export packages: %s", e.message);
            }

            return styles;
        }

        public bool load_css () {
            try {
                Dir css_dir = Dir.open (UserData.css_path, 0);

                string? theme_pkg = "";
                while ((theme_pkg = css_dir.read_name ()) != null) {
                    string path = Path.build_filename (UserData.css_path, theme_pkg);
                    if (!theme_pkg.has_prefix (".") && FileUtils.test(path, FileTest.IS_DIR)) {
                        File print_css = File.new_for_path (Path.build_filename (UserData.css_path, theme_pkg, "print.css"));
                        File preview_css = File.new_for_path (Path.build_filename (UserData.css_path, theme_pkg, "preview.css"));
                        if (css_type == "print" && print_css.query_exists ()) {
                            var new_opt = new CssPreview (theme_pkg, true);
                            new_opt.set_size_request (Constants.CSS_PREVIEW_WIDTH, Constants.CSS_PREVIEW_HEIGHT);
                            app_box.add (new_opt);
                            wids.add (new_opt);
                        } else if (css_type == "preview" && preview_css.query_exists ()) {
                            var new_opt = new CssPreview (theme_pkg, false);
                            new_opt.set_size_request (Constants.CSS_PREVIEW_WIDTH, Constants.CSS_PREVIEW_HEIGHT);
                            app_box.add (new_opt);
                            wids.add (new_opt);
                        }
                    }
                }
            } catch (Error e) {
                warning ("Error loading css export packages: %s", e.message);
            }

            return false;
        }
    }

    public class ThemeSelector : Gtk.Box {
        public Gtk.FlowBox preview_items;
        private Gtk.Grid app_box;
        private PreviewDrop drop_box;
        public static ThemeSelector instance;

        public ThemeSelector () {
            instance = this;
            build_ui ();
        }

        public void build_ui () {
            var settings = AppSettings.get_default ();
            app_box = new Gtk.Grid ();
            app_box.margin = 12;
            app_box.row_spacing = 12;
            app_box.column_spacing = 12;
            app_box.orientation = Orientation.VERTICAL;
            app_box.hexpand = true;

            var preview_box = new Gtk.ScrolledWindow (null, null);
            preview_box.min_content_height = settings.window_height / 2;
            preview_items = new Gtk.FlowBox ();
            preview_items.margin = 6;
            preview_box.add (preview_items);
            preview_box.hexpand = true;

            drop_box = new PreviewDrop ();
            drop_box.xalign = 0;
            drop_box.hexpand = true;

            var border = new Gtk.Frame(_("Drop Style.ultheme:"));
            border.add (drop_box);

            app_box.attach (border, 0, 0, 1, 1);
            app_box.attach (preview_box, 0, 1, 1, 3);
            app_box.hexpand = true;

            var get_themes = new Gtk.Label (_("Download <a href='https://themes.thiefmd.com/themes/'>more themes</a>."));
            get_themes.use_markup = true;
            get_themes.xalign = 0;

            // preview_items.add (new UserTheme ());
            preview_items.add (new DefaultTheme ());
            app_box.attach (get_themes, 0, 5, 1, 1);
            add (app_box);

            load_themes ();

            show_all ();
        }

        public bool load_themes () {
            // Load previous added themes
            if (UI.user_themes == null) {
                return false;
            }

            foreach (var new_styles in UI.user_themes) {
                ThemePreview dark_preview = new ThemePreview (new_styles, true);
                ThemePreview light_preview = new ThemePreview (new_styles, false);

                ThemeSelector.instance.preview_items.add (dark_preview);
                ThemeSelector.instance.preview_items.add (light_preview);
                ThemeSelector.instance.preview_items.show_all ();
            }

            return false;
        }

        private class PreviewDrop : Gtk.Label {
            public PreviewDrop () {
                build_ui ();
            }

            public void build_ui () {
                label = "\n\n\n\n<small>Stored in <a href='file://" + UserData.style_path + "'>" + UserData.style_path + "</a>.</small>";
                use_markup = true;
                set_justify (Justification.LEFT);
                xalign = 0;

                // Drag and Drop Support
                Gtk.drag_dest_set (
                    this,                        // widget will be drag-able
                    DestDefaults.ALL,              // modifier that will start a drag
                    target_list,                   // lists of target to support
                    Gdk.DragAction.COPY            // what to do with data after dropped
                );
                this.drag_motion.connect(this.on_drag_motion);
                this.drag_leave.connect(this.on_drag_leave);
                this.drag_drop.connect(this.on_drag_drop);
                this.drag_data_received.connect(this.on_drag_data_received);
                show_all ();
            }

            private bool on_drag_motion (
                Widget widget,
                DragContext context,
                int x,
                int y,
                uint time)
            {
                return false;
            }

            private void on_drag_leave (Widget widget, DragContext context, uint time) {
            }

            private bool on_drag_drop (
                Widget widget,
                DragContext context,
                int x,
                int y,
                uint time)
            {
                var target_type = (Atom) context.list_targets().nth_data (Target.STRING);

                if (!target_type.name ().ascii_up ().contains ("STRING"))
                {
                    target_type = (Atom) context.list_targets().nth_data (Target.URI);
                }

                // Request the data from the source.
                Gtk.drag_get_data (
                    widget,         // will receive 'drag_data_received' signal
                    context,        // represents the current state of the DnD
                    target_type,    // the target type we want
                    time            // time stamp
                    );
    
                bool is_valid_drop_site = target_type.name ().ascii_up ().contains ("STRING") || target_type.name ().ascii_up ().contains ("URI");
    
                return is_valid_drop_site;
            }
    
            private void on_drag_data_received (
                Widget widget,
                DragContext context,
                int x,
                int y,
                SelectionData selection_data,
                uint target_type,
                uint time)
            {
                File file = dnd_get_file (selection_data, target_type);
                if (!file.query_exists ()) {
                    Gtk.drag_finish (context, false, false, time);
                    return;
                }

                if (!file.get_basename ().down ().has_suffix (".ultheme")) {
                    Gtk.drag_finish (context, false, false, time);
                    return;
                }

                try {
                    File destination = File.new_for_path (Path.build_filename (UserData.style_path, file.get_basename ()));

                    if (destination.query_exists ()) {
                        // Possibly overwrite theme, but don't double draw widget
                        file.copy (destination, FileCopyFlags.OVERWRITE);
                        Gtk.drag_finish (context, true, false, time);
                        return;
                    }

                    file.copy (destination, FileCopyFlags.OVERWRITE);
                    var new_styles = new Ultheme.Parser (destination);
                    UI.add_user_theme (new_styles);

                    ThemePreview dark_preview = new ThemePreview (new_styles, true);
                    ThemePreview light_preview = new ThemePreview (new_styles, false);

                    instance.preview_items.add (dark_preview);
                    instance.preview_items.add (light_preview);
                    instance.show_all ();
                } catch (Error e) {
                    warning ("Failing generating preview: %s\n", e.message);
                }
                Gtk.drag_finish (context, true, false, time);
            }
        }
    }
}