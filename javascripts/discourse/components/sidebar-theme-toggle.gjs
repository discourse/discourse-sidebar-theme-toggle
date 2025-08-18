import Component from "@glimmer/component";
import { tracked } from "@glimmer/tracking";
import { hash } from "@ember/helper";
import { action } from "@ember/object";
import { service } from "@ember/service";
import icon from "discourse/helpers/d-icon";
import {
  currentThemeId,
  listThemes,
  setLocalTheme,
} from "discourse/lib/theme-selector";
import ComboBox from "select-kit/components/combo-box";

export default class SidebarThemeToggle extends Component {
  @service site;
  @service currentUser;

  @tracked availableThemes = listThemes(this.site);
  @tracked currentTheme = currentThemeId();
  @tracked hasThemes = this.availableThemes?.length > 1;

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

  <template>
    {{#if this.hasThemes}}
      <div class="sidebar-theme-toggle__wrapper">
        {{icon settings.toggle_icon}}

        <ComboBox
          @content={{this.availableThemes}}
          @value={{this.currentTheme}}
          @onChange={{this.setTheme}}
          class="sidebar-theme-toggle-dropdown"
          @options={{hash placementStrategy="absolute" placement="top-start"}}
        />
      </div>
    {{/if}}
  </template>
}
