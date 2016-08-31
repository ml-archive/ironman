const elixir = require('laravel-elixir');

/*
 |--------------------------------------------------------------------------
 | Elixir Asset Management
 |--------------------------------------------------------------------------
 |
 | Elixir provides a clean, fluent API for defining some basic Gulp tasks
 | for your Laravel application. By default, we are compiling the Sass
 | file for our application, as well as publishing vendor resources.
 |
 */

// Path to App folder
elixir.appPath = "App";

// Path to public folder
elixir.publicPath = "Public";

// Path to assets folder
elixir.assetsPath = "Resources/Assets";

// Path to views folder
elixir.viewsPath = "Resources/Views";

elixir(mix => {
       mix.sass("app.scss")
       .scripts([
           "app.js"
       ])
});
