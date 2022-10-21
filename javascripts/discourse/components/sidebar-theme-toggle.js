import Component from "@glimmer/component";
import { action } from "@ember/object";
import { inject as service } from "@ember/service";
import { tracked } from "@glimmer/tracking";
import {
  currentThemeId,
  listThemes,
  setLocalTheme,
} from "discourse/lib/theme-selector";

export default class SidebarThemeToggle extends Component {
  @service site;
  @service currentUser;
  @tracked availableThemes = listThemes(this.site);
  @tracked currentTheme = currentThemeId();

  @action
  setTheme(themeId, seq = 0) {
    this.currentTheme = themeId;

    if (this.currentUser) {
      this.currentUser.findDetails().then((user) => {
        seq = user.get("user_option.theme_key_seq");
        setLocalTheme([themeId], seq);
        window.location.reload();
      });
    } else {
      setLocalTheme([themeId], seq);
      window.location.reload();
    }
  }
}
