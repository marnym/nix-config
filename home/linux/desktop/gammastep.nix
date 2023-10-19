{ ... }:

{
  services.gammastep = {
    enable = true;
    temperature = {
      day = 6500;
      night = 2500;
    };
    provider = "manual";
    latitude = 60.2052;
    longitude = 24.6522;
    settings = {
      general = {
        fade = 0;
      };
    };
  };
}
