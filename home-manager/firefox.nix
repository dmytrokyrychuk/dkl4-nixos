{ config, pkgs, ... }: {
  programs.firefox.enable = true;
  programs.firefox.profiles = {
    default = {
      id = 0;
      name = "default";
      isDefault = true;
      extensions = with config.nur.repos.rycee.firefox-addons; [
        bitwarden
        tree-style-tab
      ];
      settings = {
        "browser.aboutConfig.showWarning" = false;
        "browser.newtabpage.enabled" = false; # Make new tabs blank
        "browser.startup.page" = 3; # Open previous windows and tabs
        "cookiebanners.ui.desktop.enabled" = true; # Reject cookie popups
        "dom.forms.autocomplete.formautofill" = false; # Disable autofill
        "dom.payments.defaults.saveAddress" = false; # Disable address save
        "extensions.formautofill.creditCards.enabled" = false; # Disable credit cards
        "extensions.pocket.enabled" = false;
        "general.autoScroll" = true; # Drag middle-mouse to scroll
        "services.sync.prefs.sync.general.autoScroll" = false; # Prevent disabling autoscroll
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true; # Allow userChrome.css
        "trailhead.firstrun.didSeeAboutWelcome" = true; # Disable welcome splash
      };
    };
  };
}
