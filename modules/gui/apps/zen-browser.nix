{ inputs, config, lib, ... }:
let
  cfg = config.gui.apps.zen-browser;
in
{
  imports = [
    inputs.zen-browser.homeModules.twilight
  ];

  options.gui.apps.zen-browser = {
    enable = lib.mkEnableOption "Enables zen-browser";
  };
  config = lib.mkIf cfg.enable {
    home-manager.sharedModules = [ {
      programs.zen-browser = {
        enable = true;
        policies = {
          Preferences = {
            "general.autoScroll"."Value" = true;
            "browser.startup.page" = 3;
            "media.ffmpeg.vaapi.enabled" = true;
            "gfx.webrender.all" = true;
            "media.eme.enabled" = true;
            "media.gmp-widevinecdm.enabled" = true;
            "media.gmp-widevinecdm.visible" = true;
          };
          AutofillAddressEnabled = true;
          AutofillCreditCardEnabled = false;
          DisableAppUpdate = true;
          DisableFeedbackCommands = true;
          DisableFirefoxStudies = true;
          DisablePocket = true;
          DisableTelemetry = true;
          NoDefaultBookmarks = true;
          OfferToSaveLogins = false;
          EnableTrackingProtection = {
            Value = true;
            Locked = true;
            Cryptomining = true;
            Fingerprinting = true;
          };
        };
      };
    } ];
  };
}
