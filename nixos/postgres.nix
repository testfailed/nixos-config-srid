{ pkgs, lib, ... }:
{
  # psql -U $(whoami) -d postgres
  #
  # CREATE USER $(whoami) WITH PASSWORD 'yourpassword';
  # ALTER USER $(whoami) CREATEDB;

  # PostgreSQL itself
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql;
    # package = pkgs.postgresql_12; # HACK: for work
    # package = pkgs.postgresql_16_jit; # HACK: for work
    # dataDir = "/var/lib/postgresql";
    dataDir = "/usr/local/var/postgresql";

    # enableTCPIP = false;
    # ensureDatabases = [ "nixcloud" "mydatabase" ];

    # https://nixos.wiki/wiki/PostgreSQL

    authentication = pkgs.lib.mkOverride 10
      ''
        # Unix domain socket
        local all all trust

        # TCP/IP connections from loopback only
        host all all ::1/128 trust
      '';

    settings = {
      log_connections = true;
      log_statement = "all";
      logging_collector = true;
      log_disconnections = true;
      log_destination = lib.mkForce "syslog";
      unix_socket_directories = "/tmp";
    };

    # initialScript = pkgs.writeText "backend-initScript" ''
    #   CREATE ROLE nixcloud WITH LOGIN PASSWORD 'nixcloud' CREATEDB;
    #   CREATE DATABASE nixcloud;
    #   GRANT ALL PRIVILEGES ON DATABASE nixcloud TO nixcloud;
    # '';
  };
}
