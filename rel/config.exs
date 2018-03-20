use Mix.Releases.Config,
    # This sets the default release built by `mix release`
    default_release: :default,
    # This sets the default environment used by `mix release`
    default_environment: :dev

# For a full list of config options for both releases
# and environments, visit https://hexdocs.pm/distillery/configuration.html


# You may define one or more environments in this file,
# an environment's settings will override those of a release
# when building in that environment, this combination of release
# and environment configuration is called a profile

environment :dev do
  set dev_mode: true
  set include_erts: false
  set cookie: :"0k:>JSO$94/0TA.8X;fV`(op)6^:[4`:1Gs}N8F4I&h)<=Q?XRizBDQ]wxidSoPH"
end

environment :prod do
  set include_erts: true
  set include_src: false
  set cookie: :"ykK<|EgI0d.j99^:Zn1BsL(9l46*tF[N0K2mQ!EVTBgw;uc2Sxd2aMw[FME&;^69"
end

# You may define one or more releases in this file.
# If you have not set a default release, or selected one
# when running `mix release`, the first release in the file
# will be used by default

release :poller do
  set version: current_version(:poller)
end

