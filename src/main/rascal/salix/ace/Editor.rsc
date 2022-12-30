module salix::ace::Editor

import salix::HTML;
import salix::Node;
import salix::Core;


private str ACE_SRC = "https://cdnjs.cloudflare.com/ajax/libs/ace/1.14.0/ace.js";
private str ACE_INTEGRITY = "sha512-WYlXqL7GPpZL2ImDErTX0RMKy5hR17vGW5yY04p9Z+YhYFJcUUFRT31N29euNB4sLNNf/s0XQXZfzg3uKSoOdA==";


alias AceAddons = map[str, tuple[str src, str integrity]];

public AceAddons ACE_THEMES = (
    "ace/theme/monokai": <"https://cdnjs.cloudflare.com/ajax/libs/ace/1.14.0/theme-monokai.min.js", 
        "sha512-vH1p51CJtqdqWMpL32h5B9600achcN1XeTfd31hEcrCcCb5PCljIu7NQppgdNtdsayRQTnKmyf94s6HYiGQ9BA==">
);

public AceAddons ACE_MODES = (
    "ace/mode/javascript": <"https://cdnjs.cloudflare.com/ajax/libs/ace/1.14.0/mode-javascript.min.js", 
        "sha512-N2S1El10H86udVD5C2GpUwuXhEkdb3HrqQFYs+PG9G1zBwhd1cwROCG3XYtCr6KL3/XTku53GbWNXFoP0Ur7Gw==">
);


str initCode(str name, str theme, str mode) 
  = "var <name>$editor = ace.edit(\'<name>_editor\');
    '<name>$editor.setTheme(\'<theme>\');
    '<name>$editor.session.setMode(\'<mode>\');
    '$salix.registerAlien(\'<name>\', p =\> <name>$acepatch(<name>$editor, p)); ";


void ace(str name, str code="", str theme="ace/theme/monokai", str mode="ace/mode/javascript",
  AceAddons modes=ACE_MODES,
  AceAddons themes=ACE_THEMES
  ) {
    
    div(class("salix-alien"), id(name), attr("onClick", initCode(name, theme, mode)), () {
        script(src(ACE_SRC), \type("text/javascript"), integrity(ACE_INTEGRITY), crossorigin("anonymous"), referrerpolicy("no-referrer"));
        script(src(modes[mode].src), integrity(modes[mode].integrity), crossorigin("anonymous"), referrerpolicy("no-referrer"));
        script(src(themes[theme].src), integrity(themes[theme].integrity), crossorigin("anonymous"), referrerpolicy("no-referrer"));
        script("function <name>$acepatch(editor, patch) {
               '  // todo
               '}
               '");
        div(style(("position": "absolute", "top": "0", "right": "0", "bottom": "0", "left": "0")),
          id("<name>_editor"), code);
    });

}

