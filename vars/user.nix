{
  # TODO: load as a command argument.
  myself = "ssm";
  users = {
    ssm = {
      name = "Son Sumin";
      email = "clvswft03@gmail.com";
      # hostname = "clv-mba-m1"; # TODO: add and use it to define hostname.
      sshKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOfO8hAv7UrGUPE8PkG69TDCF+6C5q//cDNCIx78Hxap ssm@clv-mba-m1.local";
    };
    srid = {
      name = "Sridhar Ratnakumar";
      email = "srid@srid.ca";
      # Legacy
      # "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCYQ003p7fB5ICQehLwhDBomY9WzkNBeijkSw9ADGU+ECrPakeIH3pntUWRJH1W93vKnLqpkn6HLGEXD9MCR0s98uhh8hT7uAYCxQTbEeKT3PYkfz3oe7XaR8rE601sds0ZyFwH7l8cvK97pGr+uhFXAaohiV6VqmLVXhManEjZZ8GfYWBD9BCmIJk43G3OGa5QYFeHqztprXaJNU5dFPv2Uq2C+L6EvfCfkK2OO1BLZgL+Rai5jjyy6k0fcfsxxd9BdGUwqDhcBeyTIzX9rePMugf/xD+6uNRxTU+vjVpGUtFOw6rpgmVyFv9mn3QMNdQBc5hYKVbIQwMNGTzGgcQv srid@nixos"
      sshKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHQRxPoqlThDrkR58pKnJgmeWPY9/wleReRbZ2MOZRyd";
    };
  };
}
