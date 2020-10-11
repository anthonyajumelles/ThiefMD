/*
* Copyright (c) 2017 Lains
*
* Modified July 6, 2018 for use in ThiefMD
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
*/

using ThiefMD;
using ThiefMD.Controllers;

namespace ThiefMD.Widgets {
    public class KeyBindings { 
        public KeyBindings (Gtk.Window window) {
            window.key_press_event.connect ((e) => {
                uint keycode = e.hardware_keycode;
                var settings = AppSettings.get_default ();

                // Quit
                if ((e.state & Gdk.ModifierType.CONTROL_MASK) != 0 && (e.state & Gdk.ModifierType.SHIFT_MASK) == 0) {
                    if (match_keycode (Gdk.Key.q, keycode)) {
                        window.destroy ();
                    }
                }

                // Search
                if ((e.state & Gdk.ModifierType.CONTROL_MASK) != 0 && (e.state & Gdk.ModifierType.SHIFT_MASK) == 0) {
                    if (match_keycode (Gdk.Key.f, keycode)) {
                        ThiefApp.get_instance ().search_bar.toggle_search ();
                    }
                }

                // Global search
                if ((e.state & Gdk.ModifierType.CONTROL_MASK) != 0 && (e.state & Gdk.ModifierType.SHIFT_MASK) != 0) {
                    if (match_keycode (Gdk.Key.f, keycode)) {
                        SearchWindow search = new SearchWindow ();
                        search.show_all ();
                    }
                }

                // Preview
                if ((e.state & Gdk.ModifierType.CONTROL_MASK) != 0 && (e.state & Gdk.ModifierType.SHIFT_MASK) != 0) {
                    if (match_keycode (Gdk.Key.p, keycode)) {
                        PreviewWindow pvw = PreviewWindow.get_instance ();
                        pvw.show_all ();
                    }
                }

                // New Sheet
                if ((e.state & Gdk.ModifierType.CONTROL_MASK) != 0 && (e.state & Gdk.ModifierType.SHIFT_MASK) == 0) {
                    if (match_keycode (Gdk.Key.n, keycode)) {
                        Widgets.Headerbar.get_instance ().make_new_sheet ();
                    }
                }

                // Bold
                if ((e.state & Gdk.ModifierType.CONTROL_MASK) != 0 && (e.state & Gdk.ModifierType.SHIFT_MASK) == 0) {
                    if (match_keycode (Gdk.Key.b, keycode)) {
                        SheetManager.bold ();
                    }
                }

                // Italic
                if ((e.state & Gdk.ModifierType.CONTROL_MASK) != 0 && (e.state & Gdk.ModifierType.SHIFT_MASK) == 0) {
                    if (match_keycode (Gdk.Key.i, keycode)) {
                        SheetManager.italic ();
                    }
                }

                // Strikethrough
                if ((e.state & Gdk.ModifierType.CONTROL_MASK) != 0 && (e.state & Gdk.ModifierType.SHIFT_MASK) == 0) {
                    if (match_keycode (Gdk.Key.d, keycode)) {
                        SheetManager.strikethrough ();
                    }
                }

                // Save
                if ((e.state & Gdk.ModifierType.CONTROL_MASK) != 0 && (e.state & Gdk.ModifierType.SHIFT_MASK) == 0) {
                    if (match_keycode (Gdk.Key.s, keycode)) {
                        SheetManager.save_active ();
                    }
                }

                // Toggle statistics bar
                if ((e.state & Gdk.ModifierType.CONTROL_MASK) != 0 && (e.state & Gdk.ModifierType.SHIFT_MASK) != 0) {
                    if (match_keycode (Gdk.Key.s, keycode)) {
                        ThiefApp.get_instance ().stats_bar.toggle_statistics ();
                    }
                }

                // Preferences
                if ((e.state & Gdk.ModifierType.CONTROL_MASK) != 0 && (e.state & Gdk.ModifierType.SHIFT_MASK) == 0) {
                    if (match_keycode (Gdk.Key.comma, keycode)) {
                        Preferences prf = new Preferences();
                        prf.run();
                    }
                }

                // Undo
                if ((e.state & Gdk.ModifierType.CONTROL_MASK) != 0 && (e.state & Gdk.ModifierType.SHIFT_MASK) == 0) {
                    if (match_keycode (Gdk.Key.z, keycode)) {
                        SheetManager.undo ();
                    }
                }

                // Redo
                if ((e.state & Gdk.ModifierType.CONTROL_MASK & Gdk.ModifierType.SHIFT_MASK) != 0) {
                    if (match_keycode (Gdk.Key.z, keycode)) {
                        SheetManager.redo ();
                    }
                }

                // Editor Mode
                if ((e.state & Gdk.ModifierType.CONTROL_MASK) != 0 && (e.state & Gdk.ModifierType.SHIFT_MASK) == 0) {
                    if (match_keycode (Gdk.Key.@1, keycode)) {
                        settings.view_state = 2;
                        UI.show_view ();
                    }
                }

                // Sheets + Editor Mode
                if ((e.state & Gdk.ModifierType.CONTROL_MASK) != 0 && (e.state & Gdk.ModifierType.SHIFT_MASK) == 0) {
                    if (match_keycode (Gdk.Key.@2, keycode)) {
                        settings.view_state = 1;
                        UI.show_view ();
                    }
                }

                // Library + Sheets + Editor Mode
                if ((e.state & Gdk.ModifierType.CONTROL_MASK) != 0 && (e.state & Gdk.ModifierType.SHIFT_MASK) == 0) {
                    if (match_keycode (Gdk.Key.@3, keycode)) {
                        settings.view_state = 0;
                        UI.show_view ();
                    }
                }

                // Fullscreen
                if (match_keycode (Gdk.Key.F11, keycode)) {
                    settings.fullscreen = !settings.fullscreen;
                }

                if (match_keycode (Gdk.Key.Escape, keycode)) {
                    if (ThiefApp.get_instance ().search_bar.should_escape_search ()) {
                        ThiefApp.get_instance ().search_bar.deactivate_search ();
                    } else if (settings.fullscreen) {
                        settings.fullscreen = false;
                    }
                }

                return false;
            });
        }

        protected bool match_keycode (uint keyval, uint code) {
            Gdk.KeymapKey [] keys;
            Gdk.Keymap keymap = Gdk.Keymap.get_for_display (Gdk.Display.get_default ());
            if (keymap.get_entries_for_keyval (keyval, out keys)) {
                foreach (var key in keys) {
                    if (code == key.keycode) {
                        return true;
                    }
                }
            }

            return false;
        }
    }
}