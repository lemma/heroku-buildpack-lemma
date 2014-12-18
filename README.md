# Heroku buildpack: Lemma

This is a [Heroku buildpack][buildpacks] that configures your app to use the
[Lemma load balancer Heroku add-on][lemma-addon]. To do so, it installs the
`lemmad` coprocess and configures your `web` dynos to use it in your `Procfile`.
This buildpack will also ensure that you have the latest `lemmad` coprocess each
time you deploy.

Because you'll still need to use your app's existing buildpack, this buildpack
depends on the [multi buildpack][multi-buildpack].

## Usage

### Add the Lemma add-on

To use this buildpack you'll first need to install the Lemma add-on on your
Heroku app:

```bash
$ heroku addons:add lemma
```

### Configure the multi buildpack

Next, set the multi buildpack as your custom buildpack:

```bash
$ heroku config:add BUILDPACK_URL=https://github.com/heroku/heroku-buildpack-multi.git
```

#### Determine which buildpack your app currently uses

Identify the language buildpack for your app from the `BUILDPACK_URL`
config setting:

```term
$ heroku config:get BUILDPACK_URL
https://github.com/heroku/heroku-buildpack-LANG.git
```

If the output of this command is blank, your app uses a default buildpack
automatically detected by Heroku. In this case you will need to lookup the
buildpack URL by language in the [default buildpacks table][default-buildpack].

#### Create your `.buildpacks` file

From here you will need to create a `.buildpacks` file which contains (in order)
the buildpacks you wish to run when you deploy:

```bash
$ cat .buildpacks
https://github.com/heroku/heroku-buildpack-LANG.git
https://github.com/lemma/heroku-buildpack-lemma.git
```

If your app already uses the multi buildpack, just add an entry for
`heroku-buildpack-lemma` as shown above.

#### Save the changes

Commit the changes to the `.buildpacks` file in git:

```bash
$ git add .buildpacks
$ git commit -m "enable the Lemma buildpack"
```

### Push the changes

Then push your changes up to Heroku:

```bash
$ git push heroku master
Initializing repository, done.
...
-----> Fetching custom git buildpack... done
-----> Multipack app detected
=====> Downloading Buildpack: https://github.com/heroku/heroku-buildpack-LANG.git
...
=====> Downloading Buildpack: https://github.com/lemma/heroku-buildpack-lemma.git
=====> Detected Framework: Lemma
-----> Fetching lemmad coprocess... done
-----> Inserting lemmad in Procfile... done
...
-----> Compressing... done, 21.9MB
-----> Launching... done, v6
       http://lemma-demo-43.herokuapp.com/ deployed to Heroku

To git@heroku.com:lemma-demo-43.git
 * [new branch]      master -> master
```

## License

MIT

[buildpacks]: http://devcenter.heroku.com/articles/buildpacks "Heroku Buildpacks"
[default-buildpack]: https://devcenter.heroku.com/articles/buildpacks#default-buildpacks
[lemma-addon]: https://addons.heroku.com/lemma "Lemma Add-on"
[multi-buildpack]: https://github.com/heroku/heroku-buildpack-multi "Heroku Multi Buildpack"
