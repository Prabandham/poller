# Poller.

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

# Development Environment setup.

* Install Elixir and Phoneinx
* Install IntelliJ CM edition.
* Install the Elixir Plugin.
* Import project and select this folder on the filesystem.
* Run through the setup and when it asks to configure the SDK Choose Elixir and setup the appropriate mix and Elixir paths.
* NOTE along with a clone / pull of the project _For the first time_ it is necessary to do a `git fetch` in order to get all release tags as well. 
  Otherwise the `get_current_version` will crib and will fail.
* `mix deps.get`
* `mix ecto.create`
* `mix exto.migrate`
* `mix run priv/repo/seeds.eex` This will see around 100 users and some polls along with questions :)

# Deploymnet.

    For now nothing has been decided. But all deploys will be done based on tags. 
    This is important as the `mix version` for the application will be set based on that automatically. 
    
    
    So when making a deployment make sure you create a tag with this command. 
    `git tag --annotate v1.0 --message 'Description of what this deployment does ..'`

