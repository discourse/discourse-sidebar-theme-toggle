import { apiInitializer } from "discourse/lib/api";
import SidebarThemeToggle from "../components/sidebar-theme-toggle";

export default apiInitializer((api) => {
  api.renderInOutlet("sidebar-footer-actions", SidebarThemeToggle);
});
