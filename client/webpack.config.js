var webpack = require('webpack');

module.exports = {
  entry: './app/app.js.coffee',
  output: {
    path: __dirname + '/build',
    filename: 'app.bundle.js'
  },
  devtool: 'source-map',
  watch: true,
  module: {
    loaders: [
      { test: /\.coffee$/, loader: 'coffee-loader' },
      { test: /\.html$/, loader: 'raw-loader' }
    ]
  },
  resolve: {
    modulesDirectories: ["node_modules", "bower_components"]
  },
  plugins: [
    new webpack.ResolverPlugin(
      new webpack.ResolverPlugin.DirectoryDescriptionFilePlugin(".bower.json", ["main"])
    )
  ]
};
