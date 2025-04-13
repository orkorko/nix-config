let
  eka = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN9BeDtO6THu/58Bprj8pq8MqMR1j3OYYb0XVWBSpDmS eka@yana";
  a = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBxMwBM5LodaHAgaa73R26suGXAd5kL3IgEfR2GoWxcP a@anu";
  disk = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJaOzgodKt94vnpM70DHyMD8UliTN7+vWQfFBv1oWfao disk@floppy";
  users = [ eka disk ];

  yana = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKpO6WYWKEl0fGH9EUOmrCSY9wRjwFjJpWg90dE5bejc root@nebula";
  anu = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHuvKZRMGzxlY1ktB1u4585qnQSchYKmqESiI/MTLJeR root@anu";
  floppy = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMWYlpcJY2bf4veyMhAouQDPPLPDzpRmiMaKQqqZYnzC root@floppy";
  systems = [ yana anu ];
in
{
  "eka.password.age".publicKeys = [ eka yana ];
  "yana.id.age".publicKeys = [ eka yana ];
  "a.password.age".publicKeys = [ a anu ];
  "anu.id.age".publicKeys = [ a ] ++ systems;
  "disk.password.age".publicKeys = [ disk floppy ];
  "floppy.id.age".publicKeys = systems;
  "floppy.cert.age".publicKeys = [ disk floppy ];
  "floppy.key.age".publicKeys = [ disk floppy ];
  "nextcloud-admin.password.age".publicKeys = users ++ systems;
  "miniflux.age".publicKeys = systems ++ [ a ];
}
