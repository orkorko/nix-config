let
  eka = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHT1kiENWrMVsBMxl5vga41V3qrmIxVyErxikpdnnNXA";
  a = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBxMwBM5LodaHAgaa73R26suGXAd5kL3IgEfR2GoWxcP a@anu";
  users = [ anu ];

  yana = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKpO6WYWKEl0fGH9EUOmrCSY9wRjwFjJpWg90dE5bejc root@nebula";
  anu = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHuvKZRMGzxlY1ktB1u4585qnQSchYKmqESiI/MTLJeR root@anu";
  systems = [ yana anu ];
in
{
  "eka.password.age".publicKeys = [ eka yana ];
  "yana.id.age".publicKeys = [ eka yana ];
  "a.password.age".publicKeys = [ a anu ];
  "anu.id.age".publicKeys = [ a ] ++ systems;
  "miniflux.age".publicKeys = systems ++ [ a ];
}
